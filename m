Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B71A632065
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiKULYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiKULXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:23:45 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6B2B9B85
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:19:03 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j4so18389632lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bze5QXBYXjq9sVr5fTXdpM72OqKUrY/P/hxFE+uIBv8=;
        b=dGszegw1FmC0qTLpX3ZL4U+6mUZcZ7NGjkCpRHgnDOTEFtYh98uu0CCCFtqvNtoMIg
         t/SpnLah8ZKzu9Z3hEULagTKmue2Rv5Np6S5xzEFyncZBY6Bpx2Xpx0uhdUAYfJuaBdk
         pUfxLaXTzJ9fNShpjYW8+SGn1mNWpDBXQx/8KD/zaeVXQEQvTDbbsox5H9kZs/FBFJAk
         nu1yPZYki6eg9TXfK9yUcNhRTMVkYwWHnoNfs/MM6CSESJ7lQZDx+oF3HpItfC8hrHEJ
         qN7U6ZbamKqbvy7YxA01evLIBhyyxvb7dajxyM/Uda3fry7bowMe9q7nBqrVpPk2tyMB
         qQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bze5QXBYXjq9sVr5fTXdpM72OqKUrY/P/hxFE+uIBv8=;
        b=aNUp3TzbOjhzqVkj56eNp/+4oBV3udB2LCR3iJV/k8Rn3BpVqZX1zI47+xKyiPlq9v
         oPwAz5CbZO7XB6SRn07hmXCu6WljbMnY20OrwxBrepIb6cRo3xiYDomx9DIlgnLwLZap
         UdCkbIA/VlhWeDndZ3MAT6Ra1QyowWdFfJihtMnjlQppv0bTfF79tevyToCEm5mURoeq
         tR37tCfQi1WzbUTdgek43bDlTdZpRtYYlOrFGZwxVSUshg7Aw2A/DhHNeCUvqO/N+HUE
         e0sGIYj6KZdLSarZixojfHfDAY/IY8cVdoFk3zUGQBLb/Khd0+LLsTdp/Ui13At/7FQ4
         rMnw==
X-Gm-Message-State: ANoB5pkUwhs/e7Rp8FzPXohVeFNY63iPFr5boUV3G5cc6LivaxYJFBpQ
        FI+lpf3Xtkib1XXHNooOyf9rvA==
X-Google-Smtp-Source: AA0mqf4mCaHzwXFhKlSjSqhcDaaqWGh5uIRlr7OAmYDj6cfe3/wl6fwXFnhLifAwXo6DgWiGW1feFQ==
X-Received: by 2002:a05:6512:3d05:b0:4a2:4f6d:7963 with SMTP id d5-20020a0565123d0500b004a24f6d7963mr6607092lfv.638.1669029541854;
        Mon, 21 Nov 2022 03:19:01 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id c4-20020ac25304000000b0049fff3f645esm1969937lfh.70.2022.11.21.03.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:19:01 -0800 (PST)
Message-ID: <ed803985-11df-4aed-7ea7-492e90775f66@linaro.org>
Date:   Mon, 21 Nov 2022 12:18:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 7/9] arm64: dts: qcom: msm8953: Add device tree for
 Xiaomi Mi A1
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Danila Tikhonov <JIaxyga@protonmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20221119203758.888207-1-luca@z3ntu.xyz>
 <20221119203758.888207-8-luca@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221119203758.888207-8-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.11.2022 21:37, Luca Weiss wrote:
