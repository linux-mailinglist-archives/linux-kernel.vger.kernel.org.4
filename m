Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788F6678138
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjAWQTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjAWQTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:19:18 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBF8EB56
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:19:15 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id rl14so28561631ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9RwzVjGhokVRls3E5a/A2Pxx76BYNJN2Jyv9IOWVcx8=;
        b=nWItICmqkeVcWCgU1nUsx3shbqRMtZZO7ZHNHKuisQg9gPmpkQTocXYGRz8tp7UK4c
         BzRfxw/FPJSZSwZgLljPzzHPjlTaea7GMlwZ0x9IahAQMmkr0YCYTIxVRSsMCNQ7BsB3
         vp4EGV7d1+aHejiDDgrF6pKoFK7HKs1EL9S3E3oPRl8iHqe4DFINh+wZqW72c/ukwruW
         GUw4cqLYJLkFqMeP+E4KrEMqEyPFhiaM/CXmuYeeJdVlKBOJnBpHC1l4JRj8NnVa1iR2
         9D2bDXJUJLQDfTp0oEHY/+Ol2Llbmy7mVRn0S17W4h24fxpVWH5zQVBUWNPuo3krr5ME
         ZOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9RwzVjGhokVRls3E5a/A2Pxx76BYNJN2Jyv9IOWVcx8=;
        b=g2aX5paV2JbEK2VgzKRUfb5fkrBRKKWBHCiWnE5g9yBrte6Madn5wqE6NvAmMTuuvU
         2Wmaebwh5FTLg+7maaThTmBDDZ6vy9IKAPOKCaZYBq/KXK0ov4M4WTJt2pFrV2u2tzBg
         ion1I7noBlFnDiT6SRgsPh156GqcTpB8iHK++zSXEjyVwFG4lHSrmE4NHkUaBOYoYCf1
         apb6H+Re8K+pHfC/B0ma7pZKkeaP5YETQKYABI9GavjT68qT6qvZ036KvAAa55jwZrEx
         Y7lFGe6YbDFZycc0gDNuP4oM89rUErJdymEJb6IJF441RGwwSbSFY9IVzYLX8eqO1ASD
         Vwmw==
X-Gm-Message-State: AFqh2kraa6U+8J6oR00Fug/zjIFIDgvJ5QrFK9nISBJ5g6aKw0rKhLPw
        6ar7hL/IxTRKfV9O+dHBHCj4tg==
X-Google-Smtp-Source: AMrXdXsVHcxkDtiRfcBmYuL40wO5tIicsAGzvEhmqcrtOLK8tJZX1cmw3clk3YaQjojqnXac68yrZQ==
X-Received: by 2002:a17:906:40d7:b0:86d:4517:a4fa with SMTP id a23-20020a17090640d700b0086d4517a4famr26981625ejk.1.1674490753746;
        Mon, 23 Jan 2023 08:19:13 -0800 (PST)
Received: from [192.168.1.101] (abxi24.neoplus.adsl.tpnet.pl. [83.9.2.24])
        by smtp.gmail.com with ESMTPSA id hq15-20020a1709073f0f00b0084c4b87a69csm22291483ejc.153.2023.01.23.08.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 08:19:13 -0800 (PST)
Message-ID: <4f93929b-6076-cbb3-3d34-242ce6fa580f@linaro.org>
Date:   Mon, 23 Jan 2023 17:19:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: Add msm8939 Sony Xperia M4 Aqua
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        stephan@gerhold.net
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
 <20230123023127.1186619-7-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230123023127.1186619-7-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.01.2023 03:31, Bryan O'Donoghue wrote:
