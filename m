Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E47362C21A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiKPPQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiKPPQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:16:42 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6E84FF94
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:16:40 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u24so26978253edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4wKdyWpTGv9s5gt784ghRI+LQ/q6knA5x3eZOJqgpM=;
        b=o30aV85ynPbYCL+7J4dC0/LrvGwQe5hOe1NvFeROqOQUqlIxtqb4sKKgfp4Of7rYdN
         XDwFCAX45VXd4HaxGEzuIYJ0MkTHfpO8NXoQ/V0uN5Y+0k7N3Lrdsjm9ZbgYsxbfA/h/
         k+jEnYmrDdcz80O/BMHcvdrAeohMtK6q+Pqyk6FOQP+/bcclesVN56NB0btbyrwMOIfD
         QwZOZuEcza4f8gS0HXK3C/HhqEbjDwJJ57tb3kswTOCShBqiT1M9OEBTf3qL1SaUZOFH
         CI2qekQFIvwFkDgCD2UBpjcoo7UMopgXg2rNvHNBGqTzpmOSMbOyzidDQ+JRXm9zo+kW
         XiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E4wKdyWpTGv9s5gt784ghRI+LQ/q6knA5x3eZOJqgpM=;
        b=LXCfhbfYgBf/DQm48GOWGKx6bFR53gr/hTKLMuBKjCaAfTAYMYv1zG+nLuQb0g7H92
         Qwte0z0z/NzrXJ77NX7gl9nyegLsVY/YYGFmFuoyNiQX6OPwQFraMClu+To99TAnB3pW
         RiIi+64WgbssSMSYRn5HIRy9uwIaTojog/GJ+LDe7Dq9p08gZa+sLTokzSraHpg8+xAN
         QXZ0SCZHGWJwcRUkziyVkHd1qzaKGxF6FG4kPSvD532JVHOEK4CfgbS5JEIoJPVYOppH
         +124Pl8cTDcaeLmB0zcF4THn8d7qFoccP4/1z7WEFGYG3R/6N4qERJAmdlKocOVw7fQS
         14XQ==
X-Gm-Message-State: ANoB5plBmVasOBN0DA4uoPu7wxehuh3I6gHzpgoowop/+u6dW8lhJwFo
        anEpqAjhxtq/V3WClQwsVkuR4g==
X-Google-Smtp-Source: AA0mqf54XhbN+OocmwoFdRViebBaJVzLNhV0DSK5uPkj1WYvIBp66+J1MxymSw9ofY+r7b0o1NGrLg==
X-Received: by 2002:aa7:c993:0:b0:461:4fd3:377f with SMTP id c19-20020aa7c993000000b004614fd3377fmr19228800edt.234.1668611799554;
        Wed, 16 Nov 2022 07:16:39 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id j19-20020a17090686d300b0073c80d008d5sm6870009ejy.122.2022.11.16.07.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 07:16:38 -0800 (PST)
Message-ID: <904bd243-0ebc-08fb-e4b9-77f7d4f4726d@linaro.org>
Date:   Wed, 16 Nov 2022 16:16:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 6/8] arm64: dts: qcom: msm8953: Add device tree for Xiaomi
 Mi A1
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
References: <20221116145616.17884-1-luca@z3ntu.xyz>
 <20221116145616.17884-7-luca@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116145616.17884-7-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2022 15:56, Luca Weiss wrote:
> From: Danila Tikhonov <JIaxyga@protonmail.com>
> 
> Add device tree for the Xiaomi Mi A1 (tissot) smartphone. This device is
> based on Snapdragon 625 (msm8953) SoC.
> 
> Co-developed-by: Anton Bambura <jenneron@protonmail.com>
> Signed-off-by: Anton Bambura <jenneron@protonmail.com>
> Signed-off-by: Danila Tikhonov <JIaxyga@protonmail.com>
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> ---
>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>   .../boot/dts/qcom/msm8953-xiaomi-tissot.dts   | 317 ++++++++++++++++++
>   2 files changed, 318 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 229fa48c8006..9517638b2fdd 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -24,6 +24,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-mido.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-tissot.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-101.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-msft-lumia-octagon-talkman.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts
> new file mode 100644
> index 000000000000..d0ee17dbe084
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts
> @@ -0,0 +1,317 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 The Linux Foundation. All rights reserved.
> + */
> +/dts-v1/;
> +
> +#include "msm8953.dtsi"
> +#include "pm8953.dtsi"
> +#include "pmi8950.dtsi"
> +#include <dt-bindings/leds/common.h>
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
> +		/delete-node/ memory@85b00000;
Same comments as in previous patches: this and possibly licensing.

Konrad
> +
> +		memory@84a00000 {
> +			reg = <0x0 0x84a00000 0x0 0x1900000>;
> +			no-map;
> +		};
> +
> +		adsp_fw_mem: memory@8d600000 {
> +			reg = <0x0 0x8d600000 0x0 0x1200000>;
> +			no-map;
> +		};
> +
> +		/delete-node/ memory@8e700000;
> +		wcnss_fw_mem: memory@8e800000 {
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
