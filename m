Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EA35BB9B3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 19:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIQRGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 13:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIQRGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 13:06:13 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF792ED6E
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 10:06:10 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x27so7135189lfu.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 10:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=aOhRJm/wnhI58kMCMcTqCulmL0KdgvuvW1CJN1yVB/M=;
        b=aKv3Le0YVUplkAj8yG0/xCB+gx4KThICjUmUiwMQBQJWVsL9RHIM7HUeJiMj1liGsJ
         S8eGOsZph7Tgq/pZBbwXyjFsb5SlbJpv0fPcX2DEjXMxnsCMBXI1J1jdrqQghuwxOoa7
         U8WGPVfacoiPQo7H44Zgfw+1hdwjmspYw52kd62EfnH3Qpv5SEyyVh1SZOoUhJ2SIcDj
         FFTbw2Zrl3gEMOAfANd02BznUHzl5tUqb9JP4UUsouXqXrNjKSGzT/IkHUfNaXUrj+ZI
         1EbmFMInGdE6uXDFenhn1lhaEUdP0WfChYICFsxaoeTdAhCW7NQJLhZvy/jS9tQYmQ5u
         XVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=aOhRJm/wnhI58kMCMcTqCulmL0KdgvuvW1CJN1yVB/M=;
        b=uQGLKsoH7KkCHCqCUyw2XvO8AuIlGPCZfBeZkVek99CUWyNrws7EpUDnroDNoiHjLE
         xFTeZEbzSBrnQDlgbZL9e+l1wEiedZdYEFVvLTBjGvZzqc34gucuWougdf8Sb5wX1XsO
         hAeN6nvSjUzZnEV/MQWS/9bEIi8gZ26jmxjJW9kIsunQ4IHY3UyzPtYdyFLdGR34BHGK
         /Z62MW2OWzktfNrsTh1WVwhXmOvzisfOsGu34nTdebEb1fH+ruCrjYcFn7/vh++sxrpN
         fBqUhVdvoHBfQr8hchFFc3DbjhTZ8gIP1/8hBdAltIOks3xZq9DdGz1i07uyvvdlM532
         JT8Q==
X-Gm-Message-State: ACrzQf1lpoRKLssy1+BNl2rIiJ22J0IumkMwC8AamPxa9IaHwkbqmmKL
        X2UHTyjaKHuiVpjD+Cd6c1nImA==
X-Google-Smtp-Source: AMsMyM5kt9pVpJyhQZGxHfUg3ogWePogwbXLV8v/gysMa4k66VFDg7NrlJBoehOQJr3q+uP35Bx6ig==
X-Received: by 2002:a05:6512:3e14:b0:499:1f71:1680 with SMTP id i20-20020a0565123e1400b004991f711680mr3321370lfv.114.1663434369298;
        Sat, 17 Sep 2022 10:06:09 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o5-20020ac24e85000000b004946a1e045fsm1663012lfr.197.2022.09.17.10.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 10:06:08 -0700 (PDT)
Message-ID: <0af42a45-a2f1-51d9-680e-5c770288dfe5@linaro.org>
Date:   Sat, 17 Sep 2022 18:06:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/2] ARM: dts: qcom: Add support for Huawei Watch
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220917152829.23568-1-luca@z3ntu.xyz>
 <20220917152829.23568-2-luca@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220917152829.23568-2-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2022 16:28, Luca Weiss wrote:
> Add support for this smartwatch, based on Snapdragon 400 SoC.
> 
> Currently supported functionality:

Thank you for your patch. There is something to discuss/improve.

> * Internal storage
> * USB
> * Charger
> * Power button
> * Bluetooth
> * Wifi
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/qcom-apq8026-huawei-sturgeon.dts | 343 ++++++++++++++++++
>  2 files changed, 344 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 3bc6bd5c8238..55087f16d718 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1026,6 +1026,7 @@ dtb-$(CONFIG_ARCH_OXNAS) += \
>  dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-apq8016-sbc.dtb \
>  	qcom-apq8026-asus-sparrow.dtb \
> +	qcom-apq8026-huawei-sturgeon.dtb \
>  	qcom-apq8026-lg-lenok.dtb \
>  	qcom-apq8060-dragonboard.dtb \
>  	qcom-apq8064-cm-qs600.dtb \
> diff --git a/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts b/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts
> new file mode 100644
> index 000000000000..e43fcef7144c
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts
> @@ -0,0 +1,343 @@
> +// SPDX-License-Identifier: BSD-3-Clause

