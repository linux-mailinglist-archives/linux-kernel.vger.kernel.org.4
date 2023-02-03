Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E969688E3A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjBCDvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjBCDvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:51:13 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8374E8B316;
        Thu,  2 Feb 2023 19:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675396267; x=1706932267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Na3RIlAVA5tvdIDpm9dq7Of4EtVM3MSHAsyyVXcYf8=;
  b=uuczwWlmcGc+1pE8031Zxw3kXv+izowT+o1vCNKeP9K0yjbbXFKMEEhQ
   my2Zf3jIBMmAVDl8p6UvdHgEriRUaHjdH69/UIfi/fMJ+03kihVaZAhRO
   PhlDytm8aIiZVskZ1mIWGoXs/Ry/J86o7s1H91CPW+cryoxmvz1TrbLwh
   JWrF+LL0wEPWJ7l8u1+0f+z4dtpfV5rjcD6DeH1K+AbmZm8IYmA3Ip+3s
   aYS7f4QIC25pEzdiT6D2MtBOTqfFoLHUCYHszVEpu1W51q3cLCaoBnd19
   e/3K9LsBSSsRzYG668GtGBu/qHCT9mmRmNFphGFSrNqK3pM+EoDb3sB06
   A==;
X-IronPort-AV: E=Sophos;i="5.97,269,1669100400"; 
   d="scan'208";a="199411260"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Feb 2023 20:51:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 20:51:05 -0700
Received: from che-lt-i66125lx.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 20:50:56 -0700
From:   Durai Manickam KR <durai.manickamkr@microchip.com>
To:     <Hari.PrasathGE@microchip.com>,
        <balamanikandan.gunasundar@microchip.com>,
        <manikandan.m@microchip.com>, <varshini.rajendran@microchip.com>,
        <dharma.b@microchip.com>, <nayabbasha.sayed@microchip.com>,
        <balakrishnan.s@microchip.com>, <claudiu.beznea@microchip.com>,
        <cristian.birsan@microchip.com>, <nicolas.ferre@microchip.com>,
        <krzysztof.kozlowski@linaro.org>, <alexandre.belloni@bootlin.com>,
        <davem@davemloft.net>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Horatiu.Vultur@microchip.com>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <michael@walle.cc>, <jerry.ray@microchip.com>
CC:     Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH v5 8/8] ARM: dts: at91: sam9x60_curiosity: Add device tree for sam9x60 curiosity board
Date:   Fri, 3 Feb 2023 09:18:33 +0530
Message-ID: <20230203034833.451461-9-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203034833.451461-1-durai.manickamkr@microchip.com>
References: <20230203034833.451461-1-durai.manickamkr@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree file for sam9x60 curiosity board.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 arch/arm/boot/dts/Makefile                   |   1 +
 arch/arm/boot/dts/at91-sam9x60_curiosity.dts | 501 +++++++++++++++++++
 2 files changed, 502 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-sam9x60_curiosity.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6aa7dc4db2fc..da20980384c4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -51,6 +51,7 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
 	at91sam9x25ek.dtb \
 	at91sam9x35ek.dtb
 dtb-$(CONFIG_SOC_SAM9X60) += \
+	at91-sam9x60_curiosity.dtb \
 	at91-sam9x60ek.dtb
 dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-kizbox2-2.dtb \
