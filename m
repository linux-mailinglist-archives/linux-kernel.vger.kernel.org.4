Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3012066BCC0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjAPLVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjAPLUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:20:52 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927E66596;
        Mon, 16 Jan 2023 03:20:49 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30GBKXDr128354;
        Mon, 16 Jan 2023 05:20:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673868033;
        bh=XYBc5v2V7zmEt/3FLQx0K4plTeRThKelmufMJ3aeO1k=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=B7pCnOyCbF3Ad5gAbzAI5QeZ6AbbgaFuKUaMnHXkvd9UnOuchVg5JAoNeYPKUIiEz
         fcxS3hUAftOiZbdR/hU42+UXs/1ALf17r+VkJ0pJl+uhDHF4MV8AaM/CzMEFEyPf4v
         dLPhdfoPTz8RWCXdEDY9ikymMHiAO2WHwqvX6gKM=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30GBKXDa014279
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jan 2023 05:20:33 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 16
 Jan 2023 05:20:33 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 16 Jan 2023 05:20:33 -0600
Received: from [10.24.69.79] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30GBKTfk043996;
        Mon, 16 Jan 2023 05:20:30 -0600
Message-ID: <00d171b6-6b26-7f3e-2c39-cd64c7ca1270@ti.com>
Date:   Mon, 16 Jan 2023 16:50:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 2/2] arm64: dts: ti: Add support for
 phyBOARD-Electra-AM642
To:     Wadim Egorov <w.egorov@phytec.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <upstream@lists.phytec.de>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>
References: <20230104162927.1215033-1-w.egorov@phytec.de>
 <20230104162927.1215033-2-w.egorov@phytec.de>