> Add a basic booting DTS for the Sony Xperia M4 Aqua aka "tulip".
> 
> Tulip is paired with:
> 
> - wcn3660
> - smb1360 battery charger
> - 720p Truly NT35521 Panel
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../qcom/msm8939-sony-xperia-kanuti-tulip.dts | 453 ++++++++++++++++++
>  2 files changed, 454 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 73ff8d3213d99..1df3dbaf8a6d8 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5x.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-sony-xperia-kanuti-tulip.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-mido.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
> new file mode 100644
> index 0000000000000..841d88fe3659f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
> @@ -0,0 +1,453 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022-2023, Bryan O'Donoghue.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "msm8939.dtsi"
> +#include "msm8939-pm8916.dtsi"
> +#include <dt-bindings/arm/qcom,ids.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +
> +/ {
> +	model = "Sony Xperia M4 Aqua";
> +	compatible = "sony,kanuti-tulip", "qcom,msm8939";
> +
> +	qcom,board-id = <8 0>;
> +	qcom,msm-id = <QCOM_ID_MSM8939 0>, <QCOM_ID_MSM8939 0x30000>, <QCOM_ID_APQ8039 0x30000>;
I doubt a phone shipped with apq..

> +
> +	aliases {
> +		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
> +		mmc1 = &sdhc_2; /* SDC2 SD card slot */
> +		serial0 = &blsp1_uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	negative5_reg: negative5-regulator {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&negative5_reg_default>;
pinctrl-0
pinctrl-names

please

> +		regulator-name = "negative5_reg";
> +		gpio = <&tlmm 17 GPIO_ACTIVE_LOW>;
> +		startup-delay-us = <0>;
> +	};
> +
> +	positive5_reg: positive5-regulator {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&positive5_reg_default>;
> +		regulator-name = "positive5_reg";
> +		gpio = <&tlmm 114 GPIO_ACTIVE_LOW>;
> +		startup-delay-us = <0>;
> +	};
> +
> +	usb_id: usb-id {
> +		compatible = "linux,extcon-usb-gpio";
> +		id-gpio = <&tlmm 110 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_id_default>;
> +	};
> +};
> +
> +&dsi0 {
> +	status = "okay";
> +
> +	panel@0 {
> +		compatible = "sony,tulip-truly-nt35521";
> +		reg = <0>;
> +		positive5-supply = <&positive5_reg>;
> +		negative5-supply = <&negative5_reg>;
> +		reset-gpios = <&tlmm 25 GPIO_ACTIVE_LOW>;
> +		enable-gpios = <&tlmm 10 GPIO_ACTIVE_LOW>;
> +
> +		ports {
> +			port {
> +				panel_in: endpoint {
> +					remote-endpoint = <&dsi0_out>;
> +				};
> +			};
> +		};
> +
> +	};
> +};
> +
> +&dsi0_out {
> +	remote-endpoint = <&panel_in>;
> +	data-lanes = <0 1 2 3>;
> +};
> +
> +&dsi_phy0 {
> +	qcom,dsi-phy-regulator-ldo-mode;
> +	status = "okay";
> +};
> +
> +&tlmm {
> +	ak8963_default: ak8963-default-state {
> +		pins = "gpio69";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-up;
> +	};
> +
> +	ak8963_sleep: ak8963-sleep-state {
> +		pins = "gpio69";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	/* Ambient light and proximity sensor apds9930 and apds9900 */
> +	apds99xx_default: apds99xx-default-state {
> +		pins = "gpio113";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-up;
> +	};
> +
> +	apds99xx_sleep: apds99xx-sleep-state {
> +		pins = "gpio113";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	cam_sensor_flash_default: cam-sensor-flash-default-state {
> +		pins = "gpio98", "gpio97";
> +		function = "gpio";
> +		bias-disable;
> +		drive-strength = <2>;
drive-strength
bias-

like in all other nodes

With these:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +	};
> +
> +	cci1_default: cci1-default-state {
> +		pins = "gpio31", "gpio32";
> +		function = "cci_i2c";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	cdc_ext_spk_pa_active: cdc-ext-spk-pa-on-state {
> +		pins = "gpio0";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		output-low;
> +	};
> +
> +	cdc_ext_spk_pa_sus: cdc-ext-spk-pa-off-state {
> +		pins = "gpio0";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	cdc_slim_lines_act: lines-on-state {
> +		pins = "gpio63";
> +		function = "cdc_pdm0";
> +		drive-strength = <8>;
> +		output-high;
> +	};
> +
> +	cdc_slim_lines_sus: lines-off-state {
> +		pins = "gpio63";
> +		function = "cdc_pdm0";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	cross_conn_det_act: lines-on-state {
> +		pins = "gpio120";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-down;
> +		output-low;
> +	};
> +
> +	cross_conn_det_sus: lines-off-state {
> +		pins = "gpio120";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	ext_buck_vsel: vsel0-state {
> +		pins = "gpio111";
> +		function = "gpio";
> +		drive-strength = <2>;
> +	};
> +
> +	ext_cdc_tlmm_lines_act: tlmm-lines-on-state {
> +		pins = "gpio116", "gpio112", "gpio117", "gpio118", "gpio119";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};
> +
> +	ext_cdc_tlmm_lines_sus: tlmm-lines-off-state {
> +		pins = "gpio116", "gpio112", "gpio117", "gpio118", "gpio119";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	gpio_key_suspend: gpio-key-suspend-state {
> +		pins = "gpio107", "gpio108", "gpio109";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	negative5_reg_default: negative5-reg-default-state {
> +		pins = "gpio17";
> +		function = "gpio";
> +		output-low;
> +	};
> +
> +	positive5_reg_default: positive5-reg-default-state {
> +		pins = "gpio114";
> +		function = "gpio";
> +		output-low;
> +	};
> +
> +	/* Gyroscope and accelerometer sensor combo */
> +	mpu6050_default: mpu6050-default-state {
> +		pins = "gpio115";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-up;
> +	};
> +
> +	mpu6050_sleep: mpu6050-sleep-state {
> +		pins = "gpio115";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	nfc_disable_active: nfc-disable-active-state {
> +		pins = "gpio20";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-up;
> +	};
> +
> +	nfc_disable_suspend: nfc-disable-suspend-state {
> +		pins = "gpio20";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-disable;
> +	};
> +
> +	nfc_int_active: nfc-int-active-state {
> +		pins = "gpio21";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-up;
> +	};
> +
> +	nfc_int_suspend: nfc-int-suspend-state {
> +		pins = "gpio21";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-up;
> +	};
> +
> +	nt35521_te_default: nt35521-te-default-state {
> +		pins = "gpio24";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-down;
> +	};
> +
> +	nt35521_backlight: nt35521-backlight-default-state {
> +		pins = "gpio10";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-down;
> +	};
> +
> +	smb_int: smb-int-default-state {
> +		pins = "gpio62";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	ts_int_active: ts-int-active-state {
> +		pins = "gpio13";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-pull-up;
> +	};
> +
> +	ts_int_suspend: ts-int-suspend-state {
> +		pins = "gpio13";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	ts_reset_active: ts-reset-active-state {
> +		pins = "gpio12";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-pull-up;
> +	};
> +
> +	ts_reset_suspend: ts-reset-suspend-state {
> +		pins = "gpio12";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	ts_release: ts-release-default-state {
> +		pins = "gpio13", "gpio12";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	usb_id_default: usb-id-default-state {
> +		pins = "gpio110";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +};
> +
> +&pronto {
> +	status = "okay";
> +
> +	iris {
> +		compatible = "qcom,wcn3660";
> +	};
> +};
> +
> +&smd_rpm_regulators {
> +	vdd_l1_l2_l3-supply = <&pm8916_s3>;
> +	vdd_l4_l5_l6-supply = <&pm8916_s4>;
> +	vdd_l7-supply = <&pm8916_s4>;
> +
> +	pm8916_s3: s3 {
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1300000>;
> +	};
> +
> +	pm8916_s4: s4 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <2100000>;
> +	};
> +
> +	pm8916_l2: l2 {
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +	};
> +
> +	pm8916_l4: l4 {
> +		regulator-min-microvolt = <2050000>;
> +		regulator-max-microvolt = <2050000>;
> +	};
> +
> +	pm8916_l5: l5 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	pm8916_l6: l6 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +	};
> +
> +	pm8916_l7: l7 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	pm8916_l8: l8 {
> +		regulator-min-microvolt = <2850000>;
> +		regulator-max-microvolt = <2900000>;
> +	};
> +
> +	pm8916_l9: l9 {
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	pm8916_l10: l10 {
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	pm8916_l11: l11 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-system-load = <200000>;
> +		regulator-allow-set-load;
> +	};
> +
> +	pm8916_l12: l12 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	pm8916_l13: l13 {
> +		regulator-min-microvolt = <3075000>;
> +		regulator-max-microvolt = <3075000>;
> +	};
> +
> +	pm8916_l14: l14 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	pm8916_l15: l15 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	pm8916_l16: l16 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	pm8916_l17: l17 {
> +		regulator-min-microvolt = <2850000>;
> +		regulator-max-microvolt = <2850000>;
> +	};
> +
> +	pm8916_l18: l18 {
> +		regulator-min-microvolt = <2700000>;
> +		regulator-max-microvolt = <2700000>;
> +	};
> +};
> +
> +&sdhc_1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc1_default_state>;
> +	pinctrl-1 = <&sdc1_sleep_state>;
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_default_state>;
> +	pinctrl-1 = <&sdc2_sleep_state>;
> +	cd-gpios = <&tlmm 38 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&usb {
> +	extcon = <&usb_id>, <&usb_id>;
> +	status = "okay";
> +};
> +
> +&usb_hs_phy {
> +	extcon = <&usb_id>;
> +};
