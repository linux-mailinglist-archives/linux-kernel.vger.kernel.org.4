Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0956066ADF0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 21:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjANUyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 15:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjANUyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 15:54:43 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E116586
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 12:54:42 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id q2so26031581ljp.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 12:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jhlu7bQ0QdAg6OfQv/+8TH83c/23OGuGJMt6XySlBUk=;
        b=i6FjuDBnCIKVH7q+noR9PsmbjSEm04M1j9dByNkNHUmTYKWHSacEjqjLabaqX0qNWh
         qDVYje8pcmN2R8zn1NbU5411vEf2J1qQjwhFmZ/eu/Ff4EuoVvkc02mqu/9uTk0Ao4of
         puF+MOMDIv1xA8kdj7oO1H33k4LS1xasaU7kNB1BAjaZHBW8VanRyn/aRofinlfxAVz6
         /As1BeUD7ByYQcqnuek8GlC5JLGqxyQlK4UOeuNvmpbUeXwaAfcdgDtpJqCIX5i+5p7l
         GRCUNQL2LMg/IjMTRw7mQ9QYX0tcwdSWC72Ea9eGuRQBw1Xp+aTuyuCVdXzjy4ad6IcR
         AZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jhlu7bQ0QdAg6OfQv/+8TH83c/23OGuGJMt6XySlBUk=;
        b=6OYA2rSY0a4+pcFUHWixUhccvb/XgEv8aZuK4SSBQEJ9m13u67ErBnbIBHvaNmcGfe
         vB1WNVVQ+zl/AkoagCPyYDyLTKTVoIGzKRhxGI8oiiokteFCnRs/TnyShwF50ucPQncU
         v4/CIGbdX2SELBJN3RkTK2NzPa2IRr3pbr7GAhaEZnc2E1qtNSJQQYVp1E9NOd/pGFdA
         sHHovNiuULDpgIXsYYVkqGrWhEYd3eSDXsSVi2Kcu50IBCZQACBXY74Ftyj/imeu7y5x
         RVpZl/C1EPimKdaqh8+ZXFSCcIoQAnDukHcD3e/cjZNit1WKp+yOdrU9LyiUnhqDAWuD
         FyWQ==
X-Gm-Message-State: AFqh2kptj3LE6qfQ+3MTh3F6H3hKeKNiQbQLpzgvvFoVo5OI9tXY6ecc
        d3cneR8nLx7I+ZX0WqKGkDbYPQ==
X-Google-Smtp-Source: AMrXdXuJ1Lvj/xx2/tbY//KTszzrzlh9nr+T+sf2jA1CE5HIe/il47HbUkY2260YmetgzsvVyM92sA==
X-Received: by 2002:a2e:9799:0:b0:281:e7d0:aba0 with SMTP id y25-20020a2e9799000000b00281e7d0aba0mr9109822lji.53.1673729680791;
        Sat, 14 Jan 2023 12:54:40 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id z7-20020a2e8e87000000b002834cfbd857sm2743980ljk.52.2023.01.14.12.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jan 2023 12:54:40 -0800 (PST)
Message-ID: <a7d19f36-56b0-df4e-3afe-858f6e0bf520@linaro.org>
Date:   Sat, 14 Jan 2023 21:54:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: msm8916-thwc: Add initial device
 trees
Content-Language: en-US
To:     Yang Xiwen <forbidden405@foxmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jaime Breva <jbreva@nayarsystems.com>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230114063846.2633-1-forbidden405@foxmail.com>
 <tencent_AB776DFEB1B993E8B3F0BD5A4BF420600407@qq.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <tencent_AB776DFEB1B993E8B3F0BD5A4BF420600407@qq.com>
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