Content-Language: en-US
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20230104162927.1215033-2-w.egorov@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/01/23 9:59 pm, Wadim Egorov wrote:
> Add basic support for phyCORE-AM64x SoM & phyBOARD-Electra-AM642 CB.
> 
> The phyCORE-AM64x [1] is a SoM (System on Module) featuring TI's AM64x SoC.
> It can be used in combination with different carrier boards.
> This module can come with different sizes and models for
> DDR, eMMC, SPI NOR Flash and various SoCs from the AM64x family.
> 
> A development Kit, called phyBOARD-Electra [2] is used as a carrier board
> reference design around the AM64x SoM.
> 
> Supported features:
>   * Debug UART
>   * Heartbeat LED
>   * GPIO buttons & LEDs
>   * SPI NOR flash
>   * eMMC
>   * CAN
>   * Ethernet
>   * Micro SD card
>   * I2C EEPROM
>   * I2C RTC
>   * I2C LED Dimmer
>   * USB
> 
> For more details, see:
> 
> [1] Product page SoM: https://www.phytec.com/product/phycore-am64x
> [2] Product page CB: https://www.phytec.com/product/phyboard-am64x
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
> v4:
>   - Do not override led pinmux in carrier board dts file, extend it
>   - Do not mark tscadc0 and mcu_gpio0 nodes as reserved
>   - Drop note about SPI TPM chip support from commit message
> 
> v3:
>   - Fix regulator name s/vcc-5v0-som/regulator-vcc-5v0-som
>   - Drop nodes currently without YAML schemes and cause dtbs_check errors:
>     - pmic@61 / ti,lp8733
>     - rtc@52 / trickle-resistor-ohms
>     - leds@62 / nxp,pca9533
>     - main_spi0 + tpm@1 / infineon,slb9670
> v2:
>   - Update commit message
>   - Add links to product pages for SoM & CB
>   - Drop "fixed" from regulator node names
>   - Use generic node names for pmic, tpm, leds & keys
>   - Update compatible of som.dtsi
>   - Remove not needed node labels for pmic, tpm
>   - Remove not needed R5 core mailbox & reserved memory definitions
>     This is use case specific and should not be defined in the som.dtsi
>   - Provide aliases for used devices by SoM & CB
>   - Fixed led definition: Provide proper default-trigger, function & color
>   - Renamed rtc label to i2c_som_rtc
> ---
>  arch/arm64/boot/dts/ti/Makefile               |   1 +
>  .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 231 +++++++++++++++
>  .../dts/ti/k3-am642-phyboard-electra-rdk.dts  | 277 ++++++++++++++++++
>  3 files changed, 509 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index cf7c509538a4..0f8aa8725673 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -21,6 +21,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
>  
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>  
>  dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> new file mode 100644
> index 000000000000..8dfb6301b17d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> @@ -0,0 +1,231 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 PHYTEC America, LLC - https://www.phytec.com
> + * Author: Matt McKee <mmckee@phytec.com>
> + *
> + * Copyright (C) 2022 PHYTEC Messtechnik GmbH
> + * Author: Wadim Egorov <w.egorov@phytec.de>
> + *
> + * Product homepage:
> + * https://www.phytec.com/product/phycore-am64x
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/net/ti-dp83867.h>
> +
> +/ {
> +	model = "PHYTEC phyCORE-AM64x";
> +	compatible = "phytec,am64-phycore-som", "ti,am642";
> +
> +	aliases {
> +		ethernet0 = &cpsw_port1;
> +		mmc0 = &sdhci0;
> +		rtc0 = &i2c_som_rtc;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&leds_pins_default>;
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&main_gpio0 12 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			function = LED_FUNCTION_HEARTBEAT;
> +		};
> +	};
> +
> +	vcc_5v0_som: regulator-vcc-5v0-som {
> +		/* VIN / VCC_5V0_SOM */
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_5V0_SOM";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&main_pmx0 {
> +	cpsw_mdio_pins_default: cpsw-mdio-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x01f8, PIN_INPUT, 4)	/* (P5) PRG0_PRU1_GPO18.MDIO0_MDIO */
> +			AM64X_IOPAD(0x01fc, PIN_OUTPUT, 4)	/* (R2) PRG0_PRU1_GPO19.MDIO0_MDC */
> +			AM64X_IOPAD(0x0100, PIN_OUTPUT, 7)	/* (V7) PRG1_PRU0_GPO18.GPIO0_63 */
> +		>;
> +	};
> +
> +	cpsw_rgmii1_pins_default: cpsw-rgmii1-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0184, PIN_INPUT, 4)	/* (W6) PRG0_PRU0_GPO9.RGMII1_RX_CTL */
> +			AM64X_IOPAD(0x0188, PIN_INPUT, 4)	/* (AA5) PRG0_PRU0_GPO10.RGMII1_RXC */
> +			AM64X_IOPAD(0x00dc, PIN_OUTPUT, 4)	/* (U15) PRG1_PRU0_GPO9.RGMII1_TX_CTL */
> +			AM64X_IOPAD(0x00e0, PIN_OUTPUT, 4)	/* (U14) PRG1_PRU0_GPO10.RGMII1_TXC */
> +			AM64X_IOPAD(0x01cc, PIN_INPUT, 4)	/* (W5) PRG0_PRU1_GPO7.RGMII1_RD0 */
> +			AM64X_IOPAD(0x0124, PIN_OUTPUT, 4)	/* (V15) PRG1_PRU1_GPO7.RGMII1_TD0 */
> +			AM64X_IOPAD(0x01d4, PIN_INPUT, 4)	/* (Y5) PRG0_PRU1_GPO9.RGMII1_RD1 */
> +			AM64X_IOPAD(0x012c, PIN_OUTPUT, 4)	/* (V14) PRG1_PRU1_GPO9.RGMII1_TD1 */
> +			AM64X_IOPAD(0x01d8, PIN_INPUT, 4)	/* (V6) PRG0_PRU1_GPO10.RGMII1_RD2 */
> +			AM64X_IOPAD(0x0130, PIN_OUTPUT, 4)	/* (W14) PRG1_PRU1_GPO10.RGMII1_TD2 */
> +			AM64X_IOPAD(0x01f4, PIN_INPUT, 4)	/* (V5) PRG0_PRU1_GPO17.RGMII1_RD3 */
> +			AM64X_IOPAD(0x014c, PIN_OUTPUT, 4)	/* (AA14) PRG1_PRU1_GPO17.RGMII1_TD3 */
> +			AM64X_IOPAD(0x0154, PIN_INPUT, 7)	/* (V12) PRG1_PRU1_GPO19.GPIO0_84 */
> +		>;
> +	};
> +
> +	eeprom_wp_pins_default: eeprom-wp-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0208, PIN_OUTPUT, 7)	/* (D12) SPI0_CS0.GPIO1_42 */
> +		>;
> +	};
> +
> +	leds_pins_default: leds-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0030, PIN_OUTPUT, 7)	/* (L18) OSPI0_CSn1.GPIO0_12 */
> +		>;
> +	};
> +
> +	main_i2c0_pins_default: main-i2c0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0260, PIN_INPUT, 0)	/* (A18) I2C0_SCL */
> +			AM64X_IOPAD(0x0264, PIN_INPUT, 0)	/* (B18) I2C0_SDA */
> +		>;
> +	};
> +
> +	ospi0_pins_default: ospi0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0000, PIN_OUTPUT, 0)	/* (N20) OSPI0_CLK */
> +			AM64X_IOPAD(0x0008, PIN_INPUT, 0)	/* (N19) OSPI0_DQS */
> +			AM64X_IOPAD(0x000c, PIN_INPUT, 0)	/* (M19) OSPI0_D0 */
> +			AM64X_IOPAD(0x0010, PIN_INPUT, 0)	/* (M18) OSPI0_D1 */
> +			AM64X_IOPAD(0x0014, PIN_INPUT, 0)	/* (M20) OSPI0_D2 */
> +			AM64X_IOPAD(0x0018, PIN_INPUT, 0)	/* (M21) OSPI0_D3 */
> +			AM64X_IOPAD(0x001c, PIN_INPUT, 0)	/* (P21) OSPI0_D4 */
> +			AM64X_IOPAD(0x0020, PIN_INPUT, 0)	/* (P20) OSPI0_D5 */
> +			AM64X_IOPAD(0x0024, PIN_INPUT, 0)	/* (N18) OSPI0_D6 */
> +			AM64X_IOPAD(0x0028, PIN_INPUT, 0)	/* (M17) OSPI0_D7 */
> +			AM64X_IOPAD(0x002c, PIN_OUTPUT, 0)	/* (L19) OSPI0_CSn0 */
> +		>;
> +	};
> +};
> +
> +&cpsw3g {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cpsw_rgmii1_pins_default>;
> +};
> +
> +&cpsw3g_mdio {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&cpsw_mdio_pins_default>;
> +
> +	cpsw3g_phy1: ethernet-phy@1 {
> +		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
> +		reg = <1>;
> +		interrupt-parent = <&main_gpio0>;
> +		interrupts = <84 IRQ_TYPE_EDGE_FALLING>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		reset-gpios = <&main_gpio0 63 GPIO_ACTIVE_LOW>;
> +		reset-assert-us = <1000>;
> +		reset-deassert-us = <1000>;
> +	};
> +};
> +
> +&cpsw_port1 {
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&cpsw3g_phy1>;
> +};
> +
> +&cpsw_port2 {
> +	status = "disabled";
> +};
> +
> +&mailbox0_cluster2 {
> +	status = "disabled";
> +};
> +
> +&mailbox0_cluster3 {
> +	status = "disabled";
> +};
> +
> +&mailbox0_cluster4 {
> +	status = "disabled";
> +};
> +
> +&mailbox0_cluster5 {
> +	status = "disabled";
> +};
> +
> +&mailbox0_cluster6 {
> +	status = "disabled";
> +};
> +
> +&mailbox0_cluster7 {
> +	status = "disabled";
> +};
> +
> +&main_i2c0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c0_pins_default>;
> +	clock-frequency = <400000>;
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c32";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&eeprom_wp_pins_default>;
> +		pagesize = <32>;
> +		reg = <0x50>;
> +	};
> +
> +	i2c_som_rtc: rtc@52 {
> +		compatible = "microcrystal,rv3028";
> +		reg = <0x52>;
> +	};
> +};
> +
> +&ospi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ospi0_pins_default>;
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0x0>;
> +		spi-tx-bus-width = <8>;
> +		spi-rx-bus-width = <8>;
> +		spi-max-frequency = <25000000>;
> +		cdns,tshsl-ns = <60>;
> +		cdns,tsd2d-ns = <60>;
> +		cdns,tchsh-ns = <60>;
> +		cdns,tslch-ns = <60>;
> +		cdns,read-delay = <0>;
> +	};
> +};
> +
> +&sdhci0 {
> +	bus-width = <8>;
> +	non-removable;
> +	ti,driver-strength-ohm = <50>;
> +	disable-wp;
> +	keep-power-in-suspend;
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> new file mode 100644
> index 000000000000..8d3114d14a8b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> @@ -0,0 +1,277 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 PHYTEC America, LLC - https://www.phytec.com
> + * Author: Matt McKee <mmckee@phytec.com>
> + *
> + * Copyright (C) 2022 PHYTEC Messtechnik GmbH
> + * Author: Wadim Egorov <w.egorov@phytec.de>
> + *
> + * Product homepage:
> + * https://www.phytec.com/product/phyboard-am64x
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/mux/ti-serdes.h>
> +#include <dt-bindings/phy/phy.h>
> +#include "k3-am642.dtsi"
> +#include "k3-am64-phycore-som.dtsi"
> +
> +/ {
> +	compatible = "phytec,am642-phyboard-electra-rdk",
> +		     "phytec,am64-phycore-som", "ti,am642";
> +	model = "PHYTEC phyBOARD-Electra-AM64x RDK";
> +
> +	aliases {
> +		mmc1 = &sdhci1;
> +		serial2 = &main_uart0;
> +		serial3 = &main_uart1;
> +	};
> +
> +	chosen {
> +		stdout-path = &main_uart0;
> +	};
> +
> +	can_tc1: can-phy0 {
> +		compatible = "ti,tcan1042";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&can_tc1_pins_default>;
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		standby-gpios = <&main_gpio0 32 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	can_tc2: can-phy1 {
> +		compatible = "ti,tcan1042";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&can_tc2_pins_default>;
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		standby-gpios = <&main_gpio0 35 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	keys {
> +		compatible = "gpio-keys";
> +		autorepeat;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_keys_pins_default>;
> +
> +		key-home {
> +			label = "home";
> +			linux,code = <KEY_HOME>;
> +			gpios = <&main_gpio0 17 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		key-menu {
> +			label = "menu";
> +			linux,code = <KEY_MENU>;
> +			gpios = <&main_gpio0 21 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&leds_pins_default &user_leds_pins_default>;
> +
> +		led-1 {
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&main_gpio0 15 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "mmc0";
> +			function = LED_FUNCTION_DISK;
> +		};
> +
> +		led-2 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&main_gpio0 16 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "mmc1";
> +			function = LED_FUNCTION_DISK;
> +		};
> +	};
> +
> +	vcc_3v3_mmc: regulator-sd {
> +		/* TPS22963C */
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_3V3_MMC";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +};
> +
> +&main_pmx0 {
> +	can_tc1_pins_default: can-tc1-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0084, PIN_OUTPUT, 7)	/* (P16) GPMC0_ADVn_ALE.GPIO0_32 */
> +		>;
> +	};
> +
> +	can_tc2_pins_default: can-tc2-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0090, PIN_OUTPUT, 7)	/* (P17) GPMC0_BE0n_CLE.GPIO0_35 */
> +		>;
> +	};
> +
> +	gpio_keys_pins_default: gpio-keys-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0044, PIN_INPUT, 7)	/* (T18) GPMC0_AD2.GPIO0_17 */
> +			AM64X_IOPAD(0x0054, PIN_INPUT, 7)	/* (V20) GPMC0_AD6.GPIO0_21 */
> +		>;
> +	};
> +
> +	main_i2c1_pins_default: main-i2c1-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0268, PIN_INPUT, 0)	/* (C18) I2C1_SCL */
> +			AM64X_IOPAD(0x026c, PIN_INPUT, 0)	/* (B19) I2C1_SDA */
> +		>;
> +	};
> +
> +	main_mcan0_pins_default: main-mcan0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0250, PIN_OUTPUT, 0)	/* (A17) MCAN0_TX */
> +			AM64X_IOPAD(0x0254, PIN_INPUT, 0)	/* (B17) MCAN0_RX */
> +		>;
> +	};
> +
> +	main_mcan1_pins_default: main-mcan1-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0258, PIN_OUTPUT, 0)	/* (C17) MCAN1_TX */
> +			AM64X_IOPAD(0x025c, PIN_INPUT, 0)	/* (D17) MCAN1_RX */
> +		>;
> +	};
> +
> +	main_mmc1_pins_default: main-mmc1-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x027c, PIN_INPUT_PULLUP, 0)	/* (K18) MMC1_DAT3 */
> +			AM64X_IOPAD(0x0280, PIN_INPUT_PULLUP, 0)	/* (K19) MMC1_DAT2 */
> +			AM64X_IOPAD(0x0284, PIN_INPUT_PULLUP, 0)	/* (L21) MMC1_DAT1 */
> +			AM64X_IOPAD(0x0288, PIN_INPUT_PULLUP, 0)	/* (K21) MMC1_DAT0 */
> +			AM64X_IOPAD(0x028c, PIN_INPUT_PULLDOWN, 0)	/* (L20) MMC1_CLK */
> +			AM64X_IOPAD(0x0290, PIN_INPUT, 0)		/* MMC1_CLKLB */
> +			AM64X_IOPAD(0x0294, PIN_INPUT_PULLUP, 0)	/* (J19) MMC1_CMD */
> +			AM64X_IOPAD(0x0298, PIN_INPUT_PULLUP, 0)	/* (D19) MMC1_SDCD */
> +		>;
> +	};
> +
> +	main_uart0_pins_default: main-uart0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0230, PIN_INPUT, 0)	/* (D15) UART0_RXD */
> +			AM64X_IOPAD(0x0234, PIN_OUTPUT, 0)	/* (C16) UART0_TXD */
> +		>;
> +	};
> +
> +	main_uart1_pins_default: main-uart1-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0248, PIN_INPUT, 0)	/* (D16) UART1_CTSn */
> +			AM64X_IOPAD(0x024C, PIN_OUTPUT, 0)	/* (E16) UART1_RTSn */
> +			AM64X_IOPAD(0x0240, PIN_INPUT, 0)	/* (E15) UART1_RXD */
> +			AM64X_IOPAD(0x0244, PIN_OUTPUT, 0)	/* (E14) UART1_TXD */
> +		>;
> +	};
> +
> +	main_usb0_pins_default: main-usb0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0)	/* (E19) USB0_DRVVBUS */
> +		>;
> +	};
> +
> +	pcie_usb_sel_pins_default: pcie-usb-sel-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x017c, PIN_OUTPUT, 7)	/* (T1) PRG0_PRU0_GPO7.GPIO1_7 */
> +		>;
> +	};
> +
> +	pcie0_pins_default: pcie0-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x0098, PIN_OUTPUT, 7)	/* (W19) GPMC0_WAIT0.GPIO0_37 */
> +		>;
> +	};
> +
> +	user_leds_pins_default: user-leds-pins-default {
> +		pinctrl-single,pins = <
> +			AM64X_IOPAD(0x003c, PIN_OUTPUT, 7)	/* (T20) GPMC0_AD0.GPIO0_15 */
> +			AM64X_IOPAD(0x0040, PIN_OUTPUT, 7)	/* (U21) GPMC0_AD1.GPIO0_16 */
> +		>;
> +	};
> +};
> +
> +&main_i2c1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c1_pins_default>;
> +	clock-frequency = <400000>;
> +
> +	eeprom@51 {
> +		compatible = "atmel,24c02";
> +		pagesize = <16>;
> +		reg = <0x51>;
> +	};
> +};
> +
> +&main_mcan0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan0_pins_default>;
> +	phys = <&can_tc1>;
> +};
> +
> +&main_mcan1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan1_pins_default>;
> +	phys = <&can_tc2>;
> +};
> +
> +&main_uart0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart0_pins_default>;
> +};
> +
> +&main_uart1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart1_pins_default>;
> +	uart-has-rtscts;
> +};
> +
> +&sdhci1 {
> +	vmmc-supply = <&vcc_3v3_mmc>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mmc1_pins_default>;
> +	bus-width = <4>;
> +	ti,driver-strength-ohm = <50>;
> +	disable-wp;
> +	no-1-8-v;
> +};
> +
> +&serdes0 {
> +	serdes0_pcie_usb_link: phy@0 {
> +		reg = <0>;
> +		cdns,num-lanes = <1>;
> +		#phy-cells = <0>;
> +		cdns,phy-type = <PHY_TYPE_USB3>;
> +		resets = <&serdes_wiz0 1>;
> +	};
> +};
> +
> +&serdes_ln_ctrl {
> +	idle-states = <AM64_SERDES0_LANE0_USB>;
> +};
> +
> +&usbss0 {
> +	ti,vbus-divider;
> +};
> +
> +&usb0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_usb0_pins_default>;
> +	dr_mode = "host";
> +	maximum-speed = "super-speed";
> +	phys = <&serdes0_pcie_usb_link>;
> +	phy-names = "cdns3,usb3-phy";
> +};

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

-- 
Regards,
Ravi
