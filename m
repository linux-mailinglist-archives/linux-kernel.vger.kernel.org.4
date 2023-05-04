Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C4B6F6DB0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjEDO14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjEDO1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:27:53 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BB58A72;
        Thu,  4 May 2023 07:27:50 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 344EQhmh084503;
        Thu, 4 May 2023 09:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683210403;
        bh=VA2eSNzYn7l2JEsK5RLzQ5LbnxB1J6OjPKUPch1iflY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=VYobPQTIhyMgjN6Py5lJsGXxKpP0InIkdMatJpwFb5VyLzR0VE+wcpr+lfx4lljha
         /dvrZeYQnlLyMG9ViDFuWJPhz5DYX7h8hxH5sX+lUuxI0KzzG18HGrfn7K9PwCyYTl
         aeiZwg4jvEXH/KR68pgIL/lOw/xp3WyKK/if5DRs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 344EQh3a027527
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 May 2023 09:26:43 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 May 2023 09:26:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 May 2023 09:26:43 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 344EQhRP111258;
        Thu, 4 May 2023 09:26:43 -0500
Date:   Thu, 4 May 2023 09:26:43 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Wadim Egorov <w.egorov@phytec.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-hardening@vger.kernel.org>, <upstream@lists.phytec.de>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>
Subject: Re: [PATCH 2/2] arm64: dts: ti: Add basic support for
 phyBOARD-Lyra-AM625
Message-ID: <20230504142643.pkzsftrsrqph4vql@banked>
References: <20230504140143.1425951-1-w.egorov@phytec.de>
 <20230504140143.1425951-2-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230504140143.1425951-2-w.egorov@phytec.de>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:01-20230504, Wadim Egorov wrote:
> The phyCORE-AM62x [1] is a SoM (System on Module) featuring TI's AM62x SoC.
> It can be used in combination with different carrier boards.
> This module can come with different sizes and models for
> DDR, eMMC, SPI NOR Flash and various SoCs from the AM62x family.
> 
> A development Kit, called phyBOARD-Lyra [2] is used as a carrier board
> reference design around the AM62x SoM.
> 
> Supported features:
>   * Debug UART
>   * SPI NOR Flash
>   * eMMC
>   * 2x Ethernet
>   * Micro SD card
>   * I2C EEPROM
>   * I2C RTC
>   * GPIO Expander
>   * LEDs
>   * USB
> 
> For more details, see:
> 
> [1] Product page SoM: https://www.phytec.com/product/phycore-am62x
> [2] Product page CB: https://www.phytec.com/product/phyboard-am62x
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  arch/arm64/boot/dts/ti/Makefile               |   1 +
>  .../boot/dts/ti/k3-am62-phycore-som.dtsi      | 324 ++++++++++++++++++
>  .../dts/ti/k3-am625-phyboard-lyra-rdk.dts     | 267 +++++++++++++++

Just wondering: if the carrier board can easily work with different
SoMs.. in which case, we could do overlay to create the som + carrier
overlay to create rdk dtb - this might allow the scheme to scale to
additional SoMs and carrier combinations.. and the SoM dtb could be
sufficient for something like a bootloader.