On 14.01.2023 07:38, Yang Xiwen wrote:
> This commit adds support for the ufi-001C and uf896 WiFi/LTE dongle made by
> Tong Heng Wei Chuang based on MSM8916.
> uf896 is another variant for the usb stick. The board design
> differs by using different gpios for the keys and leds.
> 
> Note: The original firmware does not support 64-bit OS. It is necessary
> to flash 64-bit TZ firmware to boot arm64.
> 
> Currently supported:
> - All CPU cores
> - Buttons
> - LEDs
> - Modem
> - SDHC
> - USB Device Mode
> - UART
> 
> Co-developed-by: Jaime Breva <jbreva@nayarsystems.com>
> Signed-off-by: Jaime Breva <jbreva@nayarsystems.com>
> Co-developed-by: Nikita Travkin <nikita@trvn.ru>
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>  .../boot/dts/qcom/msm8916-thwc-uf896.dts      |  39 +++
>  .../boot/dts/qcom/msm8916-thwc-ufi001c.dts    |  39 +++
>  arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi     | 250 ++++++++++++++++++
>  4 files changed, 330 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index e442a81895d04..d83e02c84d42c 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -22,6 +22,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e7.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandmax.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-uf896.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-ufi001c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts b/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
> new file mode 100644
> index 0000000000000..c492db8561904
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/dts-v1/;
> +
> +#include "msm8916-ufi.dtsi"
> +
> +/ {
> +	model = "uf896 4G Modem Stick";
> +	compatible = "thwc,uf896", "qcom,msm8916";
> +};
> +
> +&button_restart {
> +	gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
> +};
> +
> +&led_r {
> +	gpios = <&msmgpio 82 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&led_g {
> +	gpios = <&msmgpio 83 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&led_b {
> +	gpios = <&msmgpio 81 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&button_default {
> +	pins = "gpio35";
> +	bias-pull-up;
> +};
> +
> +&gpio_leds_default {
> +	pins = "gpio81", "gpio82", "gpio83";
> +};
> +
> +&sim_ctrl_default {
> +	pins = "gpio1", "gpio2";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts b/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
> new file mode 100644
> index 0000000000000..700cf81cbf8c0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/dts-v1/;
> +
> +#include "msm8916-ufi.dtsi"
> +
> +/ {
> +	model = "ufi-001c/ufi-001b 4G Modem Stick";
> +	compatible = "thwc,ufi001c", "qcom,msm8916";
> +};
> +
> +&button_restart {
> +	gpios = <&msmgpio 37 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&led_r {
> +	gpios = <&msmgpio 22 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&led_g {
> +	gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&led_b {
> +	gpios = <&msmgpio 20 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&button_default {
> +	pins = "gpio37";
> +	bias-pull-down;
> +};
> +
> +&gpio_leds_default {
> +	pins = "gpio20", "gpio21", "gpio22";
> +};
> +
> +&sim_ctrl_default {
> +	pins = "gpio1", "gpio2";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
> new file mode 100644
> index 0000000000000..790a9696da9de
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "msm8916-pm8916.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	chassis-type = "embedded";
> +
> +	aliases {
> +		serial0 = &blsp1_uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	reserved-memory {
> +		mpss_mem: mpss@86800000 {
> +			reg = <0x0 0x86800000 0x0 0x5500000>;
> +			no-map;
> +		};
> +
> +		gps_mem: gps@8bd00000 {
> +			reg = <0x0 0x8bd00000 0x0 0x200000>;
> +			no-map;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-0 = <&button_default>;
> +		pinctrl-names = "default";
> +
> +		label = "GPIO Buttons";
> +
> +		/* GPIO is board-specific */
> +		button_restart: button-restart {
> +			label = "Restart";
> +			linux,code = <KEY_RESTART>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		pinctrl-0 = <&gpio_leds_default>;
> +		pinctrl-names = "default";
> +
> +		/*
> +		 * GPIOs are board-specific.
> +		 * Functions and default-states defined here are fallbacks.
> +		 * Feel free to override them if your board is different.
> +		 */
> +		led_r: led-r {
> +			color = <LED_COLOR_ID_RED>;
> +			default-state = "on";
> +			function = LED_FUNCTION_POWER;
> +		};
> +
> +		led_g: led-g {
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "off";
> +			function = LED_FUNCTION_WLAN;
> +		};
> +
> +		led_b: led-b {
> +			color = <LED_COLOR_ID_BLUE>;
> +			default-state = "off";
> +			function = LED_FUNCTION_WAN;
> +		};
> +	};
> +};
> +
> +&bam_dmux {
> +	status = "okay";
> +};
> +
> +&bam_dmux_dma {
> +	status = "okay";
> +};
> +
> +&blsp1_uart2 {
> +	status = "okay";
> +};
> +
> +/* Remove &dsi_phy0 from clocks to make sure that gcc probes with display disabled */
> +&gcc {
> +	clocks = <&xo_board>, <&sleep_clk>, <0>, <0>, <0>, <0>, <0>;
> +};
> +
> +&mpss {
> +	pinctrl-0 = <&sim_ctrl_default>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&pm8916_usbin {
> +	status = "okay";
> +};
> +
> +&pronto {
> +	status = "okay";
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
> +&usb {
> +	extcon = <&pm8916_usbin>;
> +	dr_mode = "peripheral";
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
> +		regulator-system-load = <200000>;
> +		regulator-allow-set-load;
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
> +	/* pins are board-specific */
> +	button_default: button-default-state {
> +		function = "gpio";
> +		drive-strength = <2>;
> +	};
> +
> +	gpio_leds_default: gpio-leds-default-state {
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	sim_ctrl_default: sim-ctrl-default-state {
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-low;
> +	};
> +};