> From: Danila Tikhonov <JIaxyga@protonmail.com>
> 
> Add device tree for the Xiaomi Mi A1 (tissot) smartphone. This device is
> based on Snapdragon 625 (msm8953) SoC.
> 
> Co-developed-by: Anton Bambura <jenneron@protonmail.com>
> Signed-off-by: Anton Bambura <jenneron@protonmail.com>
> Signed-off-by: Danila Tikhonov <JIaxyga@protonmail.com>
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes in v2:
> * address review comments from v1
> 
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/msm8953-xiaomi-tissot.dts   | 319 ++++++++++++++++++
>  2 files changed, 320 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index cd667df63326..f93e5cf062e5 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -24,6 +24,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-mido.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-tissot.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-msft-lumia-octagon-talkman.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts
> new file mode 100644
> index 000000000000..7c3b809cc551
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts
> @@ -0,0 +1,319 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Danila Tikhonov <JIaxyga@protonmail.com>
> + * Copyright (c) 2022, Anton Bambura <jenneron@protonmail.com>
> + */
> +/dts-v1/;
> +
> +#include "msm8953.dtsi"
> +#include "pm8953.dtsi"
> +#include "pmi8950.dtsi"
> +#include <dt-bindings/leds/common.h>
> +
> +/delete-node/ &adsp_fw_mem;
> +/delete-node/ &qseecom_mem;
> +/delete-node/ &wcnss_fw_mem;
> +
> +/ {
> +	model = "Xiaomi Mi A1";
> +	compatible = "xiaomi,tissot", "qcom,msm8953";
> +	chassis-type = "handset";
> +	qcom,msm-id = <293 0>;
> +	qcom,board-id = <0x1000b 0x00>;
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_key_default>, <&gpio_hall_sensor_default>;
> +
> +		event-hall-sensor {
> +			label = "Hall Effect Sensor";
> +			gpios = <&tlmm 44 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <EV_SW>;
> +			linux,code = <SW_LID>;
> +			linux,can-disable;
> +		};
> +
> +		key-volume-up {
> +			label = "Volume Up";
> +			gpios = <&tlmm 85 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +		};
> +	};
> +
> +	reserved-memory {
> +		qseecom_mem: qseecom@84a00000 {
> +			reg = <0x0 0x84a00000 0x0 0x1900000>;
> +			no-map;
> +		};
> +
> +		adsp_fw_mem: adsp@8d600000 {
> +			reg = <0x0 0x8d600000 0x0 0x1200000>;
> +			no-map;
> +		};
> +
> +		wcnss_fw_mem: wcnss@8e800000 {
> +			reg = <0x0 0x8e800000 0x0 0x700000>;
> +			no-map;
> +		};
> +
> +		ramoops@9ff00000 {
> +			compatible = "ramoops";
> +			reg = <0x0 0x9ff00000 0x0 0x00100000>;
> +			record-size = <0x1000>;
> +			console-size = <0x80000>;
> +			ftrace-size = <0x1000>;
> +			pmsg-size = <0x8000>;
> +		};
> +	};
> +
> +	vph_pwr: vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&hsusb_phy {
> +	vdd-supply = <&pm8953_l3>;
> +	vdda-pll-supply = <&pm8953_l7>;
> +	vdda-phy-dpdm-supply = <&pm8953_l13>;
> +
> +	status = "okay";
> +};
> +
> +&i2c_2 {
> +	status = "okay";
> +
> +	max98927_codec: audio-codec@3a {
> +		compatible = "maxim,max98927";
> +		reg = <0x3a>;
> +
> +		reset-gpios = <&tlmm 86 GPIO_ACTIVE_LOW>;
> +
> +		vmon-slot-no = <1>;
> +		imon-slot-no = <1>;
> +
> +		#sound-dai-cells = <1>;
> +	};
> +
> +	led-controller@45 {
> +		compatible = "awinic,aw2013";
> +		reg = <0x45>;
> +
> +		vcc-supply = <&pm8953_l10>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led@0 {
> +			reg = <0>;
> +			led-max-microamp = <5000>;
> +			function = LED_FUNCTION_INDICATOR;
> +			color = <LED_COLOR_ID_WHITE>;
> +		};
> +	};
> +};
> +
> +&i2c_3 {
> +	status = "okay";
> +
> +	touchscreen@38 {
> +		compatible = "edt,edt-ft5406";
> +		reg = <0x38>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <65 IRQ_TYPE_EDGE_FALLING>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ts_int_default>;
> +
> +		reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
> +
> +		vcc-supply = <&pm8953_l10>;
> +
> +		touchscreen-size-x = <1080>;
> +		touchscreen-size-y = <1920>;
> +	};
> +};
> +
> +&pm8953_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
> +};
> +
> +&pmi8950_wled {
> +	qcom,num-strings = <2>;
> +	qcom,external-pfet;
> +	qcom,cabc;
> +
> +	status = "okay";
> +};
> +
> +&sdhc_1 {
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
> +	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
> +
> +	cd-gpios = <&tlmm 133 GPIO_ACTIVE_HIGH>;
> +
> +	status = "okay";
> +};
These two are not sorted properly.

