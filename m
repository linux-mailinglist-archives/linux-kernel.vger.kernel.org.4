Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C776139B8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiJaPMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiJaPMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:12:33 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B63F10542;
        Mon, 31 Oct 2022 08:12:31 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id r76-20020a4a374f000000b004988a70de2eso955304oor.2;
        Mon, 31 Oct 2022 08:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CP0krSZOun70Fwzk3M6Gyju9VSkkwZYgRzqRUjoDjcE=;
        b=IJ4oTpImuNquN8ITUjD+AFNcrmr0gDDMUgC8FekzJbR6V0S/vMUcfn9PELwJKCUM0d
         Mqo7+2UKVBGBAFAIU7NjGKxvwPD62GKnDHhAON7/qh+VMok4T5vWvQJ8j66/sHSs5rbm
         g5joDG5NUQFBbbB+ga9NepgDbH/C5L7wR8Bx2Z76kjvMjO4wtyKKH7aIFulxY8aZkQ8O
         hzcmD9Z0x82ksckOwkiHZMNZeUDx3PsyKnVM4YK8INn6iSpYdmmu+H1DzwnqanN5sdYp
         oiawBnAQeRm/sSN9E6XPOUAL8S6rBHAs97MNzM/1kZ4PQQlC5XtXIZNLRok3k9yZwJVV
         GthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CP0krSZOun70Fwzk3M6Gyju9VSkkwZYgRzqRUjoDjcE=;
        b=gaNwge0a9C+weTCJ6rmRSHfzXNZXPkS+4u/7AHU9HcTBzpeBRr/91JgDdfdWJ5mfiL
         xlt5wMh/+ByzgAtmXZcL+TMBl5zBqFPtRy8ny4OF+gBZRSFc48XoLYteMsPdgVi/bOEV
         eJ+gU67mdI+AkiVIxCh+bcGdP1KiTsUcoRmEW6zDDzhp1jH5lbL+r1BNqaTGGocvtKKd
         0Hw07tkGynLvodJ76ByhaIUugwRaU0LPX2fSDjav7kogMGhoQsM1nGqCxy+OyAmHPXvk
         qS1fcvONgkS6VYxM8xyNuL3dTNtISB1+fDM9fMSkPqYEX0x/4lhJJk41vWfgJwtYkKD2
         CrWQ==
X-Gm-Message-State: ACrzQf3AtyVFKsouLXLN7lCAtQscMEk0C8C4RUxgP0yV+oOhMqZvb4ol
        M4nKeCU+z2LHI6wckWNl9+w=
X-Google-Smtp-Source: AMsMyM45csrzE6FbBuBe/6cP1++8BE84+8vtY9RRgQVd502dDeFuCwCXr5nrUI3NxFYXCgtav2rPTg==
X-Received: by 2002:a4a:4e41:0:b0:480:8a3c:a797 with SMTP id r62-20020a4a4e41000000b004808a3ca797mr5639569ooa.71.1667229150685;
        Mon, 31 Oct 2022 08:12:30 -0700 (PDT)
Received: from wintermute.localdomain ([76.244.6.13])
        by smtp.gmail.com with ESMTPSA id t27-20020a05683022fb00b00667d9a866b0sm2833648otc.59.2022.10.31.08.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 08:12:30 -0700 (PDT)
Date:   Mon, 31 Oct 2022 10:12:22 -0500
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Maya Matuszczyk <maccraft123mc@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, macroalpha@hotmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: Move most of Odroid Go Advance
 DTS into DTSI
Message-ID: <20221031151222.GA25690@wintermute.localdomain>
References: <20221006174519.46161-1-maccraft123mc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006174519.46161-1-maccraft123mc@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 07:45:17PM +0200, Maya Matuszczyk wrote:
> In preparation to adding Odroid Go Advance Black Edition, which is just
> Odroid Go Advance with wifi card and two more buttons, and Odroid Go
> Super this patch moves almost all of Odroid Go Advance DTS into a DTSI
> to not duplicate code.
> 

A few comments. Thanks for this by the way. If this is good maybe we
can also get the Odroid Go Super landed too (different panel and
battery but otherwise identical hardware).

Thank you.

> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  .../boot/dts/rockchip/rk3326-odroid-go.dtsi   | 652 +++++++++++++++++
>  .../boot/dts/rockchip/rk3326-odroid-go2.dts   | 658 +-----------------
>  2 files changed, 654 insertions(+), 656 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi
> new file mode 100644
> index 000000000000..c129f978396c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi
> @@ -0,0 +1,652 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Hardkernel Co., Ltd
> + * Copyright (c) 2020 Theobroma Systems Design und Consulting GmbH
> + * Copyright (c) 2022 Maya Matuszczyk <maccraft123mc@gmail.com>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include "rk3326.dtsi"
> +
> +/ {
> +	aliases {
> +		mmc0 = &sdmmc;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	adc-joystick {
> +		compatible = "adc-joystick";
> +		io-channels = <&saradc 1>,
> +			      <&saradc 2>;

Polled mode was just approved for upstream, so add "poll-interval"
here. Additionally, if you want to make this for the OGS too maybe
make this device specific, as the OGS has an ADC mux and dual
analog sticks.

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		axis@0 {
> +			reg = <0>;
> +			abs-flat = <10>;
> +			abs-fuzz = <10>;
> +			abs-range = <172 772>;
> +			linux,code = <ABS_X>;
> +		};
> +
> +		axis@1 {
> +			reg = <1>;
> +			abs-flat = <10>;
> +			abs-fuzz = <10>;
> +			abs-range = <278 815>;
> +			linux,code = <ABS_Y>;
> +		};
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		power-supply = <&vcc_bl>;
> +		pwms = <&pwm1 0 25000 0>;
> +	};
> +
> +	battery: battery {
> +		compatible = "simple-battery";
> +		charge-full-design-microamp-hours = <3000000>;
> +		charge-term-current-microamp = <300000>;
> +		constant-charge-current-max-microamp = <2000000>;
> +		constant-charge-voltage-max-microvolt = <4200000>;
> +		factory-internal-resistance-micro-ohms = <180000>;
> +		voltage-max-design-microvolt = <4100000>;
> +		voltage-min-design-microvolt = <3500000>;
> +
> +		ocv-capacity-celsius = <20>;
> +		ocv-capacity-table-0 =  <4046950 100>, <4001920 95>, <3967900 90>, <3919950 85>,
> +					<3888450 80>, <3861850 75>, <3831540 70>, <3799130 65>,
> +					<3768190 60>, <3745650 55>, <3726610 50>, <3711630 45>,
> +					<3696720 40>, <3685660 35>, <3674950 30>, <3663050 25>,
> +					<3649470 20>, <3635260 15>, <3616920 10>, <3592440 5>,
> +					<3574170 0>;
> +	};
> +

If you decide to use this as a "base" to support the OGS, you might
consider making the battery per device, as the battery is different
on the OGS.

> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&btn_pins>;
> +
> +		button-sw1 {
> +			gpios = <&gpio1 RK_PB4 GPIO_ACTIVE_LOW>;
> +			label = "DPAD-UP";
> +			linux,code = <BTN_DPAD_UP>;
> +		};
> +		button-sw2 {
> +			gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_LOW>;
> +			label = "DPAD-DOWN";
> +			linux,code = <BTN_DPAD_DOWN>;
> +		};
> +		button-sw3 {
> +			gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_LOW>;
> +			label = "DPAD-LEFT";
> +			linux,code = <BTN_DPAD_LEFT>;
> +		};
> +		button-sw4 {
> +			gpios = <&gpio1 RK_PB7 GPIO_ACTIVE_LOW>;
> +			label = "DPAD-RIGHT";
> +			linux,code = <BTN_DPAD_RIGHT>;
> +		};
> +		button-sw5 {
> +			gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_LOW>;
> +			label = "BTN-A";
> +			linux,code = <BTN_EAST>;
> +		};
> +		button-sw6 {
> +			gpios = <&gpio1 RK_PA5 GPIO_ACTIVE_LOW>;
> +			label = "BTN-B";
> +			linux,code = <BTN_SOUTH>;
> +		};
> +		button-sw7 {
> +			gpios = <&gpio1 RK_PA6 GPIO_ACTIVE_LOW>;
> +			label = "BTN-Y";
> +			linux,code = <BTN_WEST>;
> +		};
> +		button-sw8 {
> +			gpios = <&gpio1 RK_PA7 GPIO_ACTIVE_LOW>;
> +			label = "BTN-X";
> +			linux,code = <BTN_NORTH>;
> +		};
> +		button-sw9 {
> +			gpios = <&gpio2 RK_PA0 GPIO_ACTIVE_LOW>;
> +			label = "F1";
> +			linux,code = <BTN_TRIGGER_HAPPY1>;
> +		};
> +		button-sw10 {
> +			gpios = <&gpio2 RK_PA1 GPIO_ACTIVE_LOW>;
> +			label = "F2";
> +			linux,code = <BTN_TRIGGER_HAPPY2>;
> +		};
> +		button-sw11 {
> +			gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_LOW>;
> +			label = "F3";
> +			linux,code = <BTN_TRIGGER_HAPPY3>;
> +		};
> +		button-sw12 {
> +			gpios = <&gpio2 RK_PA3 GPIO_ACTIVE_LOW>;
> +			label = "F4";
> +			linux,code = <BTN_TRIGGER_HAPPY4>;
> +		};
> +		button-sw13 {
> +			gpios = <&gpio2 RK_PA4 GPIO_ACTIVE_LOW>;
> +			label = "F5";
> +			linux,code = <BTN_TRIGGER_HAPPY5>;
> +		};
> +		button-sw14 {
> +			gpios = <&gpio2 RK_PA5 GPIO_ACTIVE_LOW>;
> +			label = "F6";
> +			linux,code = <BTN_TRIGGER_HAPPY6>;
> +		};
> +		button-sw15 {
> +			gpios = <&gpio2 RK_PA6 GPIO_ACTIVE_LOW>;
> +			label = "TOP-LEFT";
> +			linux,code = <BTN_TL>;
> +		};
> +		button-sw16 {
> +			gpios = <&gpio2 RK_PA7 GPIO_ACTIVE_LOW>;
> +			label = "TOP-RIGHT";
> +			linux,code = <BTN_TR>;
> +		};
> +	};
> +
> +	leds: gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&blue_led_pin>;
> +
> +		blue_led: led-0 {
> +			label = "blue:heartbeat";
> +			gpios = <&gpio0 RK_PC1 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	rk817-sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "Analog";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,hp-det-gpio = <&gpio2 RK_PC6 GPIO_ACTIVE_HIGH>;
> +		simple-audio-card,mclk-fs = <256>;
> +		simple-audio-card,widgets =
> +			"Microphone", "Mic Jack",
> +			"Headphone", "Headphones",
> +			"Speaker", "Speaker";
> +		simple-audio-card,routing =
> +			"MICL", "Mic Jack",
> +			"Headphones", "HPOL",
> +			"Headphones", "HPOR",
> +			"Speaker", "SPKO";
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&rk817>;
> +		};
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&i2s1_2ch>;
> +		};
> +	};
> +
> +	vccsys: vccsys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v8_sys";
> +		regulator-always-on;
> +		regulator-min-microvolt = <3800000>;
> +		regulator-max-microvolt = <3800000>;
> +	};
> +
> +	vcc_host: vcc_host {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_host";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +
> +		gpio = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&usb_midu>;
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&cru {
> +	assigned-clocks = <&cru PLL_NPLL>,
> +		<&cru ACLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
> +		<&cru HCLK_BUS_PRE>, <&cru HCLK_PERI_PRE>,
> +		<&cru PCLK_BUS_PRE>, <&cru SCLK_GPU>,
> +		<&cru PLL_CPLL>;
> +
> +	assigned-clock-rates = <1188000000>,
> +		<200000000>, <200000000>,
> +		<150000000>, <150000000>,
> +		<100000000>, <200000000>,
> +		<17000000>;
> +};
> +
> +&display_subsystem {
> +	status = "okay";
> +};
> +
> +&dsi {
> +	status = "okay";
> +
> +	ports {
> +		mipi_out: port@1 {
> +			reg = <1>;
> +
> +			mipi_out_panel: endpoint {
> +				remote-endpoint = <&mipi_in_panel>;
> +			};
> +		};
> +	};
> +
> +	panel@0 {
> +		compatible = "elida,kd35t133";
> +		reg = <0>;
> +		backlight = <&backlight>;
> +		iovcc-supply = <&vcc_lcd>;
> +		reset-gpios = <&gpio3 RK_PC0 GPIO_ACTIVE_LOW>;
> +		rotation = <270>;
> +		vdd-supply = <&vcc_lcd>;
> +
> +		port {
> +			mipi_in_panel: endpoint {
> +				remote-endpoint = <&mipi_out_panel>;
> +			};
> +		};
> +	};

Ditto here in regards to OGS, as panel differs.

> +};
> +
> +&dsi_dphy {
> +	status = "okay";
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_logic>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	clock-frequency = <400000>;
> +	i2c-scl-falling-time-ns = <16>;
> +	i2c-scl-rising-time-ns = <280>;
> +	status = "okay";
> +
> +	rk817: pmic@20 {
> +		compatible = "rockchip,rk817";
> +		reg = <0x20>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PB2 IRQ_TYPE_LEVEL_LOW>;
> +		clock-output-names = "rk808-clkout1", "xin32k";
> +		clock-names = "mclk";
> +		clocks = <&cru SCLK_I2S1_OUT>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int>, <&i2s1_2ch_mclk>;
> +		wakeup-source;
> +		#clock-cells = <1>;
> +		#sound-dai-cells = <0>;
> +
> +		vcc1-supply = <&vccsys>;
> +		vcc2-supply = <&vccsys>;
> +		vcc3-supply = <&vccsys>;
> +		vcc4-supply = <&vccsys>;
> +		vcc5-supply = <&vccsys>;
> +		vcc6-supply = <&vccsys>;
> +		vcc7-supply = <&vccsys>;
> +		vcc8-supply = <&vccsys>;
> +
> +		regulators {
> +			vdd_logic: DCDC_REG1 {
> +				regulator-name = "vdd_logic";
> +				regulator-min-microvolt = <950000>;
> +				regulator-max-microvolt = <1150000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <950000>;
> +				};
> +			};
> +
> +			vdd_arm: DCDC_REG2 {
> +				regulator-name = "vdd_arm";
> +				regulator-min-microvolt = <950000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <950000>;
> +				};
> +			};
> +
> +			vcc_ddr: DCDC_REG3 {
> +				regulator-name = "vcc_ddr";
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v3: DCDC_REG4 {
> +				regulator-name = "vcc_3v3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vcc_1v8: LDO_REG2 {
> +				regulator-name = "vcc_1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vdd_1v0: LDO_REG3 {
> +				regulator-name = "vdd_1v0";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1000000>;
> +				};
> +			};
> +
> +			vcc3v3_pmu: LDO_REG4 {
> +				regulator-name = "vcc3v3_pmu";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vccio_sd: LDO_REG5 {
> +				regulator-name = "vccio_sd";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vcc_sd: LDO_REG6 {
> +				regulator-name = "vcc_sd";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vcc_bl: LDO_REG7 {
> +				regulator-name = "vcc_bl";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vcc_lcd: LDO_REG8 {
> +				regulator-name = "vcc_lcd";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <2800000>;
> +				};
> +			};
> +
> +			vcc_cam: LDO_REG9 {
> +				regulator-name = "vcc_cam";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <3000000>;
> +				};
> +			};

While this has been here for a while, we can probably delete the
vcc_cam regulator as it does not exist/is not used on the OGA and OGS.
Only on the OGA_BE is it used where it is a wifi regulator. Recommend
renaming it too.

> +
> +			usb_midu: BOOST {
> +				regulator-name = "usb_midu";
> +				regulator-min-microvolt = <5000000>;
> +				regulator-max-microvolt = <5400000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +		};
> +
> +		rk817_charger: charger {
> +			monitored-battery = <&battery>;
> +			rockchip,resistor-sense-micro-ohms = <10000>;
> +			rockchip,sleep-enter-current-microamp = <300000>;
> +			rockchip,sleep-filter-current-microamp = <100000>;
> +		};
> +
> +		rk817_codec: codec {
> +			rockchip,mic-in-differential;
> +		};
> +	};
> +};
> +
> +/* EXT Header(P2): 7(SCL:GPIO0.C2), 8(SDA:GPIO0.C3) */
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +/* I2S 1 Channel Used */
> +&i2s1_2ch {
> +	status = "okay";
> +};
> +
> +&io_domains {
> +	vccio1-supply = <&vcc_3v3>;
> +	vccio2-supply = <&vccio_sd>;
> +	vccio3-supply = <&vcc_3v3>;
> +	vccio4-supply = <&vcc_3v3>;
> +	vccio5-supply = <&vcc_3v3>;
> +	vccio6-supply = <&vcc_3v3>;
> +	status = "okay";
> +};
> +
> +&pmu_io_domains {
> +	pmuio1-supply = <&vcc3v3_pmu>;
> +	pmuio2-supply = <&vcc3v3_pmu>;
> +	status = "okay";
> +};
> +
> +&pwm1 {
> +	status = "okay";
> +};
> +
> +&saradc {
> +	vref-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
> +&sdmmc {
> +	cap-sd-highspeed;
> +	card-detect-delay = <200>;
> +	cd-gpios = <&gpio0 RK_PA3 GPIO_ACTIVE_LOW>; /*[> CD GPIO <]*/
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	vmmc-supply = <&vcc_sd>;
> +	vqmmc-supply = <&vccio_sd>;
> +	status = "okay";
> +};
> +
> +&sfc {
> +	pinctrl-0 = <&sfc_clk &sfc_cs0 &sfc_bus2>;
> +	pinctrl-names = "default";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <108000000>;
> +		spi-rx-bus-width = <2>;
> +		spi-tx-bus-width = <1>;
> +	};
> +};
> +
> +&tsadc {
> +	status = "okay";
> +};
> +
> +&u2phy {
> +	status = "okay";
> +
> +	u2phy_host: host-port {
> +		status = "okay";
> +	};
> +
> +	u2phy_otg: otg-port {
> +		status = "disabled";
> +	};
> +};
> +
> +&usb20_otg {
> +	status = "okay";
> +};
> +
> +/* EXT Header(P2): 2(RXD:GPIO1.C0),3(TXD:.C1),4(CTS:.C2),5(RTS:.C3) */
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_xfer &uart1_cts>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2m1_xfer>;
> +	status = "okay";
> +};
> +
> +&vopb {
> +	status = "okay";
> +};
> +
> +&vopb_mmu {
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	btns {
> +		btn_pins: btn-pins {
> +			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>,
> +					<1 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>,
> +					<1 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
> +					<1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>,
> +					<1 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>,
> +					<1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>,
> +					<1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up>,
> +					<1 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up>,
> +					<2 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>,
> +					<2 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>,
> +					<2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>,
> +					<2 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>,
> +					<2 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>,
> +					<2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>,
> +					<2 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
> +					<2 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	headphone {
> +		hp_det: hp-det {
> +			rockchip,pins = <2 RK_PC6 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +
> +	leds {
> +		blue_led_pin: blue-led-pin {
> +			rockchip,pins = <0 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pmic {
> +		dc_det: dc-det {
> +			rockchip,pins = <0 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		pmic_int: pmic-int {
> +			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		soc_slppin_gpio: soc_slppin_gpio {
> +			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_output_low>;
> +		};
> +
> +		soc_slppin_rst: soc_slppin_rst {
> +			rockchip,pins = <0 RK_PA4 2 &pcfg_pull_none>;
> +		};
> +
> +		soc_slppin_slp: soc_slppin_slp {
> +			rockchip,pins = <0 RK_PA4 1 &pcfg_pull_none>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
> index 72899a714310..03cb19560f9b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
> @@ -2,667 +2,13 @@
>  /*
>   * Copyright (c) 2019 Hardkernel Co., Ltd
>   * Copyright (c) 2020 Theobroma Systems Design und Consulting GmbH
> + * Copyright (c) 2022 Maya Matuszczyk <maccraft123mc@gmail.com>
>   */
>  
>  /dts-v1/;
> -#include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/input/input.h>
> -#include <dt-bindings/pinctrl/rockchip.h>
> -#include "rk3326.dtsi"
> +#include "rk3326-odroid-go.dtsi"
>  
>  / {
>  	model = "ODROID-GO Advance";
>  	compatible = "hardkernel,rk3326-odroid-go2", "rockchip,rk3326";
> -
> -	aliases {
> -		mmc0 = &sdmmc;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial2:115200n8";
> -	};
> -
> -	adc-joystick {
> -		compatible = "adc-joystick";
> -		io-channels = <&saradc 1>,
> -			      <&saradc 2>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		axis@0 {
> -			reg = <0>;
> -			abs-flat = <10>;
> -			abs-fuzz = <10>;
> -			abs-range = <172 772>;
> -			linux,code = <ABS_X>;
> -		};
> -
> -		axis@1 {
> -			reg = <1>;
> -			abs-flat = <10>;
> -			abs-fuzz = <10>;
> -			abs-range = <278 815>;
> -			linux,code = <ABS_Y>;
> -		};
> -	};
> -
> -	backlight: backlight {
> -		compatible = "pwm-backlight";
> -		power-supply = <&vcc_bl>;
> -		pwms = <&pwm1 0 25000 0>;
> -	};
> -
> -	battery: battery {
> -		compatible = "simple-battery";
> -		charge-full-design-microamp-hours = <3000000>;
> -		charge-term-current-microamp = <300000>;
> -		constant-charge-current-max-microamp = <2000000>;
> -		constant-charge-voltage-max-microvolt = <4200000>;
> -		factory-internal-resistance-micro-ohms = <180000>;
> -		voltage-max-design-microvolt = <4100000>;
> -		voltage-min-design-microvolt = <3500000>;
> -
> -		ocv-capacity-celsius = <20>;
> -		ocv-capacity-table-0 =	<4046950 100>, <4001920 95>, <3967900 90>, <3919950 85>,
> -					<3888450 80>, <3861850 75>, <3831540 70>, <3799130 65>,
> -					<3768190 60>, <3745650 55>, <3726610 50>, <3711630 45>,
> -					<3696720 40>, <3685660 35>, <3674950 30>, <3663050 25>,
> -					<3649470 20>, <3635260 15>, <3616920 10>, <3592440 5>,
> -					<3574170 0>;
> -	};
> -
> -	gpio-keys {
> -		compatible = "gpio-keys";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&btn_pins>;
> -
> -		/*
> -		 *      *** ODROIDGO2-Advance Switch layout ***
> -		 * |------------------------------------------------|
> -		 * | sw15                                      sw16 |
> -		 * |------------------------------------------------|
> -		 * |     sw1      |-------------------|      sw8    |
> -		 * |  sw3   sw4   |                   |   sw7   sw5 |
> -		 * |     sw2      |    LCD Display    |      sw6    |
> -		 * |              |                   |             |
> -		 * |              |-------------------|             |
> -		 * |         sw9 sw10   sw11 sw12   sw13 sw14       |
> -		 * |------------------------------------------------|
> -		 */
> -
> -		button-sw1 {
> -			gpios = <&gpio1 RK_PB4 GPIO_ACTIVE_LOW>;
> -			label = "DPAD-UP";
> -			linux,code = <BTN_DPAD_UP>;
> -		};
> -		button-sw2 {
> -			gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_LOW>;
> -			label = "DPAD-DOWN";
> -			linux,code = <BTN_DPAD_DOWN>;
> -		};
> -		button-sw3 {
> -			gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_LOW>;
> -			label = "DPAD-LEFT";
> -			linux,code = <BTN_DPAD_LEFT>;
> -		};
> -		button-sw4 {
> -			gpios = <&gpio1 RK_PB7 GPIO_ACTIVE_LOW>;
> -			label = "DPAD-RIGHT";
> -			linux,code = <BTN_DPAD_RIGHT>;
> -		};
> -		button-sw5 {
> -			gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_LOW>;
> -			label = "BTN-A";
> -			linux,code = <BTN_EAST>;
> -		};
> -		button-sw6 {
> -			gpios = <&gpio1 RK_PA5 GPIO_ACTIVE_LOW>;
> -			label = "BTN-B";
> -			linux,code = <BTN_SOUTH>;
> -		};
> -		button-sw7 {
> -			gpios = <&gpio1 RK_PA6 GPIO_ACTIVE_LOW>;
> -			label = "BTN-Y";
> -			linux,code = <BTN_WEST>;
> -		};
> -		button-sw8 {
> -			gpios = <&gpio1 RK_PA7 GPIO_ACTIVE_LOW>;
> -			label = "BTN-X";
> -			linux,code = <BTN_NORTH>;
> -		};
> -		button-sw9 {
> -			gpios = <&gpio2 RK_PA0 GPIO_ACTIVE_LOW>;
> -			label = "F1";
> -			linux,code = <BTN_TRIGGER_HAPPY1>;
> -		};
> -		button-sw10 {
> -			gpios = <&gpio2 RK_PA1 GPIO_ACTIVE_LOW>;
> -			label = "F2";
> -			linux,code = <BTN_TRIGGER_HAPPY2>;
> -		};
> -		button-sw11 {
> -			gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_LOW>;
> -			label = "F3";
> -			linux,code = <BTN_TRIGGER_HAPPY3>;
> -		};
> -		button-sw12 {
> -			gpios = <&gpio2 RK_PA3 GPIO_ACTIVE_LOW>;
> -			label = "F4";
> -			linux,code = <BTN_TRIGGER_HAPPY4>;
> -		};
> -		button-sw13 {
> -			gpios = <&gpio2 RK_PA4 GPIO_ACTIVE_LOW>;
> -			label = "F5";
> -			linux,code = <BTN_TRIGGER_HAPPY5>;
> -		};
> -		button-sw14 {
> -			gpios = <&gpio2 RK_PA5 GPIO_ACTIVE_LOW>;
> -			label = "F6";
> -			linux,code = <BTN_TRIGGER_HAPPY6>;
> -		};
> -		button-sw15 {
> -			gpios = <&gpio2 RK_PA6 GPIO_ACTIVE_LOW>;
> -			label = "TOP-LEFT";
> -			linux,code = <BTN_TL>;
> -		};
> -		button-sw16 {
> -			gpios = <&gpio2 RK_PA7 GPIO_ACTIVE_LOW>;
> -			label = "TOP-RIGHT";
> -			linux,code = <BTN_TR>;
> -		};
> -	};
> -
> -	leds: gpio-leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&blue_led_pin>;
> -
> -		blue_led: led-0 {
> -			label = "blue:heartbeat";
> -			gpios = <&gpio0 RK_PC1 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "heartbeat";
> -		};
> -	};
> -
> -	rk817-sound {
> -		compatible = "simple-audio-card";
> -		simple-audio-card,name = "Analog";
> -		simple-audio-card,format = "i2s";
> -		simple-audio-card,hp-det-gpio = <&gpio2 RK_PC6 GPIO_ACTIVE_HIGH>;
> -		simple-audio-card,mclk-fs = <256>;
> -		simple-audio-card,widgets =
> -			"Microphone", "Mic Jack",
> -			"Headphone", "Headphones",
> -			"Speaker", "Speaker";
> -		simple-audio-card,routing =
> -			"MICL", "Mic Jack",
> -			"Headphones", "HPOL",
> -			"Headphones", "HPOR",
> -			"Speaker", "SPKO";
> -
> -		simple-audio-card,codec {
> -			sound-dai = <&rk817>;
> -		};
> -
> -		simple-audio-card,cpu {
> -			sound-dai = <&i2s1_2ch>;
> -		};
> -	};
> -
> -	vccsys: vccsys {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc3v8_sys";
> -		regulator-always-on;
> -		regulator-min-microvolt = <3800000>;
> -		regulator-max-microvolt = <3800000>;
> -	};
> -
> -	vcc_host: vcc_host {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc_host";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -
> -		gpio = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&usb_midu>;
> -	};
> -};
> -
> -&cpu0 {
> -	cpu-supply = <&vdd_arm>;
> -};
> -
> -&cpu1 {
> -	cpu-supply = <&vdd_arm>;
> -};
> -
> -&cpu2 {
> -	cpu-supply = <&vdd_arm>;
> -};
> -
> -&cpu3 {
> -	cpu-supply = <&vdd_arm>;
> -};
> -
> -&cru {
> -	assigned-clocks = <&cru PLL_NPLL>,
> -		<&cru ACLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
> -		<&cru HCLK_BUS_PRE>, <&cru HCLK_PERI_PRE>,
> -		<&cru PCLK_BUS_PRE>, <&cru SCLK_GPU>,
> -		<&cru PLL_CPLL>;
> -
> -	assigned-clock-rates = <1188000000>,
> -		<200000000>, <200000000>,
> -		<150000000>, <150000000>,
> -		<100000000>, <200000000>,
> -		<17000000>;
> -};
> -
> -&display_subsystem {
> -	status = "okay";
> -};
> -
> -&dsi {
> -	status = "okay";
> -
> -	ports {
> -		mipi_out: port@1 {
> -			reg = <1>;
> -
> -			mipi_out_panel: endpoint {
> -				remote-endpoint = <&mipi_in_panel>;
> -			};
> -		};
> -	};
> -
> -	panel@0 {
> -		compatible = "elida,kd35t133";
> -		reg = <0>;
> -		backlight = <&backlight>;
> -		iovcc-supply = <&vcc_lcd>;
> -		reset-gpios = <&gpio3 RK_PC0 GPIO_ACTIVE_LOW>;
> -		rotation = <270>;
> -		vdd-supply = <&vcc_lcd>;
> -
> -		port {
> -			mipi_in_panel: endpoint {
> -				remote-endpoint = <&mipi_out_panel>;
> -			};
> -		};
> -	};
> -};
> -
> -&dsi_dphy {
> -	status = "okay";
> -};
> -
> -&gpu {
> -	mali-supply = <&vdd_logic>;
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	clock-frequency = <400000>;
> -	i2c-scl-falling-time-ns = <16>;
> -	i2c-scl-rising-time-ns = <280>;
> -	status = "okay";
> -
> -	rk817: pmic@20 {
> -		compatible = "rockchip,rk817";
> -		reg = <0x20>;
> -		interrupt-parent = <&gpio0>;
> -		interrupts = <RK_PB2 IRQ_TYPE_LEVEL_LOW>;
> -		clock-output-names = "rk808-clkout1", "xin32k";
> -		clock-names = "mclk";
> -		clocks = <&cru SCLK_I2S1_OUT>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int>, <&i2s1_2ch_mclk>;
> -		wakeup-source;
> -		#clock-cells = <1>;
> -		#sound-dai-cells = <0>;
> -
> -		vcc1-supply = <&vccsys>;
> -		vcc2-supply = <&vccsys>;
> -		vcc3-supply = <&vccsys>;
> -		vcc4-supply = <&vccsys>;
> -		vcc5-supply = <&vccsys>;
> -		vcc6-supply = <&vccsys>;
> -		vcc7-supply = <&vccsys>;
> -		vcc8-supply = <&vccsys>;
> -
> -		regulators {
> -			vdd_logic: DCDC_REG1 {
> -				regulator-name = "vdd_logic";
> -				regulator-min-microvolt = <950000>;
> -				regulator-max-microvolt = <1150000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <950000>;
> -				};
> -			};
> -
> -			vdd_arm: DCDC_REG2 {
> -				regulator-name = "vdd_arm";
> -				regulator-min-microvolt = <950000>;
> -				regulator-max-microvolt = <1350000>;
> -				regulator-ramp-delay = <6001>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <950000>;
> -				};
> -			};
> -
> -			vcc_ddr: DCDC_REG3 {
> -				regulator-name = "vcc_ddr";
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -				};
> -			};
> -
> -			vcc_3v3: DCDC_REG4 {
> -				regulator-name = "vcc_3v3";
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vcc_1v8: LDO_REG2 {
> -				regulator-name = "vcc_1v8";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <1800000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1800000>;
> -				};
> -			};
> -
> -			vdd_1v0: LDO_REG3 {
> -				regulator-name = "vdd_1v0";
> -				regulator-min-microvolt = <1000000>;
> -				regulator-max-microvolt = <1000000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <1000000>;
> -				};
> -			};
> -
> -			vcc3v3_pmu: LDO_REG4 {
> -				regulator-name = "vcc3v3_pmu";
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vccio_sd: LDO_REG5 {
> -				regulator-name = "vccio_sd";
> -				regulator-min-microvolt = <1800000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vcc_sd: LDO_REG6 {
> -				regulator-name = "vcc_sd";
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-boot-on;
> -
> -				regulator-state-mem {
> -					regulator-on-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vcc_bl: LDO_REG7 {
> -				regulator-name = "vcc_bl";
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <3300000>;
> -				};
> -			};
> -
> -			vcc_lcd: LDO_REG8 {
> -				regulator-name = "vcc_lcd";
> -				regulator-min-microvolt = <2800000>;
> -				regulator-max-microvolt = <2800000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <2800000>;
> -				};
> -			};
> -
> -			vcc_cam: LDO_REG9 {
> -				regulator-name = "vcc_cam";
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -
> -				regulator-state-mem {
> -					regulator-off-in-suspend;
> -					regulator-suspend-microvolt = <3000000>;
> -				};
> -			};
> -
> -			usb_midu: BOOST {
> -				regulator-name = "usb_midu";
> -				regulator-min-microvolt = <5000000>;
> -				regulator-max-microvolt = <5400000>;
> -				regulator-always-on;
> -				regulator-boot-on;
> -			};
> -		};
> -
> -		rk817_charger: charger {
> -			monitored-battery = <&battery>;
> -			rockchip,resistor-sense-micro-ohms = <10000>;
> -			rockchip,sleep-enter-current-microamp = <300000>;
> -			rockchip,sleep-filter-current-microamp = <100000>;
> -		};
> -
> -		rk817_codec: codec {
> -			rockchip,mic-in-differential;
> -		};
> -	};
> -};
> -
> -/* EXT Header(P2): 7(SCL:GPIO0.C2), 8(SDA:GPIO0.C3) */
> -&i2c1 {
> -	clock-frequency = <400000>;
> -	status = "okay";
> -};
> -
> -/* I2S 1 Channel Used */
> -&i2s1_2ch {
> -	status = "okay";
> -};
> -
> -&io_domains {
> -	vccio1-supply = <&vcc_3v3>;
> -	vccio2-supply = <&vccio_sd>;
> -	vccio3-supply = <&vcc_3v3>;
> -	vccio4-supply = <&vcc_3v3>;
> -	vccio5-supply = <&vcc_3v3>;
> -	vccio6-supply = <&vcc_3v3>;
> -	status = "okay";
> -};
> -
> -&pmu_io_domains {
> -	pmuio1-supply = <&vcc3v3_pmu>;
> -	pmuio2-supply = <&vcc3v3_pmu>;
> -	status = "okay";
> -};
> -
> -&pwm1 {
> -	status = "okay";
> -};
> -
> -&saradc {
> -	vref-supply = <&vcc_1v8>;
> -	status = "okay";
> -};
> -
> -&sdmmc {
> -	cap-sd-highspeed;
> -	card-detect-delay = <200>;
> -	cd-gpios = <&gpio0 RK_PA3 GPIO_ACTIVE_LOW>; /*[> CD GPIO <]*/
> -	sd-uhs-sdr12;
> -	sd-uhs-sdr25;
> -	sd-uhs-sdr50;
> -	sd-uhs-sdr104;
> -	vmmc-supply = <&vcc_sd>;
> -	vqmmc-supply = <&vccio_sd>;
> -	status = "okay";
> -};
> -
> -&sfc {
> -	pinctrl-0 = <&sfc_clk &sfc_cs0 &sfc_bus2>;
> -	pinctrl-names = "default";
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -	status = "okay";
> -
> -	flash@0 {
> -		compatible = "jedec,spi-nor";
> -		reg = <0>;
> -		spi-max-frequency = <108000000>;
> -		spi-rx-bus-width = <2>;
> -		spi-tx-bus-width = <1>;
> -	};
> -};
> -
> -&tsadc {
> -	status = "okay";
> -};
> -
> -&u2phy {
> -	status = "okay";
> -
> -	u2phy_host: host-port {
> -		status = "okay";
> -	};
> -
> -	u2phy_otg: otg-port {
> -		status = "disabled";
> -	};
> -};
> -
> -&usb20_otg {
> -	status = "okay";
> -};
> -
> -/* EXT Header(P2): 2(RXD:GPIO1.C0),3(TXD:.C1),4(CTS:.C2),5(RTS:.C3) */
> -&uart1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart1_xfer &uart1_cts>;
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&uart2m1_xfer>;
> -	status = "okay";
> -};
> -
> -&vopb {
> -	status = "okay";
> -};
> -
> -&vopb_mmu {
> -	status = "okay";
> -};
> -
> -&pinctrl {
> -	btns {
> -		btn_pins: btn-pins {
> -			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>,
> -					<1 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>,
> -					<1 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
> -					<1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>,
> -					<1 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>,
> -					<1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>,
> -					<1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up>,
> -					<1 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up>,
> -					<2 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>,
> -					<2 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>,
> -					<2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>,
> -					<2 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>,
> -					<2 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>,
> -					<2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>,
> -					<2 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
> -					<2 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -	};
> -
> -	headphone {
> -		hp_det: hp-det {
> -			rockchip,pins = <2 RK_PC6 RK_FUNC_GPIO &pcfg_pull_down>;
> -		};
> -	};
> -
> -	leds {
> -		blue_led_pin: blue-led-pin {
> -			rockchip,pins = <0 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -	};
> -
> -	pmic {
> -		dc_det: dc-det {
> -			rockchip,pins = <0 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
> -		};
> -
> -		pmic_int: pmic-int {
> -			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>;
> -		};
> -
> -		soc_slppin_gpio: soc_slppin_gpio {
> -			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_output_low>;
> -		};
> -
> -		soc_slppin_rst: soc_slppin_rst {
> -			rockchip,pins = <0 RK_PA4 2 &pcfg_pull_none>;
> -		};
> -
> -		soc_slppin_slp: soc_slppin_slp {
> -			rockchip,pins = <0 RK_PA4 1 &pcfg_pull_none>;
> -		};
> -	};
>  };
> -- 
> 2.38.0
> 

Thank you.
