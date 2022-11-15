Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4FA62943D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiKOJXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiKOJXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:23:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DFA299;
        Tue, 15 Nov 2022 01:23:45 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2506B6602A0B;
        Tue, 15 Nov 2022 09:23:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668504224;
        bh=14FQ7XdqqsKx0ej8JuWfiLjDWW2DPMX5zWGMoAJNGTA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k/cEielxKpv0q0nEXJ/AjD/MsoeMhII1oHBnMxtgdg5aVJk0Y9YA5vhrJdOVdj3CY
         LNtFL9+F1gi3tbf1HZz3+x8iTWeJjJksuzpbNCxfdQGijOlj+LsBOuP/PxYnMOdppi
         zfP5+9Loe+kO9Z0l1PdBFPTgYdgbfj5vVMEZu8cYQ6rI1c6jgGOSOG9wjJMtP4e1ay
         nzCI0u8Dk3P16KU7aqMgGJn+WGcA+vesDNaShqwR/1QoyqLK7Duv3EYwmjU58QlEEA
         DVdhR3GK4G2bX/dmt19lYJMKm6fioBg8QlnCzGBLcZefP7ysBfjTcuWL52t4s3i5Pu
         /bmYXqOotSTxw==
Message-ID: <13f01920-5a7c-65a4-7907-7116e365f18e@collabora.com>
Date:   Tue, 15 Nov 2022 10:23:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 01/15] arm64: dts: mediatek: Initial mt8365-evk support
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
 <20221115025421.59847-2-bero@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221115025421.59847-2-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/11/22 03:54, Bernhard Rosenkränzer ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> This adds minimal support for the Mediatek 8365 SOC and the EVK reference
