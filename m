Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A826DAFC3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjDGPgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjDGPgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:36:41 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E278A42;
        Fri,  7 Apr 2023 08:36:38 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 49B5F20008;
        Fri,  7 Apr 2023 15:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680881797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7TO1o1XlUg2BXfTUmW9WNxU9d1f3fNyfprXOmJs4kVc=;
        b=bDxPJy+naNWbVTbD55E/lPgZ+9/EXinypMBzu2NsrZCQZZsIEPi9kYW42SdsqNdCZKFOTy
        HdAT+XTdSUfWWtSWuz/fd0y3Jj+vQVhyHuSGJYX+WYBfm713bO4SsdNjsM4n9vK2Ph6nvE
        kl/PJqOU82xwoqEn6ocZVGprh3jEZT/jQrIPFLXwaF4NZ9YjS8QMDJR2jXCXklWMKxknqg
        EWAJBGFB9jBRk10VZ4LtK4/ZSRuQFqLlxOJLgj/bO5jt/9AuaxDXHRusJQ1LgMg1a1hir4
        IsQn7BUPc0VwKi5o3sSMVBSMMdKxT0X2DWw/31NT4eOjkjF8jW42iEVGCBTiIw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Tony Dinh <mibodhi@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Tony Dinh <mibodhi@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-kernel@vger.kernel.org, soc@kernel.org
Subject: Re: [PATCH] ARM: dts: mvebu: Add support for Thecus N2350 board
In-Reply-To: <20230216011046.3306-1-mibodhi@gmail.com>
References: <20230216011046.3306-1-mibodhi@gmail.com>
Date:   Fri, 07 Apr 2023 17:36:32 +0200
Message-ID: <87h6tr3drz.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tony Dinh,

> Thecus N2350 is a NAS based on Marvell Armada 385 SoC.
>
> Board Specification:
>
> - Marvel MV88F6820 Dual Core at 1GHz
> - 1 GiB DDR4 RAM
> - 4MB Macronix mx25l3205d SPI flash
> - 512MB Hynix H27U4G8F2DTR-BC NAND flash
> - I2C
> - 2x USB 3.0
> - 1x GBE LAN port (PHY: Marvell 88E1510)
> - 2x SATA (hot swap slots)
> - 3x buttons
> - 10x LEDS
> - serial console
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

There were some comments on these series. If you already sent a second
version I missed it, in this case could you send it again to me ?

Else do you plan to send a v2 soon ?

Thanks,

Gregory


