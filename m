Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F623667AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbjALQWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236750AbjALQVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:21:22 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2AC3E84B
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:16:51 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id x37so19852783ljq.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7mK+aHfdzrJXXSQHEYKKd0qwPlDYZMDePbxxcOadco=;
        b=IV893G4j7mR8Ob33UdDk704qlzsbndIyKaxEEgyT6vxgBi/Imct/IQqWSSeByn2Ril
         KbUnaRQB4oWyCRFzQZj8245keEDHWtTeYVzQ3cWCMBJ1b/eYyVSr4xlO5N3iM7YvcSQq
         UgglBIdpe6aXK/H7x9DSqaxJynx3lYOCvXPU+RXsIGTgT3Q5nLI/PDwWI8C6sgrMq1xH
         XLtQ9zJv3kFiSa9nYQl4jsRWDfWd17zKk4DPpxvLbuSTSUSYhZPdKAX7khHzN3/ZZ7VS
         lWqzUMhuFaHd7d4fOv0dJGy2ixntPm0qwgvxL9L6hyKePXUpaqtR/qcgNXK1lDfCZjbz
         U8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7mK+aHfdzrJXXSQHEYKKd0qwPlDYZMDePbxxcOadco=;
        b=rZLg1ZUj97cOBp/c3oiMgy3xBYb4OjEzvF5J+vOqoic81dAd1PEY3sXabS5fXEB98v
         wRCa4WaFAAwmEgowgdT8fq3uMIJrERVnDsj17Z1n3V1BH0ICQU/UKyBgKw20jj/BM8Uj
         BMTOUDih6gFTdeUNNTG95nEZnBJwXf4ShHR53B2Fd4hgZiOa6lJ3f6GhLWiRyVjiThwc
         uS2ilB+sWSKlb0qo4dFZivykZFWA5uzsrAt2B3fThPyY10E5DYVfrK0zoLgs6uYHhIWn
         iAYWzKW6kKzVk+QLPTZN6q/MD48n8SDOGXL5dDeoTJaBkr+dB3WMUDHJ4kE97Bhfwwgk
         /Q5Q==
X-Gm-Message-State: AFqh2krcrivdNN1jVwYLbVckwgzsBZH1BN3Y6P/jU5bugvb7yzClVwI+
        /KhJUZ0WCsVi8gl/i8LqxA3lMg==
X-Google-Smtp-Source: AMrXdXu6kRb60J+SLbz2rdN4D2QpSV5SgflgQZ2iePoWrQ3zehkou/xvVLlyJHoaOIsy3h77+UX3gA==
X-Received: by 2002:a2e:9253:0:b0:283:deb1:1c52 with SMTP id v19-20020a2e9253000000b00283deb11c52mr4882729ljg.30.1673540209246;
        Thu, 12 Jan 2023 08:16:49 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id t13-20020a05651c204d00b0027fbfe2e45csm2153176ljo.107.2023.01.12.08.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 08:16:46 -0800 (PST)
Message-ID: <86e30740-6f12-1ef9-376f-85ce3fbca7b4@linaro.org>
Date:   Thu, 12 Jan 2023 17:16:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8916-thwc: Add initial device
 tree for Tong Heng Wei Chuang Wifi/LTE dongle UFI-001C and uf896
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
References: <20230111141311.14682-1-forbidden405@foxmail.com>
 <tencent_F934F7427EB7B986E8AF70A95A397436E007@qq.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <tencent_F934F7427EB7B986E8AF70A95A397436E007@qq.com>
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



On 11.01.2023 15:13, Yang Xiwen wrote:
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
>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>  .../boot/dts/qcom/msm8916-thwc-uf896.dts      |  41 +++
>  .../boot/dts/qcom/msm8916-thwc-ufi001c.dts    |  39 +++
>  arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi     | 246 ++++++++++++++++++
>  4 files changed, 328 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index b42362c7be1bf..523dbe6d06be8 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -21,6 +21,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e7.dtb
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
> index 0000000000000..79447ca48dd3a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
> @@ -0,0 +1,41 @@
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
> +	function = LED_FUNCTION_WLAN;
This is a software property, maybe it would be worth
commonizing?

> +};
> +
> +&led_b {
> +	gpios = <&msmgpio 81 GPIO_ACTIVE_HIGH>;
> +	function = LED_FUNCTION_WAN;
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
Identical between both boards, move to common please.

> +};
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
> new file mode 100644
> index 0000000000000..286768d0fbe70
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
> @@ -0,0 +1,246 @@
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
> +		/* gpio is board-specific */
GPIO is an acronym, please make it uppercase, as you
did 10 lines below..

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
> +		/* GPIOs are board-specific */
> +		led_r: led-r {
> +			color = <LED_COLOR_ID_RED>;
> +			default-state = "on";
> +			function = LED_FUNCTION_INDICATOR;
> +		};
> +
> +		led_g: led-g {
> +			color = <LED_COLOR_ID_GREEN>;
> +			default-state = "off";
> +			function = LED_FUNCTION_INDICATOR;
> +		};
> +
> +		led_b: led-b {
> +			color = <LED_COLOR_ID_BLUE>;
> +			default-state = "off";
> +			function = LED_FUNCTION_INDICATOR;
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
That sounds like a bad regression and shouldn't be an issue..

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
Please sort this reference alphabetically.

Konrad
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