> board, allowing the board to boot to initramfs with serial port I/O.
> 
> GPIO keys are supported, MMC is partially supported (needs the clocks
> driver for full support).
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> [bero@baylibre.com: Removed parts depending on drivers that aren't upstream yet, cleanups]
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>   arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 344 +++++++++++
>   arch/arm64/boot/dts/mediatek/mt8365.dtsi    | 601 ++++++++++++++++++++
>   3 files changed, 946 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8365-evk.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8365.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 0ec90cb3ef289..e668fd50a3326 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -46,4 +46,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r2.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r3.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> new file mode 100644
> index 0000000000000..74e0f75231637
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021-2022 BayLibre, SAS.
> + * Authors:
> + * Fabien Parent <fparent@baylibre.com>
> + * Bernhard Rosenkränzer <bero@baylibre.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/pinctrl/mt8365-pinfunc.h>
> +#include "mt8365.dtsi"
> +
> +/ {
> +	model = "MediaTek MT8365 Open Platform EVK";
> +	compatible = "mediatek,mt8365-evk", "mediatek,mt8365";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:921600n8";
> +	};
> +
> +	firmware {
> +		optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		input-name = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_keys>;
> +
> +		key-volume-up {
> +			gpios = <&pio 24 GPIO_ACTIVE_LOW>;
> +			label = "volume_up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			wakeup-source;
> +			debounce-interval = <15>;
> +		};
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0xc0000000>;
> +	};
> +
> +	usb_otg_vbus: regulator-0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "otg_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&pio 16 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 12 MiB reserved for OP-TEE (BL32)
> +		 * +-----------------------+ 0x43e0_0000
> +		 * |      SHMEM 2MiB       |
> +		 * +-----------------------+ 0x43c0_0000
> +		 * |        | TA_RAM  8MiB |
> +		 * + TZDRAM +--------------+ 0x4340_0000
> +		 * |        | TEE_RAM 2MiB |
> +		 * +-----------------------+ 0x4320_0000
> +		 */
> +		optee_reserved: optee@43200000 {
> +			no-map;
> +			reg = <0 0x43200000 0 0x00c00000>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +	clock-frequency = <100000>;
> +	status = "okay";
> +};
> +
> +&pio {
> +	dpi_func_pins: dpi-func-pins {
> +		pins {
> +			pinmux = <MT8365_PIN_0_GPIO0__FUNC_DPI_D0>,
> +				 <MT8365_PIN_1_GPIO1__FUNC_DPI_D1>,
> +				 <MT8365_PIN_2_GPIO2__FUNC_DPI_D2>,
> +				 <MT8365_PIN_3_GPIO3__FUNC_DPI_D3>,
> +				 <MT8365_PIN_4_GPIO4__FUNC_DPI_D4>,
> +				 <MT8365_PIN_5_GPIO5__FUNC_DPI_D5>,
> +				 <MT8365_PIN_6_GPIO6__FUNC_DPI_D6>,
> +				 <MT8365_PIN_7_GPIO7__FUNC_DPI_D7>,
> +				 <MT8365_PIN_8_GPIO8__FUNC_DPI_D8>,
> +				 <MT8365_PIN_9_GPIO9__FUNC_DPI_D9>,
> +				 <MT8365_PIN_10_GPIO10__FUNC_DPI_D10>,
> +				 <MT8365_PIN_11_GPIO11__FUNC_DPI_D11>,
> +				 <MT8365_PIN_12_GPIO12__FUNC_DPI_DE>,
> +				 <MT8365_PIN_13_GPIO13__FUNC_DPI_VSYNC>,
> +				 <MT8365_PIN_14_GPIO14__FUNC_DPI_CK>,
> +				 <MT8365_PIN_15_GPIO15__FUNC_DPI_HSYNC>;
> +			drive-strength = <MTK_DRIVE_4mA>;
> +		};
> +	};
> +
> +	dpi_idle_pins: dpi-idle-pins {
> +		pins {
> +			pinmux = <MT8365_PIN_0_GPIO0__FUNC_GPIO0>,
> +				 <MT8365_PIN_1_GPIO1__FUNC_GPIO1>,
> +				 <MT8365_PIN_2_GPIO2__FUNC_GPIO2>,
> +				 <MT8365_PIN_3_GPIO3__FUNC_GPIO3>,
> +				 <MT8365_PIN_4_GPIO4__FUNC_GPIO4>,
> +				 <MT8365_PIN_5_GPIO5__FUNC_GPIO5>,
> +				 <MT8365_PIN_6_GPIO6__FUNC_GPIO6>,
> +				 <MT8365_PIN_7_GPIO7__FUNC_GPIO7>,
> +				 <MT8365_PIN_8_GPIO8__FUNC_GPIO8>,
> +				 <MT8365_PIN_9_GPIO9__FUNC_GPIO9>,
> +				 <MT8365_PIN_10_GPIO10__FUNC_GPIO10>,
> +				 <MT8365_PIN_11_GPIO11__FUNC_GPIO11>,
> +				 <MT8365_PIN_12_GPIO12__FUNC_GPIO12>,
> +				 <MT8365_PIN_13_GPIO13__FUNC_GPIO13>,
> +				 <MT8365_PIN_14_GPIO14__FUNC_GPIO14>,
> +				 <MT8365_PIN_15_GPIO15__FUNC_GPIO15>;
> +		};
> +	};
> +
> +	gpio_keys: gpio-keys-pins {
> +		pins {
> +			pinmux = <MT8365_PIN_24_KPCOL0__FUNC_KPCOL0>;
> +			bias-pull-up;
> +			input-enable;
> +		};
> +	};
> +
> +	i2c1_pins: i2c1-pins {
> +		pins {
> +			pinmux = <MT8365_PIN_59_SDA1__FUNC_SDA1_0>,
> +				 <MT8365_PIN_60_SCL1__FUNC_SCL1_0>;
> +			mediatek,pull-up-adv = <3>;
> +			mediatek,drive-strength-adv = <00>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	ite_pins: ite-pins {
> +		pins-rst-ite {
> +			pinmux = <MT8365_PIN_69_CMDAT1__FUNC_GPIO69>;
> +			output-high;
> +		};
> +
> +		pins-irq-ite {
> +			pinmux = <MT8365_PIN_68_CMDAT0__FUNC_GPIO68>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +
> +		pins-pwr {
> +			pinmux = <MT8365_PIN_70_CMDAT2__FUNC_GPIO70>,
> +				 <MT8365_PIN_71_CMDAT3__FUNC_GPIO71>;
> +			output-high;
> +		};
> +	};
> +
> +	mmc0_pins_default: mmc0-default-pins {
> +		pins-clk {
> +			pinmux = <MT8365_PIN_99_MSDC0_CLK__FUNC_MSDC0_CLK>;
> +			bias-pull-down;
> +		};
> +
> +		pins-cmd-dat {
> +			pinmux = <MT8365_PIN_103_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
> +				 <MT8365_PIN_102_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
> +				 <MT8365_PIN_101_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
> +				 <MT8365_PIN_100_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
> +				 <MT8365_PIN_96_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
> +				 <MT8365_PIN_95_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
> +				 <MT8365_PIN_94_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
> +				 <MT8365_PIN_93_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
> +				 <MT8365_PIN_98_MSDC0_CMD__FUNC_MSDC0_CMD>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +
> +		pins-rst {
> +			pinmux = <MT8365_PIN_97_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	mmc0_pins_uhs: mmc0-uhs-pins {
> +		pins-clk {
> +			pinmux = <MT8365_PIN_99_MSDC0_CLK__FUNC_MSDC0_CLK>;
> +			drive-strength = <MTK_DRIVE_10mA>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-cmd-dat {
> +			pinmux = <MT8365_PIN_103_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
> +				 <MT8365_PIN_102_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
> +				 <MT8365_PIN_101_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
> +				 <MT8365_PIN_100_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
> +				 <MT8365_PIN_96_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
> +				 <MT8365_PIN_95_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
> +				 <MT8365_PIN_94_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
> +				 <MT8365_PIN_93_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
> +				 <MT8365_PIN_98_MSDC0_CMD__FUNC_MSDC0_CMD>;
> +			input-enable;
> +			drive-strength = <MTK_DRIVE_10mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins-ds {
> +			pinmux = <MT8365_PIN_104_MSDC0_DSL__FUNC_MSDC0_DSL>;
> +			drive-strength = <MTK_DRIVE_10mA>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-rst {
> +			pinmux = <MT8365_PIN_97_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
> +			drive-strength = <MTK_DRIVE_10mA>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	mmc1_pins_default: mmc1-default-pins {
> +		pins-cd {
> +			pinmux = <MT8365_PIN_76_CMDAT8__FUNC_GPIO76>;
> +			bias-pull-up;
> +		};
> +
> +		pins-clk {
> +			pinmux = <MT8365_PIN_88_MSDC1_CLK__FUNC_MSDC1_CLK>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-cmd-dat {
> +			pinmux = <MT8365_PIN_89_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
> +				 <MT8365_PIN_90_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
> +				 <MT8365_PIN_91_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
> +				 <MT8365_PIN_92_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
> +				 <MT8365_PIN_87_MSDC1_CMD__FUNC_MSDC1_CMD>;
> +			input-enable;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +	};
> +
> +	mmc1_pins_uhs: mmc1-uhs-pins {
> +		pins-clk {
> +			pinmux = <MT8365_PIN_88_MSDC1_CLK__FUNC_MSDC1_CLK>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins-cmd-dat {
> +			pinmux = <MT8365_PIN_89_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
> +				 <MT8365_PIN_90_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
> +				 <MT8365_PIN_91_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
> +				 <MT8365_PIN_92_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
> +				 <MT8365_PIN_87_MSDC1_CMD__FUNC_MSDC1_CMD>;
> +			input-enable;
> +			drive-strength = <MTK_DRIVE_6mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +	};
> +
> +	uart0_pins: uart0-pins {
> +		pins {
> +			pinmux = <MT8365_PIN_35_URXD0__FUNC_URXD0>,
> +				 <MT8365_PIN_36_UTXD0__FUNC_UTXD0>;
> +		};
> +	};
> +
> +	uart1_pins: uart1-pins {
> +		pins {
> +			pinmux = <MT8365_PIN_37_URXD1__FUNC_URXD1>,
> +				 <MT8365_PIN_38_UTXD1__FUNC_UTXD1>;
> +		};
> +	};
> +
> +	uart2_pins: uart2-pins {
> +		pins {
> +			pinmux = <MT8365_PIN_39_URXD2__FUNC_URXD2>,
> +				 <MT8365_PIN_40_UTXD2__FUNC_UTXD2>;
> +		};
> +	};
> +
> +	usb_pins: usb-pins {
> +		pins-id {
> +			pinmux = <MT8365_PIN_17_GPIO17__FUNC_GPIO17>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +
> +		pins-usb0-vbus {
> +			pinmux = <MT8365_PIN_16_GPIO16__FUNC_USB_DRVVBUS>;
> +			output-high;
> +		};
> +
> +		pin-usb1-vbus {
> +			pinmux = <MT8365_PIN_18_GPIO18__FUNC_GPIO18>;
> +			output-high;
> +		};
> +	};
> +
> +	pwm_pins: pwm-pins {
> +		pins {
> +			pinmux = <MT8365_PIN_19_DISP_PWM__FUNC_PWM_A>,
> +				 <MT8365_PIN_116_I2S_BCK__FUNC_PWM_C>;
> +		};
> +	};
> +};
> +
> +&pwm {
> +	pinctrl-0 = <&pwm_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-0 = <&uart0_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-0 = <&uart1_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-0 = <&uart2_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> new file mode 100644
> index 0000000000000..1cf2172081b20
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> @@ -0,0 +1,601 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * (C) 2018 MediaTek Inc.
> + * Copyright (C) 2022 BayLibre SAS
> + * Fabien Parent <fparent@baylibre.com>
> + * Bernhard Rosenkränzer <bero@baylibre.com>
> + */
> +#include <dt-bindings/clock/mediatek,mt8365-clk.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +	compatible = "mediatek,mt8365";
> +	interrupt-parent = <&sysirq>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus: cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0: cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +			};
> +		};
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0>;
> +			#cooling-cells = <2>;

I don't see any CPU caches and I'm totally sure that this SoC does have
a unified 512KB unified L2 cache.

> +			enable-method = "psci";
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x1>;
> +			#cooling-cells = <2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x2>;
> +			#cooling-cells = <2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x3>;
> +			#cooling-cells = <2>;
> +			enable-method = "psci";
> +		};
> +	}; > +
> +	clk26m: oscillator {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
> +		clock-output-names = "clk26m";
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};

Does this SoC really not support any idle-state?! Seems pretty odd.

> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 128 KiB reserved for ARM Trusted Firmware (BL31) */
> +		bl31_secmon_reserved: secmon@43000000 {
> +			no-map;
> +			reg = <0 0x43000000 0 0x20000>;
> +		};
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		gic: interrupt-controller@c000000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <4>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0x0c000000 0 0x80000>,
> +			      <0 0x0c080000 0 0x80000>;
> +
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
> +		};
> +
> +		topckgen: syscon@10000000 {
> +			compatible = "mediatek,mt8365-topckgen", "syscon";
> +			reg = <0 0x10000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		infracfg: syscon@10001000 {
> +			compatible = "mediatek,mt8365-infracfg", "syscon";
> +			reg = <0 0x10001000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		pericfg: syscon@10003000 {
> +			compatible = "mediatek,mt8365-pericfg", "syscon";
> +			reg = <0 0x10003000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		syscfg_pctl: syscfg-pctl@10005000 {
> +			compatible = "mediatek,mt8365-syscfg", "syscon";
> +			reg = <0 0x10005000 0 0x1000>;
> +		};
> +
> +		watchdog: watchdog@10007000 {
> +			compatible = "mediatek,mt8365-wdt",
> +				     "mediatek,mt6589-wdt";

83 cols is fine, fits in one line.

> +			reg = <0 0x10007000 0 0x100>;
> +			#reset-cells = <1>;
> +		};
> +
> +		gpt: apxgpt@10008000 {

This should be timer@10008000

> +			compatible = "mediatek,mt8365-timer",
> +				     "mediatek,mt6577-timer";
> +			reg = <0 0x10008000 0 0x1000>;
> +			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_SYS_26M_D2>;
> +			clock-names = "clk13m";
> +		};
> +

..snip..

> +
> +		infracfg: infracfg@1020e000 {
> +			compatible = "mediatek,mt8365-infracfg", "syscon";
> +			reg = <0 0x1020e000 0 0x1000>;
> +		};
> +
> +		rng: rng@1020f000 {
> +			compatible = "mediatek,mt8365-rng",
> +				     "mediatek,mt7623-rng";

Fits in one line.

> +			reg = <0 0x1020f000 0 0x100>;
> +			clocks = <&infracfg CLK_IFR_TRNG>;
> +			clock-names = "rng";
> +		};
> +

..snip..

> +
> +		uart0: serial@11002000 {
> +			compatible = "mediatek,mt8365-uart",
> +				     "mediatek,mt6577-uart";

85 cols is probably fine, so this should fit in one line.

> +			reg = <0 0x11002000 0 0x1000>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&clk26m>, <&infracfg CLK_IFR_UART0>;
> +			clock-names = "baud", "bus";
> +			dmas = <&apdma 0>, <&apdma 1>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +

..snip..

> +
> +		i2c0: i2c@11007000 {
> +			compatible = "mediatek,mt8365-i2c",
> +				     "mediatek,mt8168-i2c";

Fits in one line.

> +			reg = <0 0x11007000 0 0xa0>,
> +			      <0 0x11000080 0 0x80>;

Same.

> +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_LOW>;
> +			clock-div = <1>;
> +			clocks = <&infracfg CLK_IFR_I2C0_AXI>,
> +				 <&infracfg CLK_IFR_AP_DMA>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@11008000 {
> +			compatible = "mediatek,mt8365-i2c",
> +				     "mediatek,mt8168-i2c";
> +			reg = <0 0x11008000 0 0xa0>,
> +			      <0 0x11000100 0 0x80>;

...again...

> +			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_LOW>;
> +			clock-div = <1>;
> +			clocks = <&infracfg CLK_IFR_I2C1_AXI>,
> +				 <&infracfg CLK_IFR_AP_DMA>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@11009000 {
> +			compatible = "mediatek,mt8365-i2c",
> +				     "mediatek,mt8168-i2c";
> +			reg = <0 0x11009000 0 0xa0>,
> +			      <0 0x11000180 0 0x80>;

...and again...

> +			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_LOW>;
> +			clock-div = <1>;
> +			clocks = <&infracfg CLK_IFR_I2C2_AXI>,
> +				 <&infracfg CLK_IFR_AP_DMA>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		spi: spi@1100a000 {
> +			compatible = "mediatek,mt8365-spi",
> +				     "mediatek,mt7622-spi";

...and it's the same here again...
I'll stop saying the same at every instance, so please check the others :-)

> +			reg = <0 0x1100a000 0 0x100>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&topckgen CLK_TOP_UNIVPLL2_D4>,
> +				 <&topckgen CLK_TOP_SPI_SEL>,
> +				 <&infracfg CLK_IFR_SPI0>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +			status = "disabled";
> +		};
> +

Regards,
Angelo