> ---
>
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/armada-385-thecus-n2350.dts | 432 ++++++++++++++++++
>  2 files changed, 433 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-385-thecus-n2350.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d08a3c450..749790e6e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1528,6 +1528,7 @@ dtb-$(CONFIG_MACH_ARMADA_38X) += \
>  	armada-385-linksys-rango.dtb \
>  	armada-385-linksys-shelby.dtb \
>  	armada-385-synology-ds116.dtb \
> +	armada-385-thecus-n2350.dtb \
>  	armada-385-turris-omnia.dtb \
>  	armada-388-clearfog.dtb \
>  	armada-388-clearfog-base.dtb \
> diff --git a/arch/arm/boot/dts/armada-385-thecus-n2350.dts b/arch/arm/boot/dts/armada-385-thecus-n2350.dts
> new file mode 100644
> index 000000000..38114d842
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-385-thecus-n2350.dts
> @@ -0,0 +1,432 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Device Tree file for Thecus N2350 board
> + *
> + * Copyright (C) 2018-2023 Tony Dinh <mibodhi@gmail.com>
> + * Copyright (C) 2018 Manuel Jung <manuel.jung@hotmail.com>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "armada-385.dtsi"
> +
> +/ {
> +	model = "Thecus N2350";
> +	compatible = "thecus,n2350", "marvell,armada385";
> +
> +	aliases {
> +		ethernet0 = &eth0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x40000000>; /* 1GB */
> +	};
> +
> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
> +			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
> +			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
> +			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000
> +			  MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
> +
> +	};
> +
> +	usb3_0_phy: usb3_0_phy {
> +		compatible = "usb-nop-xceiv";
> +		vcc-supply = <&usb3_0_power>;
> +	};
> +
> +	usb3_1_phy: usb3_1_phy {
> +		compatible = "usb-nop-xceiv";
> +		vcc-supply = <&usb3_1_power>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pmx_power_button &pmx_copy_button &pmx_reset_button>;
> +		pinctrl-names = "default";
> +
> +		button@1 {
> +			label = "Power Button";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		button@2 {
> +			label = "Copy Button";
> +			linux,code = <KEY_COPY>;
> +			gpios = <&gpio1 20 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		button@3 {
> +			label = "Reset Button";
> +			linux,code = <KEY_RESTART>;
> +			gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&pmx_sata1_white_led
> +				&pmx_sata1_red_led
> +				&pmx_sata2_white_led
> +				&pmx_sata2_red_led
> +				&pmx_sys_white_led
> +				&pmx_sys_red_led
> +				&pmx_pwr_blue_led
> +				&pmx_pwr_red_led
> +				&pmx_usb_white_led
> +				&pmx_usb_red_led>;
> +
> +		pinctrl-names = "default";
> +
> +		white_sata1 {
> +			label = "n2350:white:sata1";
> +			gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		red_sata1 {
> +			label = "n2350:red:sata1";
> +			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		white-sata2 {
> +			label = "n2350:white:sata2";
> +			gpios = <&gpio0 19 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		red-sata2 {
> +			label = "n2350:red:sata2";
> +			gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		white-sys {
> +			label = "n2350:white:sys";
> +			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "default-on";
> +		};
> +
> +		red-sys {
> +			label = "n2350:red:sys";
> +			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		blue-pwr {
> +			label = "n2350:blue:pwr";
> +			gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		red-pwr {
> +			label = "n2350:red:pwr";
> +			gpios = <&gpio0 18 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		white-usb {
> +			label = "n2350:white:usb";
> +			gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		red-usb {
> +			label = "n2350:red:usb";
> +			gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	usb3_0_power: regulator@1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "USB3_0_Power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	usb3_1_power: regulator@2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "USB3_1_Power";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio0 24 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	reg_sata0: regulator@3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pwr_en_sata0";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	reg_5v_sata0: v5-sata0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "v5.0-sata0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&reg_sata0>;
> +	};
> +
> +	reg_12v_sata0: v12-sata0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "v12.0-sata0";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		vin-supply = <&reg_sata0>;
> +	};
> +
> +	reg_sata1: regulator@4 {
> +		regulator-name = "pwr_en_sata1";
> +		compatible = "regulator-fixed";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		gpio = <&gpio1 13 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	reg_5v_sata1: v5-sata1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "v5.0-sata1";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&reg_sata1>;
> +	};
> +
> +	reg_12v_sata1: v12-sata1 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "v12.0-sata1";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		vin-supply = <&reg_sata1>;
> +	};
> +
> +	gpio-poweroff {
> +		compatible = "gpio-poweroff";
> +		pinctrl-0 = <&pmx_pwr_off>;
> +		pinctrl-names = "default";
> +		gpios = <&gpio1 22 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +};
> +
> +&ahci0 {
> +	status = "okay";
> +};
> +
> +&bm {
> +	status = "okay";
> +};
> +
> +&bm_bppi {
> +	status = "okay";
> +};
> +
> +&eth0 {
> +	status = "okay";
> +	phy = <&phy0>;
> +	phy-mode = "sgmii";
> +	buffer-manager = <&bm>;
> +	bm,pool-long = <0>;
> +	bm,pool-short = <1>;
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +};
> +
> +&mdio {
> +	phy0: ethernet-phy@0 {
> +		reg = <1>;
> +	};
> +};
> +
> +&nand_controller {
> +	status = "okay";
> +
> +	nand@0 {
> +		status = "okay";
> +		reg = <0>;
> +		label = "pxa3xx_nand-0";
> +		nand-rb = <0>;
> +		marvell,nand-keep-config;
> +		nand-on-flash-bbt;
> +		nand-ecc-strength = <4>;
> +		nand-ecc-step-size = <512>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				label = "rootfs";
> +				reg = <0x00000000 0x20000000>;
> +			};
> +
> +		};
> +	};
> +};
> +
> +&pciec {
> +	status = "okay";
> +	pcie@1,0 {
> +		/* Port 0, Lane 0 */
> +		status = "okay";
> +	};
> +	pcie@2,0 {
> +		/* Port 1, Lane 0 */
> +		status = "okay";
> +	};
> +};
> +
> +&pinctrl {
> +	pinctrl-names = "default";
> +
> +	pmx_power_button: pmx-power-button {
> +		marvell,pins = "mpp49";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_copy_button: pmx-copy-button {
> +		marvell,pins = "mpp52";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_reset_button: pmx-reset-button {
> +		marvell,pins = "mpp50";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_sata1_white_led: pmx-sata1-white-led {
> +		marvell,pins = "mpp20";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_sata1_red_led: pmx-sata1-red-led {
> +		marvell,pins = "mpp46";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_sata2_white_led: pmx-sata2-white-led {
> +		marvell,pins = "mpp19";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_sata2_red_led: pmx-sata2-red-led {
> +		marvell,pins = "mpp47";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_sys_white_led: pmx-sys-white-led {
> +		marvell,pins = "mpp14";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_sys_red_led: pmx-sys-red-led {
> +		marvell,pins = "mpp15";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_buzzer: pmx-buzzer {
> +		marvell,pins = "mpp51";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_pwr_off: pmx-pwr-off {
> +		marvell,pins = "mpp54";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_pwr_blue_led: pmx-pwr-blue-led {
> +		marvell,pins = "mpp43";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_pwr_red_led: pmx-pwr-red-led {
> +		marvell,pins = "mpp18";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_usb_white_led: pmx-usb-white-led {
> +		marvell,pins = "mpp16";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_usb_red_led: pmx-usb-red-led {
> +		marvell,pins = "mpp17";
> +		marvell,function = "gpio";
> +	};
> +};
> +
> +&sdhci {
> +	broken-cd;
> +	wp-inverted;
> +	bus-width = <8>;
> +	status = "okay";
> +	no-1-8-v;
> +};
> +
> +&spi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi1_pins>;
> +	status = "okay";
> +
> +	/* spi: 4M Flash Macronix MX25L3205D */
> +	spi-flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "macronix,mx25l3205d", "jedec,spi-nor";
> +		reg = <0>;
> +
> +		spi-max-frequency = <108000000>;
> +		spi-cpha;
> +
> +		partition@0 {
> +			label = "u-boot";
> +			reg = <0x00000000 0x00100000>;
> +		};
> +
> +		partition@100000 {
> +			label = "u-boot-env";
> +			reg = <0x00100000 0x00010000>;
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb3_0 {
> +	status = "okay";
> +};
> +
> +&usb3_1 {
> +	status = "okay";
> +};
> -- 
> 2.30.2
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
