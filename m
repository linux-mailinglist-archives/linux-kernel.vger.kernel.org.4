Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6635A660DF2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 11:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjAGKg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 05:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjAGKgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:36:20 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE1A2018
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 02:36:16 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bt23so5511664lfb.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 02:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVYhS8pu3Teq2z7l9tyMfREitVBAzZ0YApokkqSaNLM=;
        b=zworG0Qb+1pTUXsYqA1/6SgkfpP+zIHqb4/keCSF2dfJ6YsMXyrNHKqQ7BBAfasjR0
         wcraVsYC6bSEsGVFX/VJvF8d2+AiFY0mWSTpqsAcKOZeOBy7Dx1rvOwe/TscapCccIF2
         7m97MDeR5iQ6qG2TvunapfeS3Qd5IYNICbJOs9yPgHYPrKJt72vawvw1jlonS5RlyCLJ
         9bE9ocbvdkjMZS9uFOU5b6dvoNsxeuTjrH8l+u0VOIa/Sd96a7vr/4TxaLXohyGVABw5
         plNM79Q0Tt1a/bMTYedG0CynrM8xWoNv8X86BTanooKfVenuE19PmG+A1OjjWCTMjXSh
         aokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVYhS8pu3Teq2z7l9tyMfREitVBAzZ0YApokkqSaNLM=;
        b=jXur+2mfyWJTK+hDpKSlazIUyWIXCBUM92aLYW8TYpDw7nW5MDeb5Q5pQK3NERRhDB
         sxmdC5wX9tDgQAt52/l7ioRZtYBwyqX/+ABc5ODIFOyjI8cUfu7onBaiy0noLxjw1fNq
         HHCXPxZ9DZl6xlicmqV8SIH/LUoJGcm/8XBSBpielZUzHp1CP+ByKUuRwh13gUSIljdK
         DsWBfqCQpHhHCHFuxTAZk5T5Cl4wpiBY9FacY5OXpllQFnQ5jQdYg21WJtjIqZm8PImj
         j04TY9K/nmB3Xg9YkEFzhX58mwFj2pEekrg4LSrB4F0Y8vVICe7h3lX23xUc90405PpA
         O5AQ==
X-Gm-Message-State: AFqh2koYZ/Mh9L1vzJU/6lZM5UQO0ShHiMewbqlTVAxzzLwT2vn7QP5z
        K/Adh144P2BLHcl4DO1yDszmpQ==
X-Google-Smtp-Source: AMrXdXuvy9KiHjs9LC+BlCGyp75MltyEJUpUuv8I1L2SPIoCq/VbK8VXqJ8g+W+3+95WeTceZrMJlQ==
X-Received: by 2002:a19:6b1a:0:b0:4cb:262c:5422 with SMTP id d26-20020a196b1a000000b004cb262c5422mr7274879lfa.20.1673087774703;
        Sat, 07 Jan 2023 02:36:14 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id 5-20020a2eb945000000b0027fbd13c5easm319276ljs.16.2023.01.07.02.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 02:36:14 -0800 (PST)
Message-ID: <0ca7236a-f79a-7043-ad2a-01b30e1569d1@linaro.org>
Date:   Sat, 7 Jan 2023 11:36:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: Add device tree for Samsung
 Galaxy Tab A 9.7 (2015)
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230106122532.3310265-1-nikita@trvn.ru>
 <20230106122532.3310265-3-nikita@trvn.ru>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230106122532.3310265-3-nikita@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.01.2023 13:25, Nikita Travkin wrote:
