Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E76966C1DA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjAPOP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjAPONa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:13:30 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488AF23854;
        Mon, 16 Jan 2023 06:05:08 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30GE4mGl028066;
        Mon, 16 Jan 2023 08:04:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673877888;
        bh=q9pIGMSKgokBRO/4ARjEGDANqYAzBOg28n00jmkhT84=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=xEOY1TEZabBhv2RXb0gApdF2lsNjEJarqR7Qb6Vig83+1+udLy7X0VUI7t+ehQXzJ
         20qc0JQZnVKXPlnS6Dg4uF7HpoUHdBrhtcIMVdNOIbj6etmyax0jG9X5laYqx5Pipk
         olO/0KDp7/Q9eBPUQvKNFykXvlQPlXLDgO3NyXpg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30GE4m4T097989
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jan 2023 08:04:48 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 16
 Jan 2023 08:04:48 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 16 Jan 2023 08:04:48 -0600
Received: from [10.24.69.141] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30GE4iZ5059429;
        Mon, 16 Jan 2023 08:04:45 -0600
Message-ID: <b4f7ef7f-a1b5-db23-ccca-76d041dd7dda@ti.com>
Date:   Mon, 16 Jan 2023 19:34:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V5 3/3] arm64: dts: ti: k3-am68-sk: Add support for AM68
 SK base board
Content-Language: en-US
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>
References: <20230116071446.28867-1-sinthu.raja@ti.com>
 <20230116071446.28867-4-sinthu.raja@ti.com>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20230116071446.28867-4-sinthu.raja@ti.com>
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



