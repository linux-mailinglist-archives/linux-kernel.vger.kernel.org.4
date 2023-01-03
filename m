Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B900465B95D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 03:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjACC3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 21:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjACC3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 21:29:34 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DCCB4A4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 18:29:31 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 1so43846700lfz.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 18:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lG9fGAfderjH0YapN+iXiWoOestZzdjbyhvzo62W7sU=;
        b=FZC0nP0UtZsC9daCcRpQii2R+KxiuGepEIMiNaT1gddSIrfqiiXuD7CaRTH5wi+J4k
         BeJrIbfFu02wbUrxIhk0Xkw31XzhTOVNiJM7kRoh2lBgD7oKzRDaoYdgt1EJhPTT7RAC
         zGaFoeSAncNwMYdS6WxwtVT5z/JChv58dNfQ1em02nm9UzJKSQSSIujb9cfjJ0jWWU2Z
         Jao2TeePWIa3owVGTqDRnTv+gGJM6FG7qJsBatX8pDBiNdu81JzGCxH3sDW2ZOqeafSP
         R/a2sU9qSkUy3nsV6emebrr0V79+g3dfrz4Qy0a0ye3wPxDRxo/a3LgnTzvHUNPMyMYN
         3Sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lG9fGAfderjH0YapN+iXiWoOestZzdjbyhvzo62W7sU=;
        b=M2z39kVjvGHdeJK16acoPw5jDHPkp5B7972Pu/uqTuGNOUsZ3uR8t5fRVjR6H1gWl2
         tP8r6OX95NmHQFzljbHrQjCK0B9CVzRR6a7EM8N4Wiqa0NP/v7gv6vYVCjLN11rAUtG3
         Ku+muXM2Rj6Q3OvYsLVrUOMEUgnoguw9urfwXH/uXHAO4Bzo65jbF23vqA8hDSdaibiF
         DWMgQtcUGvsqXOlavis58oN7425pZM6VqtJsAqiOtZ3bSduWVBj5BUs/VhLLjtxNc081
         DXldStatfkMwqFDhgLpxa616HOQkUBKsLV/Bvk3JkLKdAiNVYLYrekgc7TPSCGtyQQV2
         rdBw==
X-Gm-Message-State: AFqh2kph0ag7vg1mvgq3n2SnUnNzTZBXP6LivOCIyJuGxNaEWaM3uWwe
        rruk7dBV84r9U2nyNO3JJfEkzg==
X-Google-Smtp-Source: AMrXdXuXe2T3WJi5upDwrfvReW18liaWQH1N361W0kABEwy8FT/14mBsGJVpOrZrzP7+e9QUMvDEIA==
X-Received: by 2002:a05:6512:2589:b0:4b5:6569:ab0 with SMTP id bf9-20020a056512258900b004b565690ab0mr15845032lfb.62.1672712969882;
        Mon, 02 Jan 2023 18:29:29 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id p16-20020ac24ed0000000b004b4f3c0d9f8sm4672901lfr.283.2023.01.02.18.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 18:29:29 -0800 (PST)
Message-ID: <f293e1c3-d192-fe98-c599-e9c40d01175d@linaro.org>
Date:   Tue, 3 Jan 2023 03:29:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: Add msm8939 Sony Xperia M4 Aqua
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org
References: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
 <20230103010904.3201835-8-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230103010904.3201835-8-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.01.2023 02:09, Bryan O'Donoghue wrote:
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
>  .../qcom/msm8939-sony-xperia-kanuti-tulip.dts | 472 ++++++++++++++++++
>  2 files changed, 473 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 8d8dab62c66df..7056036351df8 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -22,6 +22,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandmax.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-sony-xperia-kanuti-tulip.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-kugo.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8956-sony-xperia-loire-suzu.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-lg-bullhead-rev-10.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
> new file mode 100644
> index 0000000000000..ff93b69bda679
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
> @@ -0,0 +1,472 @@
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
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +
> +/ {
> +	model = "Sony Xperia M4 Aqua";
> +	compatible = "sony,kanuti-tulip", "qcom,msm8939";
> +	qcom,board-id = <8 0>;
> +
> +	aliases {
> +		serial0 = &blsp1_uart2;
> +		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
> +		mmc1 = &sdhc_2; /* SDC2 SD card slot */
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
> +		regulator-name = "negative5_reg";
> +		gpio = <&msmgpio 17 GPIO_ACTIVE_LOW>;
> +		startup-delay-us = <0>;
> +	};
> +
> +	positive5_reg: positive5-regulator {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&positive5_reg_default>;
> +		regulator-name = "positive5_reg";
> +		gpio = <&msmgpio 114 GPIO_ACTIVE_LOW>;
> +		startup-delay-us = <0>;
Isn't that the default value?

> +	};
> +
> +	usb_id: usb-id {
> +		compatible = "linux,extcon-usb-gpio";
> +		id-gpio = <&msmgpio 110 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_id_default>;
> +	};
> +};
> +
> +&blsp_dma {
> +	status = "okay";
> +};
> +
> +&dsi0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
These already exist in the SoC dtsi.

> +	vdda-supply = <&pm8916_l2>;
> +	vddio-supply = <&pm8916_l16>;
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			endpoint {
You have a label, dsi0_out: pointing at this endpoint.

> +				remote-endpoint = <&panel_in>;
> +				data-lanes = <0 1 2 3>;
> +			};
> +		};
> +	};
> +
> +	panel@0 {
> +		compatible = "sony,tulip-truly-nt35521";
> +		reg = <0>;
> +		positive5-supply = <&positive5_reg>;
> +		negative5-supply = <&negative5_reg>;
> +		reset-gpios = <&msmgpio 25 GPIO_ACTIVE_LOW>;
> +		enable-gpios = <&msmgpio 10 GPIO_ACTIVE_LOW>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				panel_in: endpoint {
> +					remote-endpoint = <&dsi0_out>;
> +				};
> +			};
> +		};
> +
> +	};
> +};
> +
> +&dsi_phy0 {
> +	vddio-supply = <&pm8916_l16>;
> +	status = "okay";
> +};
> +
> +&msmgpio {
> +
Stray newline, please remove.

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
> +		output-low;
> +		bias-pull-down;
Generally the following order is preferred:

pins
function
drive-strength
bias-
output/input/somethingelse-

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
No bias?

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
> +	/* add pingrp for touchscreen */
This comment is rather dubious.

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
12, 13?

Also, why does this node exist in the first place? Is it
going to be used for some non-standard touchpanel-off-flipping?


Konrad
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	usb_id_default: usb-id-default-state {
> +		pins = "gpio110";
> +		function = "gpio";
> +
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +};
> +
> +&pronto {
> +	status = "okay";
Add a newline, please.

> +	iris {
> +		compatible = "qcom,wcn3660";
> +	};
> +};
> +
> +&smd_rpm_regulators {
No `regulator-allow-set-load` on sdhcN_vmmc/vqmmc?

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
> +		regulator-max-microvolt = <2950000>;
> +	};
> +
> +	pm8916_l12: l12 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <2950000>;
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
> +	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
> +	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
> +	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
> +	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&usb {
> +	status = "okay";
> +	extcon = <&usb_id>, <&usb_id>;
status last, please.

Konrad
> +
> +	ulpi {
> +		usb_hs_phy: phy {
> +			v1p8-supply = <&pm8916_l7>;
> +			v3p3-supply = <&pm8916_l13>;
> +		};
> +	};
> +};
> +
> +&usb_hs_phy {
> +	extcon = <&usb_id>;
> +};