diff --git a/arch/arm/boot/dts/at91-sam9x60_curiosity.dts b/arch/arm/boot/dts/at91-sam9x60_curiosity.dts
new file mode 100644
index 000000000000..6f0a6d9841fc
--- /dev/null
+++ b/arch/arm/boot/dts/at91-sam9x60_curiosity.dts
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * at91-sam9x60_curiosity.dts - Device Tree file for Microchip SAM9X60 Curiosity board
+ *
+ * Copyright (C) 2022 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Durai Manickam KR <durai.manickamkr@microchip.com>
+ */
+/dts-v1/;
+#include "sam9x60.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Microchip SAM9X60 Curiosity";
+	compatible = "microchip,sam9x60-curiosity", "microchip,sam9x60", "atmel,at91sam9";
+
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c6;
+		serial2 = &uart7;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@20000000 {
+		reg = <0x20000000 0x8000000>;
+	};
+
+	clocks {
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <24000000>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_key_gpio_default>;
+
+		button-user {
+			label = "PB_USER";
+			gpios = <&pioA 29 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_PROG1>;
+			wakeup-source;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led-red {
+			label = "red";
+			gpios = <&pioD 17 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-green {
+			label = "green";
+			gpios = <&pioD 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-blue {
+			label = "blue";
+			gpios = <&pioD 21 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+
+	vdd_1v8: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "VDD_1V8";
+	};
+
+	vdd_1v15: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <1150000>;
+		regulator-min-microvolt = <1150000>;
+		regulator-name = "VDD_1V15";
+	};
+
+	vdd1_3v3: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VDD1_3V3";
+	};
+};
+
+&adc {
+	vddana-supply = <&vdd1_3v3>;
+	vref-supply = <&vdd1_3v3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc_default &pinctrl_adtrg_default>;
+	status = "okay";
+};
+
+&can0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can0_rx_tx>;
+	status = "disabled"; /* Conflict with dbgu. */
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1_rx_tx>;
+	status = "okay";
+};
+
+&dbgu {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_dbgu>;
+	status = "okay"; /* Conflict with can0. */
+};
+
+&ebi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ebi_addr_nand &pinctrl_ebi_data_lsb>;
+	status = "okay";
+
+	nand_controller: nand-controller {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_nand_oe_we &pinctrl_nand_cs &pinctrl_nand_rb>;
+		status = "okay";
+
+		nand@3 {
+			reg = <0x3 0x0 0x800000>;
+			rb-gpios = <&pioD 5 GPIO_ACTIVE_HIGH>;
+			cs-gpios = <&pioD 4 GPIO_ACTIVE_HIGH>;
+			nand-bus-width = <8>;
+			nand-ecc-mode = "hw";
+			nand-ecc-strength = <8>;
+			nand-ecc-step-size = <512>;
+			nand-on-flash-bbt;
+			label = "atmel_nand";
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				at91bootstrap@0 {
+					label = "at91bootstrap";
+					reg = <0x0 0x40000>;
+				};
+
+				uboot@40000 {
+					label = "u-boot";
+					reg = <0x40000 0xc0000>;
+				};
+
+				ubootenvred@100000 {
+					label = "U-Boot Env Redundant";
+					reg = <0x100000 0x40000>;
+				};
+
+				ubootenv@140000 {
+					label = "U-Boot Env";
+					reg = <0x140000 0x40000>;
+				};
+
+				dtb@180000 {
+					label = "device tree";
+					reg = <0x180000 0x80000>;
+				};
+
+				kernel@200000 {
+					label = "kernel";
+					reg = <0x200000 0x600000>;
+				};
+
+				rootfs@800000 {
+					label = "rootfs";
+					reg = <0x800000 0x1f800000>;
+				};
+			};
+		};
+	};
+};
+
+&flx0 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
+	status = "okay";
+
+	i2c0: i2c@600 {
+		dmas = <0>, <0>;
+		pinctrl-names = "default";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-0 = <&pinctrl_flx0_default>;
+		i2c-analog-filter;
+		i2c-digital-filter;
+		i2c-digital-filter-width-ns = <35>;
+		status = "okay";
+
+		eeprom@53 {
+			compatible = "atmel,24c02";
+			reg = <0x53>;
+			pagesize = <16>;
+		};
+	};
+};
+
+&flx6 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
+	status = "okay";
+
+	i2c6: i2c@600 {
+		dmas = <0>, <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flx6_default>;
+		i2c-analog-filter;
+		i2c-digital-filter;
+		i2c-digital-filter-width-ns = <35>;
+		status = "disabled";
+	};
+};
+
+&flx7 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
+	status = "okay";
+
+	uart7: serial@200 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flx7_default>;
+		status = "okay";
+	};
+};
+
+&macb0 {
+	phy-mode = "rmii";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_macb0_rmii>;
+	status = "okay";
+
+	ethernet-phy@0 {
+		reg = <0x0>;
+	};
+};
+
+&pinctrl {
+	adc {
+		pinctrl_adc_default: adc-default {
+			atmel,pins = <AT91_PIOB 14 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+		};
+
+		pinctrl_adtrg_default: adtrg-default {
+			atmel,pins = <AT91_PIOB 18 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;
+		};
+	};
+
+	can0 {
+		pinctrl_can0_rx_tx: can0-rx-tx {
+			atmel,pins =
+				<AT91_PIOA 9 AT91_PERIPH_B AT91_PINCTRL_NONE	/* CANRX0 */
+				 AT91_PIOA 10 AT91_PERIPH_B AT91_PINCTRL_NONE	/* CANTX0 */
+				 AT91_PIOC 9 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_DOWN>;	/* Enable CAN Transceivers */
+		};
+	};
+
+	can1 {
+		pinctrl_can1_rx_tx: can1-rx-tx {
+			atmel,pins =
+				<AT91_PIOA 6 AT91_PERIPH_B AT91_PINCTRL_NONE	/* CANRX1 */
+				 AT91_PIOA 5 AT91_PERIPH_B AT91_PINCTRL_NONE	/* CANTX1 */
+				 AT91_PIOB 17 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_DOWN>;	/* Enable CAN Transceivers */
+		};
+	};
+
+	dbgu {
+		pinctrl_dbgu: dbgu-0 {
+			atmel,pins = <AT91_PIOA 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+				      AT91_PIOA 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+		};
+	};
+
+	ebi {
+		pinctrl_ebi_data_lsb: ebi-data-lsb {
+			atmel,pins =
+				<AT91_PIOD 6 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 7 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 8 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 9 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 10 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 11 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 12 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 13 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
+		};
+
+		pinctrl_ebi_addr_nand: ebi-addr-nand {
+			atmel,pins =
+				<AT91_PIOD 2 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 3 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
+		};
+	};
+
+	flexcom {
+		pinctrl_flx0_default: flx0-twi {
+			atmel,pins =
+				<AT91_PIOA 0 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+				 AT91_PIOA 1 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
+		};
+
+		pinctrl_flx6_default: flx6-twi {
+			atmel,pins =
+				<AT91_PIOA 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+				 AT91_PIOA 31 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
+		};
+
+		pinctrl_flx7_default: flx7-usart {
+			atmel,pins =
+				<AT91_PIOC 0 AT91_PERIPH_C AT91_PINCTRL_NONE
+				 AT91_PIOC 1 AT91_PERIPH_C AT91_PINCTRL_NONE>;
+		};
+	};
+
+	gpio-keys {
+		pinctrl_key_gpio_default: pinctrl-key-gpio {
+			atmel,pins = <AT91_PIOA 29 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+
+	leds {
+		pinctrl_gpio_leds: gpio-leds {
+			atmel,pins = <AT91_PIOD 17 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				      AT91_PIOD 19 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				      AT91_PIOD 21 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+
+	macb0 {
+		pinctrl_macb0_rmii: macb0-rmii-0 {
+			atmel,pins =
+				<AT91_PIOB 0 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB0 periph A */
+				 AT91_PIOB 1 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB1 periph A */
+				 AT91_PIOB 2 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB2 periph A */
+				 AT91_PIOB 3 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB3 periph A */
+				 AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB4 periph A */
+				 AT91_PIOB 5 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB5 periph A */
+				 AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB6 periph A */
+				 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB7 periph A */
+				 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB9 periph A */
+				 AT91_PIOB 10 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB10 periph A */
+		};
+	};
+
+	nand {
+		pinctrl_nand_oe_we: nand-oe-we-0 {
+			atmel,pins =
+				<AT91_PIOD 0 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)
+				 AT91_PIOD 1 AT91_PERIPH_A (AT91_PINCTRL_NONE | AT91_PINCTRL_SLEWRATE_DIS)>;
+		};
+
+		pinctrl_nand_rb: nand-rb-0 {
+			atmel,pins =
+				<AT91_PIOD 5 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+		};
+
+		pinctrl_nand_cs: nand-cs-0 {
+			atmel,pins =
+				<AT91_PIOD 4 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;
+		};
+	};
+
+	pwm0 {
+		pinctrl_pwm0_0: pwm0-0 {
+			atmel,pins = <AT91_PIOB 12 AT91_PERIPH_B AT91_PINCTRL_NONE>;
+		};
+
+		pinctrl_pwm0_1: pwm0-1 {
+			atmel,pins = <AT91_PIOB 13 AT91_PERIPH_B AT91_PINCTRL_NONE>;
+		};
+
+		pinctrl_pwm0_2: pwm0-2 {
+			atmel,pins = <AT91_PIOD 16 AT91_PERIPH_B AT91_PINCTRL_NONE>;
+		};
+	};
+
+	sdmmc0 {
+		pinctrl_sdmmc0_default: sdmmc0 {
+			atmel,pins =
+				<AT91_PIOA 17 AT91_PERIPH_A (AT91_PINCTRL_DRIVE_STRENGTH_HI)				/* PA17 CK  periph A with pullup */
+				 AT91_PIOA 16 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA16 CMD periph A with pullup */
+				 AT91_PIOA 15 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA15 DAT0 periph A */
+				 AT91_PIOA 18 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA18 DAT1 periph A with pullup */
+				 AT91_PIOA 19 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA19 DAT2 periph A with pullup */
+				 AT91_PIOA 20 AT91_PERIPH_A (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)>;	/* PA20 DAT3 periph A with pullup */
+		};
+		pinctrl_sdmmc0_cd: sdmmc0-cd {
+			atmel,pins =
+				<AT91_PIOA 25 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+
+	sdmmc1 {
+		pinctrl_sdmmc1_default: sdmmc1 {
+			atmel,pins =
+				<AT91_PIOA 13 AT91_PERIPH_B (AT91_PINCTRL_DRIVE_STRENGTH_HI)				/* PA13 CK periph B */
+				 AT91_PIOA 12 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA12 CMD periph B with pullup */
+				 AT91_PIOA 11 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA11 DAT0 periph B with pullup */
+				 AT91_PIOA  2 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA2 DAT1 periph B with pullup */
+				 AT91_PIOA  3 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)	/* PA3 DAT2 periph B with pullup */
+				 AT91_PIOA  4 AT91_PERIPH_B (AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DRIVE_STRENGTH_HI)>;	/* PA4 DAT3 periph B with pullup */
+		};
+	};
+
+	usb0 {
+		pinctrl_usba_vbus: usba-vbus {
+			atmel,pins = <AT91_PIOA 27 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+
+	usb1 {
+		pinctrl_usb_default: usb-default {
+			atmel,pins = <AT91_PIOD 18 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				      AT91_PIOD 15 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
+}; /* pinctrl */
+
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_0 &pinctrl_pwm0_1 &pinctrl_pwm0_2>;
+	status = "okay";
+};
+
+&sdmmc0 {
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdmmc0_default &pinctrl_sdmmc0_cd>;
+	cd-gpios = <&pioA 25 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	status = "okay";
+};
+
+&sdmmc1 {
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdmmc1_default>;
+	status = "disabled";
+};
+
+&shutdown_controller {
+	debounce-delay-us = <976>;
+	status = "okay";
+
+	input@0 {
+		reg = <0>;
+	};
+};
+
+&tcb0 {
+	timer0: timer@0 {
+		compatible = "atmel,tcb-timer";
+		reg = <0>;
+	};
+
+	timer1: timer@1 {
+		compatible = "atmel,tcb-timer";
+		reg = <1>;
+	};
+};
+
+&usb0 {
+	atmel,vbus-gpio = <&pioA 27 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usba_vbus>;
+	status = "okay";
+};
+
+&usb1 {
+	num-ports = <3>;
+	atmel,vbus-gpio = <0
+			   &pioD 18 GPIO_ACTIVE_HIGH
+			   &pioD 15 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_default>;
+	status = "okay";
+};
+
+&usb2 {
+	status = "okay";
+};
+
+&watchdog {
+	status = "okay";
+};
-- 
2.25.1