No GPL at all?

> +/*
> + * Copyright (c) 2022, Luca Weiss <luca@z3ntu.xyz>
> + */
> +
> +/dts-v1/;
> +
> +#include "qcom-msm8226.dtsi"
> +#include "qcom-pm8226.dtsi"
> +
> +/delete-node/ &adsp_region;
> +
> +/ {
> +	model = "Huawei Watch";
> +	compatible = "huawei,sturgeon", "qcom,apq8026";
> +	chassis-type = "watch";
> +	qcom,msm-id = <199 0x20000>;
> +	qcom,board-id = <8 4>;
> +
> +	reserved-memory {
> +		sbl_region: sbl@2f00000 {
> +			reg = <0x02f00000 0x100000>;
> +			no-map;
> +		};
> +		external_image_region: external-image@3100000 {
> +			reg = <0x3100000 0x200000>;
> +			no-map;
> +		};
> +		peripheral_region: peripheral@3300000 {
> +			reg = <0x3300000 0x600000>;
> +			no-map;
> +		};
> +		adsp_region: adsp@3900000 {
> +			reg = <0x3900000 0x1400000>;
> +			no-map;
> +		};
> +		modem_region: modem@4d00000 {
> +			reg = <0x4d00000 0x1b00000>;
> +			no-map;
> +		};
> +		modem_efs_region: modem-efs@7f00000 {
> +			reg = <0x7f00000 0x100000>;
> +			no-map;
> +		};
> +	};
> +
> +	vreg_wlan: wlan-regulator {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "wl-reg";
> +		regulator-min-microvolt = <2950000>;
> +		regulator-max-microvolt = <2950000>;
> +
> +		gpio = <&tlmm 110 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wlan_regulator_default_state>;
> +	};
> +};
> +
> +&adsp {
> +	status = "okay";
> +};
> +
> +&blsp1_i2c5 {
> +	status = "okay";
> +	clock-frequency = <384000>;
> +
> +	touchscreen@20 {
> +		compatible = "syna,rmi4-i2c";
> +		reg = <0x20>;
> +
> +		interrupts-extended = <&tlmm 17 IRQ_TYPE_EDGE_FALLING>;
> +		vdd-supply = <&pm8226_l19>;
> +		vio-supply = <&pm8226_lvs1>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&touch_default_state>;
> +
> +		syna,startup-delay-ms = <160>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		rmi4-f01@1 {
> +			reg = <0x1>;
> +			syna,nosleep-mode = <1>;
> +		};
> +
> +		rmi4-f12@12 {
> +			reg = <0x12>;
> +			syna,sensor-type = <1>;
> +		};
> +	};
> +};
> +
> +&blsp1_uart4 {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&blsp1_uart4_default_state>;
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43430a0-bt";
> +		max-speed = <3000000>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bluetooth_default_state>;
> +
> +		host-wakeup-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
> +		device-wakeup-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
> +		shutdown-gpios = <&tlmm 67 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&rpm_requests {
> +	pm8226-regulators {

This should be just regulators:
https://lore.kernel.org/all/20220901093243.134288-1-krzysztof.kozlowski@linaro.org/

Not yet merged but old node is also not documented.

> +		compatible = "qcom,rpm-pm8226-regulators";
> +
> +		pm8226_s3: s3 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1300000>;
> +		};
> +		pm8226_s4: s4 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2200000>;
> +		};
> +		pm8226_s5: s5 {
> +			regulator-min-microvolt = <1150000>;
> +			regulator-max-microvolt = <1150000>;
> +		};
> +
> +		pm8226_l1: l1 {
> +			regulator-min-microvolt = <1225000>;
> +			regulator-max-microvolt = <1225000>;
> +		};
> +		pm8226_l2: l2 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +		pm8226_l3: l3 {
> +			regulator-min-microvolt = <750000>;
> +			regulator-max-microvolt = <1337500>;
> +		};
> +		pm8226_l4: l4 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +		pm8226_l5: l5 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +		pm8226_l6: l6 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +		pm8226_l7: l7 {
> +			regulator-min-microvolt = <1850000>;
> +			regulator-max-microvolt = <1850000>;
> +		};
> +		pm8226_l8: l8 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +		pm8226_l9: l9 {
> +			regulator-min-microvolt = <2050000>;
> +			regulator-max-microvolt = <2050000>;
> +		};
> +		pm8226_l10: l10 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +		pm8226_l12: l12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +		pm8226_l14: l14 {
> +			regulator-min-microvolt = <2750000>;
> +			regulator-max-microvolt = <2750000>;
> +		};
> +		pm8226_l15: l15 {
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +		};
> +		pm8226_l16: l16 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3350000>;
> +		};
> +		pm8226_l17: l17 {
> +			regulator-min-microvolt = <2950000>;
> +			regulator-max-microvolt = <2950000>;
> +		};
> +		pm8226_l18: l18 {
> +			regulator-min-microvolt = <2950000>;
> +			regulator-max-microvolt = <2950000>;
> +		};
> +		pm8226_l19: l19 {
> +			regulator-min-microvolt = <2850000>;
> +			regulator-max-microvolt = <2850000>;
> +		};
> +		pm8226_l20: l20 {
> +			regulator-min-microvolt = <3075000>;
> +			regulator-max-microvolt = <3075000>;
> +		};
> +		pm8226_l21: l21 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2950000>;
> +		};
> +		pm8226_l22: l22 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2950000>;
> +		};
> +		pm8226_l23: l23 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2950000>;
> +		};
> +		pm8226_l24: l24 {
> +			regulator-min-microvolt = <1300000>;
> +			regulator-max-microvolt = <1350000>;
> +		};
> +		pm8226_l25: l25 {
> +			regulator-min-microvolt = <1775000>;
> +			regulator-max-microvolt = <2125000>;
> +		};
> +		pm8226_l26: l26 {
> +			regulator-min-microvolt = <1225000>;
> +			regulator-max-microvolt = <1225000>;
> +		};
> +		pm8226_l27: l27 {
> +			regulator-min-microvolt = <2050000>;
> +			regulator-max-microvolt = <2050000>;
> +		};
> +		pm8226_l28: l28 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2950000>;
> +		};
> +
> +		pm8226_lvs1: lvs1 {};
> +	};
> +};
> +
> +&sdhc_1 {
> +	status = "okay";
> +
> +	vmmc-supply = <&pm8226_l17>;
> +	vqmmc-supply = <&pm8226_l6>;
> +
> +	bus-width = <8>;
> +	non-removable;
> +};
> +
> +&sdhc_3 {
> +	status = "okay";
> +
> +	max-frequency = <100000000>;
> +	non-removable;
> +
> +	vmmc-supply = <&vreg_wlan>;
> +	vqmmc-supply = <&pm8226_l6>;
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	wifi@1 {
> +		compatible = "brcm,bcm43430a0-fmac", "brcm,bcm4329-fmac";
> +		reg = <1>;
> +
> +		interrupts-extended = <&tlmm 66 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-names = "host-wake";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wlan_hostwake_default_state>;
> +	};
> +};
> +
> +&smbb {
> +	qcom,fast-charge-safe-voltage = <4370000>;
> +	qcom,fast-charge-high-threshold-voltage = <4350000>;
> +	qcom,minimum-input-voltage = <4350000>;
> +	qcom,fast-charge-current-limit = <300000>;
> +	qcom,fast-charge-safe-current = <600000>;
> +	qcom,auto-recharge-threshold-voltage = <4240000>;
> +};
> +
> +&tlmm {
> +	blsp1_uart4_default_state: blsp1-uart4-default-state {
> +		pins = "gpio12", "gpio13", "gpio14", "gpio15";
> +		function = "blsp_uart4";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};
> +
> +	bluetooth_default_state: bluetooth-default-state {
> +		pins = "gpio63", "gpio64";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	touch_default_state: touch-default-state {
> +		irq {

Suffix: -pins

> +			pins = "gpio17";
> +			function = "gpio";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +		};
> +
> +		reset {

Ditto

> +			pins = "gpio16";
> +			function = "gpio";
> +			drive-strength = <6>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	wlan_hostwake_default_state: wlan-hostwake-default-state {
> +		pins = "gpio66";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		input-enable;
> +	};
> +
> +	wlan_regulator_default_state: wlan-regulator-default-state {
> +		pins = "gpio110";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +};

Best regards,
Krzysztof
