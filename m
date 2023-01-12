Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E334D667AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjALQaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbjALQ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:29:38 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622C9B1FD;
        Thu, 12 Jan 2023 08:28:29 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 743EB41B1D;
        Thu, 12 Jan 2023 21:28:26 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1673540906; bh=Cr9Pt+2NDiXtKDiNXJeV6XKwzqkL32J8pa381rLgMc4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ggNw164oe9I4lu7nDE42njzZNiHR8BFQoNAiaeIJt/d6EEwDbGpXf0QCFisjiLs4h
         Z+rPhl/hqvgveP9oQUivNxQQxzOgtNxVs2fxv86rvGnEdfXyf21DAb25GTRVXfaGnc
         DHFzgzmqDQEd71lS501pgSKWJkNhao6TCI1kPEJ6bFwLqGC9p8hRyjmHTxx7A+yyh6
         /yqDqpyzqpf4z+Auq4UV99ZGFL7GLuh0zh3GObxMAM0G/vgULbpYfFlBLWB/lK+WF3
         fNaqozsarkLNfWppDovWPzqu48H4MONU2GZ752iz3FVXknwMuh9an4wB+EojoScsh7
         pJQHzdm/Kj07A==
MIME-Version: 1.0
Date:   Thu, 12 Jan 2023 21:28:25 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Yang Xiwen <forbidden405@foxmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jaime Breva <jbreva@nayarsystems.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8916-thwc: Add initial device
 tree for Tong Heng Wei Chuang Wifi/LTE dongle UFI-001C and uf896
In-Reply-To: <86e30740-6f12-1ef9-376f-85ce3fbca7b4@linaro.org>
References: <20230111141311.14682-1-forbidden405@foxmail.com>
 <tencent_F934F7427EB7B986E8AF70A95A397436E007@qq.com>
 <86e30740-6f12-1ef9-376f-85ce3fbca7b4@linaro.org>