With that fixed:
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +
> +&rpm_requests {
> +	regulators {
> +		compatible = "qcom,rpm-pm8953-regulators";
> +
> +		vdd_s1-supply = <&vph_pwr>;
> +		vdd_s2-supply = <&vph_pwr>;
> +		vdd_s3-supply = <&vph_pwr>;
> +		vdd_s4-supply = <&vph_pwr>;
> +		vdd_s5-supply = <&vph_pwr>;
> +		vdd_s6-supply = <&vph_pwr>;
> +		vdd_s7-supply = <&vph_pwr>;
> +		vdd_l1-supply = <&pm8953_s3>;
> +		vdd_l2_l3-supply = <&pm8953_s3>;
> +		vdd_l4_l5_l6_l7_l16_l19-supply = <&pm8953_s4>;
> +		vdd_l8_l11_l12_l13_l14_l15-supply = <&vph_pwr>;
> +		vdd_l9_l10_l17_l18_l22-supply = <&vph_pwr>;
> +
> +		pm8953_s1: s1 {
> +			regulator-min-microvolt = <870000>;
> +			regulator-max-microvolt = <1156000>;
> +		};
> +
> +		pm8953_s3: s3 {
> +			regulator-min-microvolt = <1224000>;
> +			regulator-max-microvolt = <1224000>;
> +		};
> +
> +		pm8953_s4: s4 {
> +			regulator-min-microvolt = <1900000>;
> +			regulator-max-microvolt = <2050000>;
> +		};
> +
> +		pm8953_l1: l1 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1000000>;
> +		};
> +
> +		pm8953_l2: l2 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1225000>;
> +		};
> +
> +		pm8953_l3: l3 {
> +			regulator-min-microvolt = <925000>;
> +			regulator-max-microvolt = <925000>;
> +		};
> +
> +		pm8953_l5: l5 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8953_l6: l6 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8953_l7: l7 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1900000>;
> +		};
> +
> +		pm8953_l8: l8 {
> +			regulator-min-microvolt = <2900000>;
> +			regulator-max-microvolt = <2900000>;
> +		};
> +
> +		pm8953_l9: l9 {
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +
> +		pm8953_l10:l10 {
> +			regulator-min-microvolt = <2850000>;
> +			regulator-max-microvolt = <2850000>;
> +		};
> +
> +		pm8953_l11: l11 {
> +			regulator-min-microvolt = <2950000>;
> +			regulator-max-microvolt = <2950000>;
> +		};
> +
> +		pm8953_l12: l12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2950000>;
> +		};
> +
> +		pm8953_l13: l13 {
> +			regulator-min-microvolt = <3125000>;
> +			regulator-max-microvolt = <3125000>;
> +		};
> +
> +		pm8953_l16: l16 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8953_l17: l17 {
> +			regulator-min-microvolt = <2750000>;
> +			regulator-max-microvolt = <2850000>;
> +		};
> +
> +		pm8953_l19: l19 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1350000>;
> +		};
> +
> +		pm8953_l22: l22 {
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +		};
> +
> +		pm8953_l23: l23 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1225000>;
> +		};
> +	};
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <16 4>, <135 4>;
> +
> +	gpio_hall_sensor_default: gpio-hall-sensor-state {
> +		pins = "gpio44";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	ts_int_default: ts-int-default-state {
> +		pins = "gpio65";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +};
> +
> +&uart_0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart_console_active>;
> +
> +	status = "okay";
> +};
> +
> +&usb3 {
> +	status = "okay";
> +};
> +
> +&usb3_dwc3 {
> +	dr_mode = "peripheral";
> +};