On 16/01/23 12:44, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> The SK architecture comprises of baseboard and a SOM board. The
> AM68 Starter Kit's baseboard contains most of the actual connectors,
> power supply etc. The System on Module (SoM) is plugged on to the base
> board. Therefore, add support for peripherals brought out in the base
> board.
> 
> Schematics: https://www.ti.com/lit/zip/SPRR463
> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---
> 
> No changes in V4 & V5
> 
> Changes in V3:
> =============
> *Address review comments:
>  - Remove the unused nodes that are disabled by default.
>  - Update the gpio regulator node: gpio-regulator-tlv to "regulator-tlv".
> 
> Changes in V2:
> =============
> *Address the review comments:
>  - Update the commit description.
>  - Update the regulator nodes: fixedregulator to "regulator-"
>  - Update the commit $subject to align with rest of the commits.
>  - Drop the blank lines
>  - Change the node names that are added with underscore("_") with "-"
> 
> V1: https://lore.kernel.org/linux-arm-kernel/20221018123849.23695-4-sinthu.raja@ti.com/
> V2: https://lore.kernel.org/lkml/20221107123852.8063-4-sinthu.raja@ti.com/
> V3: https://lore.kernel.org/lkml/20230110110052.14851-4-sinthu.raja@ti.com/
> V4: https://lore.kernel.org/lkml/20230105151740.29436-4-sinthu.raja@ti.com/
> 
>  arch/arm64/boot/dts/ti/Makefile               |   2 +
>  .../boot/dts/ti/k3-am68-sk-base-board.dts     | 335 ++++++++++++++++++
>  2 files changed, 337 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index cf7c509538a4..1b4e8b573de5 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -12,6 +12,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
>  
> +dtb-$(CONFIG_ARCH_K3) += k3-am68-sk-base-board.dtb
> +
>  dtb-$(CONFIG_ARCH_K3) += k3-j721e-beagleboneai64.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-j721e-common-proc-board.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> new file mode 100644
> index 000000000000..2091cd2431fb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> @@ -0,0 +1,335 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + * Base Board: https://www.ti.com/lit/zip/SPRR463
> + */
> +
> +/dts-v1/;
> +
> +#include "k3-am68-sk-som.dtsi"
> +#include <dt-bindings/net/ti-dp83867.h>
> +#include <dt-bindings/phy/phy-cadence.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/mux/ti-serdes.h>
> +
> +/ {
> +	compatible = "ti,am68-sk", "ti,j721s2";
> +	model = "Texas Instruments AM68 SK";
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	aliases {
> +		serial2 = &main_uart8;
> +		mmc1 = &main_sdhci1;
> +		can0 = &mcu_mcan0;
> +		can1 = &mcu_mcan1;
> +		can2 = &main_mcan6;
> +		can3 = &main_mcan7;
> +	};
> +
> +	vusb_main: regulator-vusb-main5v0 {
> +		/* USB MAIN INPUT 5V DC */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vusb-main5v0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vsys_3v3: regulator-vsys3v3 {
> +		/* Output of LM5141 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vusb_main>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vdd_mmc1: regulator-sd {
> +		/* Output of TPS22918 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_mmc1";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		vin-supply = <&vsys_3v3>;
> +		gpio = <&exp1 10 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	vdd_sd_dv: regulator-tlv71033 {
> +		/* Output of TLV71033 */
> +		compatible = "regulator-gpio";
> +		regulator-name = "tlv71033";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_sd_dv_pins_default>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		vin-supply = <&vsys_3v3>;
> +		gpios = <&main_gpio0 49 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 0x0>,
> +			 <3300000 0x1>;
> +	};
> +
> +	vsys_io_1v8: regulator-vsys-io-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_io_1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vsys_io_1v2: regulator-vsys-io-1v2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vsys_io_1v2";
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	transceiver1: can-phy0 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +	};
> +
> +	transceiver2: can-phy1 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +	};
> +
> +	transceiver3: can-phy2 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +	};
> +
> +	transceiver4: can-phy3 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +	};
> +};
> +
> +&main_pmx0 {
> +	main_uart8_pins_default: main-uart8-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x0d0, PIN_INPUT, 11) /* (AF26) SPI0_CS1.UART8_RXD */
> +			J721S2_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AH27) SPI0_CLK.UART8_TXD */
> +		>;
> +	};
> +
> +	main_i2c0_pins_default: main-i2c0-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x0e0, PIN_INPUT, 0) /* (AH25) I2C0_SCL */
> +			J721S2_IOPAD(0x0e4, PIN_INPUT, 0) /* (AE24) I2C0_SDA */
> +		>;
> +	};
> +
> +	main_mmc1_pins_default: main-mmc1-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x104, PIN_INPUT, 0) /* (P23) MMC1_CLK */
> +			J721S2_IOPAD(0x108, PIN_INPUT, 0) /* (N24) MMC1_CMD */
> +			J721S2_IOPAD(0x0fc, PIN_INPUT, 0) /* (M23) MMC1_DAT0 */
> +			J721S2_IOPAD(0x0f8, PIN_INPUT, 0) /* (P24) MMC1_DAT1 */
> +			J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */
> +			J721S2_IOPAD(0x0f0, PIN_INPUT, 0) /* (R22) MMC1_DAT3 */
> +			J721S2_IOPAD(0x0e8, PIN_INPUT, 8) /* (AE25) TIMER_IO0.MMC1_SDCD */
> +		>;
> +	};
> +
> +	vdd_sd_dv_pins_default: vdd-sd-dv-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x0c4, PIN_INPUT, 7) /* (AB26) ECAP0_IN_APWM_OUT.GPIO0_49 */
> +		>;
> +	};
> +
> +	main_usbss0_pins_default: main-usbss0-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x0ec, PIN_OUTPUT, 6) /* (AG25) TIMER_IO1.USB0_DRVVBUS */
> +		>;
> +	};
> +
> +	main_mcan6_pins_default: main-mcan6-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x098, PIN_INPUT, 0) /* (V25) MCASP0_AXR10.MCAN6_RX */
> +			J721S2_IOPAD(0x094, PIN_INPUT, 0) /* (AA25) MCASP0_AXR9.MCAN6_TX */
> +		>;
> +	};
> +
> +	main_mcan7_pins_default: main-mcan7-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_IOPAD(0x0a0, PIN_INPUT, 0) /* (AB25) MCASP0_AXR12.MCAN7_RX */
> +			J721S2_IOPAD(0x09c, PIN_INPUT, 0) /* (T24) MCASP0_AXR11.MCAN7_TX */
> +		>;
> +	};
> +};
> +
> +&wkup_pmx0 {
> +	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_WKUP_IOPAD(0x094, PIN_INPUT, 0) /* (B22) MCU_RGMII1_RD0 */
> +			J721S2_WKUP_IOPAD(0x090, PIN_INPUT, 0) /* (B21) MCU_RGMII1_RD1 */
> +			J721S2_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C22) MCU_RGMII1_RD2 */
> +			J721S2_WKUP_IOPAD(0x088, PIN_INPUT, 0) /* (D23) MCU_RGMII1_RD3 */
> +			J721S2_WKUP_IOPAD(0x084, PIN_INPUT, 0) /* (D22) MCU_RGMII1_RXC */
> +			J721S2_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (E23) MCU_RGMII1_RX_CTL */
> +			J721S2_WKUP_IOPAD(0x07c, PIN_OUTPUT, 0) /* (F23) MCU_RGMII1_TD0 */
> +			J721S2_WKUP_IOPAD(0x078, PIN_OUTPUT, 0) /* (G22) MCU_RGMII1_TD1 */
> +			J721S2_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (E21) MCU_RGMII1_TD2 */
> +			J721S2_WKUP_IOPAD(0x070, PIN_OUTPUT, 0) /* (E22) MCU_RGMII1_TD3 */
> +			J721S2_WKUP_IOPAD(0x080, PIN_OUTPUT, 0) /* (F21) MCU_RGMII1_TXC */
> +			J721S2_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (F22) MCU_RGMII1_TX_CTL */
> +		>;
> +	};
> +
> +	mcu_mdio_pins_default: mcu-mdio-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_WKUP_IOPAD(0x09c, PIN_OUTPUT, 0) /* (A21) MCU_MDIO0_MDC */
> +			J721S2_WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (A22) MCU_MDIO0_MDIO */
> +		>;
> +	};
> +
> +	mcu_mcan0_pins_default: mcu-mcan0-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_WKUP_IOPAD(0x0bc, PIN_INPUT, 0) /* (E28) MCU_MCAN0_RX */
> +			J721S2_WKUP_IOPAD(0x0b8, PIN_OUTPUT, 0) /* (E27) MCU_MCAN0_TX */
> +		>;
> +	};
> +
> +	mcu_mcan1_pins_default: mcu-mcan1-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_WKUP_IOPAD(0x0d4, PIN_INPUT, 0) /* (F26) WKUP_GPIO0_5.MCU_MCAN1_RX */
> +			J721S2_WKUP_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (C23) WKUP_GPIO0_4.MCU_MCAN1_TX*/
> +		>;
> +	};
> +
> +	mcu_i2c1_pins_default: mcu-i2c1-pins-default {
> +		pinctrl-single,pins = <
> +			J721S2_WKUP_IOPAD(0x0e0, PIN_INPUT, 0) /* (F24) WKUP_GPIO0_8.MCU_I2C1_SCL */
> +			J721S2_WKUP_IOPAD(0x0e4, PIN_INPUT, 0) /* (H26) WKUP_GPIO0_9.MCU_I2C1_SDA */
> +		>;
> +	};
> +};
> +
> +&main_gpio2 {
> +	status = "disabled";
> +};
> +
> +&main_gpio4 {
> +	status = "disabled";
> +};
> +
> +&main_gpio6 {
> +	status = "disabled";
> +};
> +
> +&wkup_gpio0 {
> +	status = "disabled";
> +};
> +
> +&wkup_gpio1 {
> +	status = "disabled";
> +};
> +
> +&wkup_uart0 {
> +	status = "reserved";
> +};
> +
> +&main_uart8 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart8_pins_default>;
> +	/* Shared with TFA on this platform */
> +	power-domains = <&k3_pds 357 TI_SCI_PD_SHARED>;
> +};
> +
> +&main_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c0_pins_default>;
> +	clock-frequency = <400000>;
> +
> +	exp1: gpio@21 {
> +		compatible = "ti,tca6416";
> +		reg = <0x21>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-line-names = "CSI_VIO_SEL", "CSI_SEL_FPC_EXPn", "HDMI_PDn",
> +					"HDMI_LS_OE", "DP0_3V3 _EN", "BOARDID_EEPROM_WP",
> +					"CAN_STB", " ", "GPIO_uSD_PWR_EN", "eDP_ENABLE",
> +					"IO_EXP_PCIe1_M.2_RTSz", "IO_EXP_MCU_RGMII_RSTz",
> +					"IO_EXP_CSI2_EXP_RSTz", " ", "CSI0_B_GPIO1",
> +					"CSI1_B_GPIO1";
> +	};
> +};
> +
> +&main_sdhci0 {
> +	/* Unused */
> +	status = "disabled";
> +};
> +
> +&main_sdhci1 {
> +	/* SD card */
> +	pinctrl-0 = <&main_mmc1_pins_default>;
> +	pinctrl-names = "default";
> +	disable-wp;
> +	vmmc-supply = <&vdd_mmc1>;
> +	vqmmc-supply = <&vdd_sd_dv>;
> +};
> +
> +&mcu_cpsw {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
> +};
> +
> +&davinci_mdio {
> +	phy0: ethernet-phy@0 {
> +		reg = <0>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +		ti,min-output-impedance;
> +	};
> +};
> +
> +&cpsw_port1 {
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&phy0>;
> +};
> +
> +&mcu_mcan0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_mcan0_pins_default>;
> +	phys = <&transceiver1>;
> +};
> +
> +&mcu_mcan1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_mcan1_pins_default>;
> +	phys = <&transceiver2>;
> +};
> +
> +&main_mcan6 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan6_pins_default>;
> +	phys = <&transceiver3>;
> +};
> +
> +&main_mcan7 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan7_pins_default>;
> +	phys = <&transceiver4>;

Tested-by: Vaishnav Achath <vaishnav.a@ti.com>

> +};

-- 
Regards,
Vaishnav