>  3 files changed, 592 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index c83c9d772b81..9388dc481d7d 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -10,6 +10,7 @@
>  
>  # Boards with AM62x SoC
>  dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am625-phyboard-lyra-rdk.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
> new file mode 100644
> index 000000000000..32264296c8c6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
> @@ -0,0 +1,324 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 - 2023 PHYTEC Messtechnik GmbH
> + * Author: Wadim Egorov <w.egorov@phytec.de>
> + *
> + * Product homepage:
> + * https://www.phytec.com/product/phycore-am62x
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/net/ti-dp83867.h>
> +
> +/ {
> +	model = "PHYTEC phyCORE-AM62x";
> +	compatible = "phytec,am62-phycore-som", "ti,am625";
> +
> +	aliases {
> +		ethernet0 = &cpsw_port1;
> +		gpio0 = &main_gpio0;
> +		gpio1 = &main_gpio1;
> +		i2c0 = &main_i2c0;
> +		mmc0 = &sdhci0;
> +		rtc0 = &i2c_som_rtc;
> +		rtc1 = &wkup_rtc0;
> +		spi0 = &ospi0;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
> +	};
> +
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		ramoops@9ca00000 {
> +			compatible = "ramoops";
> +			reg = <0x00 0x9ca00000 0x00 0x00100000>;
> +			record-size = <0x8000>;
> +			console-size = <0x8000>;
> +			ftrace-size = <0x00>;
> +			pmsg-size = <0x8000>;
> +		};
> +
> +		secure_tfa_ddr: tfa@9e780000 {
> +			reg = <0x00 0x9e780000 0x00 0x80000>;
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +
> +		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@9db00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0x9db00000 0x00 0x00c00000>;
> +			no-map;
> +		};
> +	};
> +
> +	vcc_5v0_som: regulator-vcc-5v0-som {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_5V0_SOM";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vdd_1v8: regulator-vdd-1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDD_1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc_5v0_som>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&leds_pins_default>;
> +
> +		led-0 {
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&main_gpio0 13 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			function = LED_FUNCTION_HEARTBEAT;
> +		};
> +	};
> +};
> +
> +&main_pmx0 {
> +	leds_pins_default: leds-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x034, PIN_OUTPUT, 7) /* (H21) OSPI0_CSN2.GPIO0_13 */
> +		>;
> +	};
> +
> +	main_i2c0_pins_default: main-i2c0-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x1e0, PIN_INPUT_PULLUP, 0) /* (B16) I2C0_SCL */
> +			AM62X_IOPAD(0x1e4, PIN_INPUT_PULLUP, 0) /* (A16) I2C0_SDA */
> +		>;
> +	};
> +
> +	main_mdio1_pins_default: main_mdio1-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x160, PIN_OUTPUT, 0) /* (AD24) MDIO0_MDC */
> +			AM62X_IOPAD(0x15c, PIN_INPUT, 0) /* (AB22) MDIO0_MDIO */
> +		>;
> +	};
> +
> +	main_mmc0_pins_default: main-mmc0-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x220, PIN_INPUT_PULLUP, 0) /* (Y3) MMC0_CMD */
> +			AM62X_IOPAD(0x218, PIN_INPUT_PULLDOWN, 0) /* (AB1) MMC0_CLK */
> +			AM62X_IOPAD(0x214, PIN_INPUT_PULLUP, 0) /* (AA2) MMC0_DAT0 */
> +			AM62X_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (AA1) MMC0_DAT1 */
> +			AM62X_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (AA3) MMC0_DAT2 */
> +			AM62X_IOPAD(0x208, PIN_INPUT_PULLUP, 0) /* (Y4) MMC0_DAT3 */
> +			AM62X_IOPAD(0x204, PIN_INPUT_PULLUP, 0) /* (AB2) MMC0_DAT4 */
> +			AM62X_IOPAD(0x200, PIN_INPUT_PULLUP, 0) /* (AC1) MMC0_DAT5 */
> +			AM62X_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (AD2) MMC0_DAT6 */
> +			AM62X_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AC2) MMC0_DAT7 */
> +		>;
> +	};
> +
> +	main_rgmii1_pins_default: main-rgmii1-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x14c, PIN_INPUT, 0) /* (AB17) RGMII1_RD0 */
> +			AM62X_IOPAD(0x150, PIN_INPUT, 0) /* (AC17) RGMII1_RD1 */
> +			AM62X_IOPAD(0x154, PIN_INPUT, 0) /* (AB16) RGMII1_RD2 */
> +			AM62X_IOPAD(0x158, PIN_INPUT, 0) /* (AA15) RGMII1_RD3 */
> +			AM62X_IOPAD(0x148, PIN_INPUT, 0) /* (AD17) RGMII1_RXC */
> +			AM62X_IOPAD(0x144, PIN_INPUT, 0) /* (AE17) RGMII1_RX_CTL */
> +			AM62X_IOPAD(0x134, PIN_OUTPUT, 0) /* (AE20) RGMII1_TD0 */
> +			AM62X_IOPAD(0x138, PIN_OUTPUT, 0) /* (AD20) RGMII1_TD1 */
> +			AM62X_IOPAD(0x13c, PIN_OUTPUT, 0) /* (AE18) RGMII1_TD2 */
> +			AM62X_IOPAD(0x140, PIN_OUTPUT, 0) /* (AD18) RGMII1_TD3 */
> +			AM62X_IOPAD(0x130, PIN_OUTPUT, 0) /* (AE19) RGMII1_TXC */
> +			AM62X_IOPAD(0x12c, PIN_OUTPUT, 0) /* (AD19) RGMII1_TX_CTL */
> +		>;
> +	};
> +
> +	ospi0_pins_default: ospi0-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x000, PIN_OUTPUT, 0) /* (H24) OSPI0_CLK */
> +			AM62X_IOPAD(0x02c, PIN_OUTPUT, 0) /* (F23) OSPI0_CSn0 */
> +			AM62X_IOPAD(0x00c, PIN_INPUT, 0) /* (E25) OSPI0_D0 */
> +			AM62X_IOPAD(0x010, PIN_INPUT, 0) /* (G24) OSPI0_D1 */
> +			AM62X_IOPAD(0x014, PIN_INPUT, 0) /* (F25) OSPI0_D2 */
> +			AM62X_IOPAD(0x018, PIN_INPUT, 0) /* (F24) OSPI0_D3 */
> +			AM62X_IOPAD(0x01c, PIN_INPUT, 0) /* (J23) OSPI0_D4 */
> +			AM62X_IOPAD(0x020, PIN_INPUT, 0) /* (J25) OSPI0_D5 */
> +			AM62X_IOPAD(0x024, PIN_INPUT, 0) /* (H25) OSPI0_D6 */
> +			AM62X_IOPAD(0x028, PIN_INPUT, 0) /* (J22) OSPI0_D7 */
> +			AM62X_IOPAD(0x008, PIN_INPUT, 0) /* (J24) OSPI0_DQS */
> +		>;
> +	};
> +
> +	pmic_irq_pins_default: pmic-irq-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x01f4, PIN_INPUT, 0) /* (D16) EXTINTn */
> +		>;
> +	};
> +};
> +
> +&cpsw3g {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_rgmii1_pins_default>;
> +};
> +
> +&cpsw_port1 {
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&cpsw3g_phy1>;
> +};
> +
> +&cpsw3g_mdio {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mdio1_pins_default>;
> +	status = "okay";
> +
> +	cpsw3g_phy1: ethernet-phy@1 {
> +		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
> +		reg = <1>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +	};
> +};
> +
> +&main_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c0_pins_default>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	pmic@30 {
> +		compatible = "ti,tps65219";
> +		reg = <0x30>;
> +		buck1-supply = <&vcc_5v0_som>;
> +		buck2-supply = <&vcc_5v0_som>;
> +		buck3-supply = <&vcc_5v0_som>;
> +		ldo1-supply = <&vdd_3v3>;
> +		ldo2-supply = <&vdd_1v8>;
> +		ldo3-supply = <&vcc_5v0_som>;
> +		ldo4-supply = <&vcc_5v0_som>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_irq_pins_default>;
> +		interrupt-parent = <&gic500>;
> +		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +
> +		ti,power-button;
> +		system-power-controller;
> +
> +		regulators {
> +			vdd_core: buck1 {
> +				regulator-name = "VDD_CORE";
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vdd_3v3: buck2 {
> +				regulator-name = "VDD_3V3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vdd_ddr4: buck3 {
> +				regulator-name = "VDD_DDR4";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vddshv5_sdio: ldo1 {
> +				regulator-name = "VDDSHV5_SDIO";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-allow-bypass;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vddr_core: ldo2 {
> +				regulator-name = "VDDR_CORE";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <850000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vdda_1v8: ldo3 {
> +				regulator-name = "VDDA_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vdd_2v5: ldo4 {
> +				regulator-name = "VDD_2V5";
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <2500000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c32";
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
> +	status = "okay";
> +
> +	serial_flash: flash@0 {
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
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mmc0_pins_default>;
> +	ti,driver-strength-ohm = <50>;
> +	disable-wp;
> +	non-removable;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> new file mode 100644
> index 000000000000..bad26b554f98
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 - 2023 PHYTEC Messtechnik GmbH
> + * Author: Wadim Egorov <w.egorov@phytec.de>
> + *
> + * Product homepage:
> + * https://www.phytec.com/product/phyboard-am62x
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/net/ti-dp83867.h>
> +#include "k3-am625.dtsi"
> +#include "k3-am62-phycore-som.dtsi"
> +
> +/ {
> +	compatible = "phytec,am625-phyboard-lyra-rdk",
> +		     "phytec,am62-phycore-som", "ti,am625";
> +	model = "PHYTEC phyBOARD-Lyra AM625";
> +
> +	aliases {
> +		serial2 = &main_uart0;
> +		serial3 = &main_uart1;
> +		mmc1 = &sdhci1;
> +		usb0 = &usb0;
> +		usb1 = &usb1;
> +		ethernet1 = &cpsw_port2;
> +	};
> +
> +	can_tc1: can-phy0 {
> +		compatible = "ti,tcan1042";
> +		#phy-cells = <0>;
> +		max-bitrate = <5000000>;
> +		standby-gpios = <&gpio_exp 1 GPIO_ACTIVE_HIGH>;
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
> +			gpios = <&main_gpio1 23 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		key-menu {
> +			label = "menu";
> +			linux,code = <KEY_MENU>;
> +			gpios = <&gpio_exp 4 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&leds_pins_default &user_leds_pins_default>;
> +
> +		led-1 {
> +			gpios = <&main_gpio0 32 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "mmc0";
> +		};
> +
> +		led-2 {
> +			gpios = <&gpio_exp 2 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "mmc1";
> +		};
> +	};
> +
> +	vcc_3v3_mmc: regulator-vcc-3v3-mmc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_3V3_MMC";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&main_pmx0 {
> +	gpio_keys_pins_default: gpio-keys-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x1d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
> +		>;
> +	};
> +
> +	gpio_exp_int_pins_default: gpio-exp-int-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x244, PIN_INPUT, 7) /* (C17) MMC1_SDWP.GPIO1_49 */
> +		>;
> +	};
> +
> +	main_i2c1_pins_default: main-i2c1-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x1e8, PIN_INPUT_PULLUP, 0) /* (B17) I2C1_SCL */
> +			AM62X_IOPAD(0x1ec, PIN_INPUT_PULLUP, 0) /* (A17) I2C1_SDA */
> +		>;
> +	};
> +
> +	main_mcan0_pins_default: main-mcan0-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x1dc, PIN_INPUT, 0) /* (E15) MCAN0_RX */
> +			AM62X_IOPAD(0x1d8, PIN_OUTPUT, 0) /* (C15) MCAN0_TX */
> +		>;
> +	};
> +
> +	main_mmc1_pins_default: main-mmc1-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x23c, PIN_INPUT_PULLUP, 0) /* (A21) MMC1_CMD */
> +			AM62X_IOPAD(0x234, PIN_INPUT_PULLDOWN, 0) /* (B22) MMC1_CLK */
> +			AM62X_IOPAD(0x230, PIN_INPUT_PULLUP, 0) /* (A22) MMC1_DAT0 */
> +			AM62X_IOPAD(0x22c, PIN_INPUT_PULLUP, 0) /* (B21) MMC1_DAT1 */
> +			AM62X_IOPAD(0x228, PIN_INPUT_PULLUP, 0) /* (C21) MMC1_DAT2 */
> +			AM62X_IOPAD(0x224, PIN_INPUT_PULLUP, 0) /* (D22) MMC1_DAT3 */
> +			AM62X_IOPAD(0x240, PIN_INPUT_PULLUP, 0) /* (D17) MMC1_SDCD */
> +		>;
> +	};
> +
> +	main_rgmii2_pins_default: main-rgmii2-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x184, PIN_INPUT, 0) /* (AE23) RGMII2_RD0 */
> +			AM62X_IOPAD(0x188, PIN_INPUT, 0) /* (AB20) RGMII2_RD1 */
> +			AM62X_IOPAD(0x18c, PIN_INPUT, 0) /* (AC21) RGMII2_RD2 */
> +			AM62X_IOPAD(0x190, PIN_INPUT, 0) /* (AE22) RGMII2_RD3 */
> +			AM62X_IOPAD(0x180, PIN_INPUT, 0) /* (AD23) RGMII2_RXC */
> +			AM62X_IOPAD(0x17c, PIN_INPUT, 0) /* (AD22) RGMII2_RX_CTL */
> +			AM62X_IOPAD(0x16c, PIN_OUTPUT, 0) /* (Y18) RGMII2_TD0 */
> +			AM62X_IOPAD(0x170, PIN_OUTPUT, 0) /* (AA18) RGMII2_TD1 */
> +			AM62X_IOPAD(0x174, PIN_OUTPUT, 0) /* (AD21) RGMII2_TD2 */
> +			AM62X_IOPAD(0x178, PIN_OUTPUT, 0) /* (AC20) RGMII2_TD3 */
> +			AM62X_IOPAD(0x168, PIN_OUTPUT, 0) /* (AE21) RGMII2_TXC */
> +			AM62X_IOPAD(0x164, PIN_OUTPUT, 0) /* (AA19) RGMII2_TX_CTL */
> +		>;
> +	};
> +
> +	main_uart0_pins_default: main-uart0-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14) UART0_RXD */
> +			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14) UART0_TXD */
> +		>;
> +	};
> +
> +	main_uart1_pins_default: main-uart1-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x194, PIN_INPUT, 2) /* (B19) MCASP0_AXR3.UART1_CTSn */
> +			AM62X_IOPAD(0x198, PIN_OUTPUT, 2) /* (A19) MCASP0_AXR2.UART1_RTSn */
> +			AM62X_IOPAD(0x1ac, PIN_INPUT, 2) /* (E19) MCASP0_AFSR.UART1_RXD */
> +			AM62X_IOPAD(0x1b0, PIN_OUTPUT, 2) /* (A20) MCASP0_ACLKR.UART1_TXD */
> +		>;
> +	};
> +
> +	main_usb1_pins_default: main-usb1-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x258, PIN_OUTPUT, 0) /* (F18) USB1_DRVVBUS */
> +		>;
> +	};
> +
> +	user_leds_pins_default: user-leds-pins-default {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x084, PIN_OUTPUT, 7) /* (L23) GPMC0_ADVn_ALE.GPIO0_32 */
> +		>;
> +	};
> +};
> +
> +&cpsw3g {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_rgmii1_pins_default
> +		     &main_rgmii2_pins_default>;
> +};
> +
> +&cpsw_port2 {
> +	phy-mode = "rgmii-rxid";
> +	phy-handle = <&cpsw3g_phy3>;
> +};
> +
> +&cpsw3g_mdio {
> +	cpsw3g_phy3: ethernet-phy@3 {
> +		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
> +		reg = <3>;
> +		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> +		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> +	};
> +};
> +
> +&main_i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c1_pins_default>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	gpio_exp: gpio-expander@21 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_exp_int_pins_default>;
> +		compatible = "nxp,pcf8574";
> +		reg = <0x21>;
> +		interrupt-parent = <&main_gpio1>;
> +		interrupts = <49 0>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		gpio-line-names = "GPIO0_HDMI_RST", "GPIO1_CAN0_nEN",
> +				  "GPIO2_LED2", "GPIO3_LVDS_GPIO",
> +				  "GPIO4_BUT2", "GPIO5_LVDS_BKLT_EN",
> +				  "GPIO6_ETH1_USER_RESET", "GPIO7_AUDIO_USER_RESET";
> +	};
> +
> +	eeprom@51 {
> +		compatible = "atmel,24c02";
> +		pagesize = <16>;
> +		reg = <0x51>;
> +	};
> +};
> +
> +&main_mcan0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mcan0_pins_default>;
> +	phys = <&can_tc1>;
> +	status = "okay";
> +};
> +
> +&main_uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart0_pins_default>;
> +	status = "okay";
> +};
> +
> +&main_uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart1_pins_default>;
> +	/* Main UART1 may be used by TIFS firmware */
> +	status = "okay";
> +};
> +
> +&sdhci1 {
> +	vmmc-supply = <&vcc_3v3_mmc>;
> +	vqmmc-supply = <&vddshv5_sdio>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_mmc1_pins_default>;
> +	ti,driver-strength-ohm = <50>;
> +	disable-wp;
> +	no-1-8-v;
> +	status = "okay";
> +};
> +
> +&usbss0 {
> +	ti,vbus-divider;
> +	status = "okay";
> +};
> +
> +&usbss1 {
> +	ti,vbus-divider;
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	dr_mode = "peripheral";
> +};
> +
> +&usb1 {
> +	dr_mode = "host";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_usb1_pins_default>;
> +};
> -- 
> 2.25.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