Message-ID: <2d4bf18409d7b34f0ae7905b212346f6@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Dybcio писал(а) 12.01.2023 21:16:
> On 11.01.2023 15:13, Yang Xiwen wrote:
>> This commit adds support for the ufi-001C and uf896 WiFi/LTE dongle made by
>> Tong Heng Wei Chuang based on MSM8916.
>> uf896 is another variant for the usb stick. The board design
>> differs by using different gpios for the keys and leds.
>>
>> Note: The original firmware does not support 64-bit OS. It is necessary
>> to flash 64-bit TZ firmware to boot arm64.
>>
>> Currently supported:
>> - All CPU cores
>> - Buttons
>> - LEDs
>> - Modem
>> - SDHC
>> - USB Device Mode
>> - UART
>>
>> Co-developed-by: Jaime Breva <jbreva@nayarsystems.com>
>> Signed-off-by: Jaime Breva <jbreva@nayarsystems.com>
>> Co-developed-by: Nikita Travkin <nikita@trvn.ru>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>>  .../boot/dts/qcom/msm8916-thwc-uf896.dts      |  41 +++
>>  .../boot/dts/qcom/msm8916-thwc-ufi001c.dts    |  39 +++
>>  arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi     | 246 ++++++++++++++++++
>>  4 files changed, 328 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
>>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
>>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index b42362c7be1bf..523dbe6d06be8 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -21,6 +21,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-e7.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-grandmax.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-j5.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-uf896.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-ufi001c.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts b/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
>> new file mode 100644
>> index 0000000000000..79447ca48dd3a
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
>> @@ -0,0 +1,41 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/dts-v1/;
>> +
>> +#include "msm8916-ufi.dtsi"
>> +
>> +/ {
>> +	model = "uf896 4G Modem Stick";
>> +	compatible = "thwc,uf896", "qcom,msm8916";
>> +};
>> +
>> +&button_restart {
>> +	gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
>> +};
>> +
>> +&led_r {
>> +	gpios = <&msmgpio 82 GPIO_ACTIVE_HIGH>;
>> +};
>> +
>> +&led_g {
>> +	gpios = <&msmgpio 83 GPIO_ACTIVE_HIGH>;
>> +	function = LED_FUNCTION_WLAN;
> This is a software property, maybe it would be worth
> commonizing?
> 

The functions are put in-line with the labels on the housing.
The uf896 has green and blue leds labeled with icons but I was told
by Yang that the uf001c doesn't have any labels.

>> +};
>> +
>> +&led_b {
>> +	gpios = <&msmgpio 81 GPIO_ACTIVE_HIGH>;
>> +	function = LED_FUNCTION_WAN;
>> +};
>> +
>> +&button_default {
>> +	pins = "gpio35";
>> +	bias-pull-up;
>> +};
>> +
>> +&gpio_leds_default {
>> +	pins = "gpio81", "gpio82", "gpio83";
>> +};
>> +
>> +&sim_ctrl_default {
>> +	pins = "gpio1", "gpio2";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts b/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
>> new file mode 100644
>> index 0000000000000..700cf81cbf8c0
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
>> @@ -0,0 +1,39 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/dts-v1/;
>> +
>> +#include "msm8916-ufi.dtsi"
>> +
>> +/ {
>> +	model = "ufi-001c/ufi-001b 4G Modem Stick";
>> +	compatible = "thwc,ufi001c", "qcom,msm8916";
>> +};
>> +
>> +&button_restart {
>> +	gpios = <&msmgpio 37 GPIO_ACTIVE_HIGH>;
>> +};
>> +
>> +&led_r {
>> +	gpios = <&msmgpio 22 GPIO_ACTIVE_HIGH>;
>> +};
>> +
>> +&led_g {
>> +	gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
>> +};
>> +
>> +&led_b {
>> +	gpios = <&msmgpio 20 GPIO_ACTIVE_HIGH>;
>> +};
>> +
>> +&button_default {
>> +	pins = "gpio37";
>> +	bias-pull-down;
>> +};
>> +
>> +&gpio_leds_default {
>> +	pins = "gpio20", "gpio21", "gpio22";
>> +};
>> +
>> +&sim_ctrl_default {
>> +	pins = "gpio1", "gpio2";
> Identical between both boards, move to common please.
> 
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
>> new file mode 100644
>> index 0000000000000..286768d0fbe70
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
>> @@ -0,0 +1,246 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +#include "msm8916-pm8916.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/leds/common.h>
>> +
>> +/ {
>> +	chassis-type = "embedded";
>> +
>> +	aliases {
>> +		serial0 = &blsp1_uart2;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0";
>> +	};
>> +
>> +	reserved-memory {
>> +		mpss_mem: mpss@86800000 {
>> +			reg = <0x0 0x86800000 0x0 0x5500000>;
>> +			no-map;
>> +		};
>> +
>> +		gps_mem: gps@8bd00000 {
>> +			reg = <0x0 0x8bd00000 0x0 0x200000>;
>> +			no-map;
>> +		};
>> +	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +
>> +		pinctrl-0 = <&button_default>;
>> +		pinctrl-names = "default";
>> +
>> +		label = "GPIO Buttons";
>> +
>> +		/* gpio is board-specific */
> GPIO is an acronym, please make it uppercase, as you
> did 10 lines below..
> 
>> +		button_restart: button-restart {
>> +			label = "Restart";
>> +			linux,code = <KEY_RESTART>;
>> +		};
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		pinctrl-0 = <&gpio_leds_default>;
>> +		pinctrl-names = "default";
>> +
>> +		/* GPIOs are board-specific */
>> +		led_r: led-r {
>> +			color = <LED_COLOR_ID_RED>;
>> +			default-state = "on";
>> +			function = LED_FUNCTION_INDICATOR;
>> +		};
>> +
>> +		led_g: led-g {
>> +			color = <LED_COLOR_ID_GREEN>;
>> +			default-state = "off";
>> +			function = LED_FUNCTION_INDICATOR;
>> +		};
>> +
>> +		led_b: led-b {
>> +			color = <LED_COLOR_ID_BLUE>;
>> +			default-state = "off";
>> +			function = LED_FUNCTION_INDICATOR;
>> +		};
>> +	};
>> +};
>> +
>> +&bam_dmux {
>> +	status = "okay";
>> +};
>> +
>> +&bam_dmux_dma {
>> +	status = "okay";
>> +};
>> +
>> +&blsp1_uart2 {
>> +	status = "okay";
>> +};
>> +
>> +/* Remove &dsi_phy0 from clocks to make sure that gcc probes with display disabled */
> That sounds like a bad regression and shouldn't be an issue..
> 
>> +&gcc {
>> +	clocks = <&xo_board>, <&sleep_clk>, <0>, <0>, <0>, <0>, <0>;
>> +};
>> +
>> +&mpss {
>> +	pinctrl-0 = <&sim_ctrl_default>;
>> +	pinctrl-names = "default";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pm8916_usbin {
>> +	status = "okay";
>> +};
>> +
>> +&pronto {
>> +	status = "okay";
>> +};
>> +
>> +&sdhc_1 {
>> +	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
>> +	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
>> +	pinctrl-names = "default", "sleep";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb {
>> +	extcon = <&pm8916_usbin>;
>> +	dr_mode = "peripheral";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_hs_phy {
>> +	extcon = <&pm8916_usbin>;
>> +};
>> +
>> +&smd_rpm_regulators {
> Please sort this reference alphabetically.
> 

The regulators and tlmm nodes are deliberately put last,
in line with all other msm8916 devices. We move them away
so they don't clutter more interesting nodes with these "dry"
and somewhat uninteresting voltage/pin definitions.

Thanks for the review,
Nikita

> Konrad
>> +	vdd_l1_l2_l3-supply = <&pm8916_s3>;
>> +	vdd_l4_l5_l6-supply = <&pm8916_s4>;
>> +	vdd_l7-supply = <&pm8916_s4>;
>> +
>> +	s3 {
>> +		regulator-min-microvolt = <1200000>;
>> +		regulator-max-microvolt = <1300000>;
>> +	};
>> +
>> +	s4 {
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <2100000>;
>> +	};
>> +
>> +	l1 {
>> +		regulator-min-microvolt = <1225000>;
>> +		regulator-max-microvolt = <1225000>;
>> +	};
>> +
>> +	l2 {
>> +		regulator-min-microvolt = <1200000>;
>> +		regulator-max-microvolt = <1200000>;
>> +	};
>> +
>> +	l4 {
>> +		regulator-min-microvolt = <2050000>;
>> +		regulator-max-microvolt = <2050000>;
>> +	};
>> +
>> +	l5 {
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +	};
>> +
>> +	l6 {
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +	};
>> +
>> +	l7 {
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +	};
>> +
>> +	l8 {
>> +		regulator-min-microvolt = <2850000>;
>> +		regulator-max-microvolt = <2900000>;
>> +	};
>> +
>> +	l9 {
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +	};
>> +
>> +	l10 {
>> +		regulator-min-microvolt = <2700000>;
>> +		regulator-max-microvolt = <2800000>;
>> +	};
>> +
>> +	l11 {
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <2950000>;
>> +		regulator-system-load = <200000>;
>> +		regulator-allow-set-load;
>> +	};
>> +
>> +	l12 {
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <2950000>;
>> +	};
>> +
>> +	l13 {
>> +		regulator-min-microvolt = <3075000>;
>> +		regulator-max-microvolt = <3075000>;
>> +	};
>> +
>> +	l14 {
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <3300000>;
>> +	};
>> +
>> +	l15 {
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <3300000>;
>> +	};
>> +
>> +	l16 {
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <3300000>;
>> +	};
>> +
>> +	l17 {
>> +		regulator-min-microvolt = <2850000>;
>> +		regulator-max-microvolt = <2850000>;
>> +	};
>> +
>> +	l18 {
>> +		regulator-min-microvolt = <2700000>;
>> +		regulator-max-microvolt = <2700000>;
>> +	};
>> +};
>> +
>> +&msmgpio {
>> +	/* pins are board-specific */
>> +	button_default: button-default-state {
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +	};
>> +
>> +	gpio_leds_default: gpio-leds-default-state {
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +	};
>> +
>> +	sim_ctrl_default: sim-ctrl-default-state {
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-disable;
>> +		output-low;
>> +	};
>> +};