> From: Jasper Korten <jja2000@gmail.com>
> 
> The Galaxy Tab A 9.7 (2015) is a Snapdragon 410 based tablet.
> 
> This commit introduces basic support for the tablet including the
> following features:
> - SDHCI (internal and external storage)
> - USB Device Mode
> - UART
> - Regulators
> - WCNSS (WiFi/BT)
> - GPIO keys
> - Fuel gauge
> - Touchscreen
> - Accelerometer
> 
> Part of the DT is split out into a common dtsi since the tablet shares
> majority of the design with another variant having a different screen
> size.
> 
> Signed-off-by: Jasper Korten <jja2000@gmail.com>
> Co-developed-by: Siddharth Manthan <siddharth.manthan@gmail.com>
> Signed-off-by: Siddharth Manthan <siddharth.manthan@gmail.com>
> Co-developed-by: Nikita Travkin <nikita@trvn.ru>
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/msm8916-samsung-gt5-common.dtsi  | 300 ++++++++++++++++++
>  .../boot/dts/qcom/msm8916-samsung-gt510.dts   | 116 +++++++
>  3 files changed, 417 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index b42362c7be1b..70e3b109aeff 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-a5u-eur.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e7.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandmax.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-gt510.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
> new file mode 100644
> index 000000000000..bb1b1e814d8a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
> @@ -0,0 +1,300 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/dts-v1/;
> +
> +#include "msm8916-pm8916.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	aliases {
> +		serial0 = &blsp1_uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	reserved-memory {
> +		/* Additional memory used by Samsung firmware modifications */
> +		tz-apps@85500000 {
> +			reg = <0x0 0x85500000 0x0 0xb00000>;
> +			no-map;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-0 = <&gpio_keys_default>;
> +		pinctrl-names = "default";
> +
> +		label = "GPIO Buttons";
> +
> +		volume-up-button {
> +			label = "Volume Up";
> +			gpios = <&msmgpio 107 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +		};
> +
> +		home-button {
> +			label = "Home";
> +			gpios = <&msmgpio 109 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_HOMEPAGE>;
> +		};
> +	};
> +
> +	gpio-hall-sensor {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-0 = <&gpio_hall_sensor_default>;
> +		pinctrl-names = "default";
> +
> +		label = "GPIO Hall Effect Sensor";
> +
> +		hall-sensor-switch {
> +			label = "Hall Effect Sensor";
> +			gpios = <&msmgpio 52 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <EV_SW>;
> +			linux,code = <SW_LID>;
> +			linux,can-disable;
> +		};
> +	};
> +};
> +
> +&blsp_i2c4 {
> +	status = "okay";
> +
> +	fuelgauge@36 {
> +		compatible = "maxim,max77849-battery";
> +		reg = <0x36>;
> +
> +		maxim,rsns-microohm = <10000>;
> +		maxim,over-heat-temp = <600>;
> +		maxim,over-volt = <4400>;
> +
> +		interrupt-parent = <&msmgpio>;
> +		interrupts = <121 IRQ_TYPE_EDGE_FALLING>;
> +
> +		pinctrl-0 = <&fuelgauge_int_default>;
> +		pinctrl-names = "default";
> +	};
> +};
> +
> +&blsp_i2c2 {
> +	status = "okay";
> +
> +	accelerometer@1d {
> +		compatible = "st,lis2hh12";
> +		reg = <0x1d>;
> +
> +		vdd-supply = <&pm8916_l17>;
> +		vddio-supply = <&pm8916_l5>;
> +
> +		interrupt-parent = <&msmgpio>;
> +		interrupts = <115 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "INT1";
> +
> +		st,drdy-int-pin = <1>;
> +		mount-matrix = "0", "1", "0",
> +			      "-1", "0", "0",
> +			       "0", "0", "1";
> +
> +		pinctrl-0 = <&accel_int_default>;
> +		pinctrl-names = "default";
> +	};
> +
> +	light-sensor@10 {
> +		compatible = "capella,cm3323";
> +		reg = <0x10>;
> +	};
The node at 0x10 should come before the node at 0x1d.

> +};
> +
> +&blsp1_uart2 {
> +	status = "okay";
> +};
> +
> +&pm8916_resin {
> +	linux,code = <KEY_VOLUMEDOWN>;
> +	status = "okay";
> +};
> +
> +/* FIXME: Replace with MAX77849 MUIC when driver is available */
> +&pm8916_usbin {
> +	status = "okay";
> +};
> +
> +&pronto {
> +	status = "okay";
> +
> +	iris {
> +		compatible = "qcom,wcn3660b";
> +	};
> +};
> +
> +&sdhc_1 {
> +	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
> +	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
> +	pinctrl-names = "default", "sleep";
> +
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
> +	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
> +	pinctrl-names = "default", "sleep";
> +
> +	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_LOW>;
> +
> +	status = "okay";
> +};
> +
> +&usb {
> +	dr_mode = "peripheral";
> +	extcon = <&pm8916_usbin>;
> +
> +	status = "okay";
> +};
> +
> +&usb_hs_phy {
> +	extcon = <&pm8916_usbin>;
> +};
> +
> +&smd_rpm_regulators {
> +	vdd_l1_l2_l3-supply = <&pm8916_s3>;
> +	vdd_l4_l5_l6-supply = <&pm8916_s4>;
> +	vdd_l7-supply = <&pm8916_s4>;
> +
> +	s3 {
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1300000>;
> +	};
> +
> +	s4 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <2100000>;
> +	};
> +
> +	l1 {
> +		regulator-min-microvolt = <1225000>;
> +		regulator-max-microvolt = <1225000>;
> +	};
> +
> +	l2 {
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +	};
> +
> +	l4 {
> +		regulator-min-microvolt = <2050000>;
> +		regulator-max-microvolt = <2050000>;
> +	};
> +
> +	l5 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	l6 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	l7 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	l8 {
> +		regulator-min-microvolt = <2850000>;
> +		regulator-max-microvolt = <2900000>;
> +	};
> +
> +	l9 {
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	l10 {
> +		regulator-min-microvolt = <2700000>;
> +		regulator-max-microvolt = <2800000>;
> +	};
> +
> +	l11 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <2950000>;
> +		regulator-allow-set-load;
> +		regulator-system-load = <200000>;
Please reorder the last two properties.


> +	};
> +
> +	l12 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <2950000>;
> +	};
> +
> +	l13 {
> +		regulator-min-microvolt = <3075000>;
> +		regulator-max-microvolt = <3075000>;
> +	};
> +
> +	l14 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	l15 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	l16 {
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	l17 {
> +		regulator-min-microvolt = <2850000>;
> +		regulator-max-microvolt = <2850000>;
> +	};
> +
> +	l18 {
> +		regulator-min-microvolt = <2700000>;
> +		regulator-max-microvolt = <2700000>;
> +	};
> +};
> +
> +&msmgpio {
> +	accel_int_default: accel-int-default-state {
> +		pins = "gpio115";
> +		function = "gpio";
> +
Stray newlines, please remove.

Konrad
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	fuelgauge_int_default: fuelgauge-int-default-state {
> +		pins = "gpio121";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	gpio_keys_default: gpio-keys-default-state {
> +		pins = "gpio107", "gpio109";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	gpio_hall_sensor_default: gpio-hall-sensor-default-state {
> +		pins = "gpio52";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
> new file mode 100644
> index 000000000000..6331166d9067
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/dts-v1/;
> +
> +#include "msm8916-samsung-gt5-common.dtsi"
> +
> +/ {
> +	model = "Samsung Galaxy Tab A 9.7 (2015)";
> +	compatible = "samsung,gt510", "qcom,msm8916";
> +	chassis-type = "tablet";
> +
> +	clk_pwm: pwm {
> +		compatible = "clk-pwm";
> +		#pwm-cells = <2>;
> +
> +		clocks = <&gcc GCC_GP2_CLK>;
> +
> +		pinctrl-0 = <&motor_pwm_default>;
> +		pinctrl-names = "default";
> +	};
> +
> +	reg_motor_vdd: regulator-motor-vdd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "motor_vdd";
> +		regulator-min-microvolt = <3000000>;
> +		regulator-max-microvolt = <3000000>;
> +
> +		gpio = <&msmgpio 76 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&motor_en_default>;
> +		pinctrl-names = "default";
> +	};
> +
> +	reg_tsp_1p8v: regulator-tsp-1p8v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "tsp_1p8v";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +
> +		gpio = <&msmgpio 73 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-0 = <&tsp_en_default>;
> +		pinctrl-names = "default";
> +	};
> +
> +	reg_tsp_3p3v: regulator-tsp-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "tsp_3p3v";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&msmgpio 73 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	vibrator {
> +		compatible = "pwm-vibrator";
> +
> +		pwms = <&clk_pwm 0 100000>;
> +		pwm-names = "enable";
> +
> +		vcc-supply = <&reg_motor_vdd>;
> +	};
> +};
> +
> +&blsp_i2c5 {
> +	status = "okay";
> +
> +	touchscreen@4a {
> +		compatible = "atmel,maxtouch";
> +		reg = <0x4a>;
> +		interrupt-parent = <&msmgpio>;
> +		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
> +
> +		vdd-supply = <&reg_tsp_1p8v>;
> +		vdda-supply = <&reg_tsp_3p3v>;
> +
> +		reset-gpios = <&msmgpio 114 GPIO_ACTIVE_LOW>;
> +
> +		pinctrl-0 = <&tsp_int_rst_default>;
> +		pinctrl-names = "default";
> +	};
> +};
> +
> +&msmgpio {
> +	motor_en_default: motor-en-default-state {
> +		pins = "gpio76";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	motor_pwm_default: motor-pwm-default-state {
> +		pins = "gpio50";
> +		function = "gcc_gp2_clk_a";
> +	};
> +
> +	tsp_en_default: tsp-en-default-state {
> +		pins = "gpio73";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	tsp_int_rst_default: tsp-int-rst-default-state {
> +		pins = "gpio13", "gpio114";
> +		function = "gpio";
> +
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +};
