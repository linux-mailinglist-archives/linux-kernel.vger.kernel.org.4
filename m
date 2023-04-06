Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E99C6D9D5B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbjDFQRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238661AbjDFQRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:17:39 -0400
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9351E93EF;
        Thu,  6 Apr 2023 09:17:33 -0700 (PDT)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id 2D93B5DC6B;
        Thu,  6 Apr 2023 18:16:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1680797813;
        bh=y8sMjQuLgz0fvt+N7Q0npbICaeAucl/9NhsFLIGoIIs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=txRR4OUdOFmfkvHswQh3wYqfI6g4llqZvcPAGa3QNT6wbThX94WsOWZjOBkREQq27
         aFKmAEQlrddoPWO93I9wLAIO0BZZlyec2Qvjbym5z6iG2t62ubIQWoWkzOzvQuf547
         plz80eum9wF9yLzkjoAaiVBa+vd/IuEBFJsQlrSP0I+pyxcM6A58K31UHVpzArAa+e
         GCR+dyyULOXKu02Wkv9FYLrmQCbzFIG0yu/6CmsyZIwCzYL2INPHga6zW+Dl8GfqRz
         coirq9D26iTb96U0cQs/Q7ZVbJtOuZcMmegN497YHYSrvQec/UIuR+CS6Rti/J9xTp
         KmYY1p8F5P5Dw==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Apr 2023 17:46:39 +0200
Received: from localhost.localdomain (172.16.51.16) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26 via Frontend Transport; Thu, 6 Apr 2023 17:46:39 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        <kernel@dh-electronics.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ARM: dts: imx6ull-dhcor: Add Marantec maveo box
Date:   Thu, 6 Apr 2023 17:45:29 +0200
Message-ID: <20230406154529.6349-3-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
In-Reply-To: <20230406154529.6349-1-cniedermaier@dh-electronics.com>
References: <20230406154529.6349-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Marantec maveo box. The system is used to get a
smart conntection to a door drive. It has USB, WiFi, Bluetooth,
Zigbee and NFC interfaces. The core of this system is a soldered
i.MX6ULL DHCOR SoM from DH electronics.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: kernel@dh-electronics.com
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
V2: - Correct the vendor prefix
    - Change pinconfig of User and Reset button
---
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx6ull-dhcor-maveo-box.dts | 361 ++++++++++++++++++++++++++
 2 files changed, 362 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ull-dhcor-maveo-box.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index aa8fb4b7cdcc..58d3334164e2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -751,6 +751,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ull-dhcom-drc02.dtb \
 	imx6ull-dhcom-pdk2.dtb \
 	imx6ull-dhcom-picoitx.dtb \
+	imx6ull-dhcor-maveo-box.dtb \
 	imx6ull-jozacp.dtb \
 	imx6ull-kontron-bl.dtb \
 	imx6ull-myir-mys-6ulx-eval.dtb \
diff --git a/arch/arm/boot/dts/imx6ull-dhcor-maveo-box.dts b/arch/arm/boot/dts/imx6ull-dhcor-maveo-box.dts
new file mode 100644
index 000000000000..83bacac19933
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ull-dhcor-maveo-box.dts
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2023 DH electronics GmbH
+ * Copyright (C) 2023 Marantec electronics GmbH
+ *
+ * DHCOM iMX6ULL variant:
+ * DHCR-iMX6ULL-C080-R051-SPI-WBT-I-01LG
+ * DHCOR PCB number: 578-200 or newer
+ * maveo box PCB number: 525-200 or newer
+ */
+
+/dts-v1/;
+
+#include "imx6ull-dhcor-som.dtsi"
+
+/ {
+	model = "DH electronics i.MX6ULL DHCOR on maveo box";
+	compatible = "marantec,imx6ull-dhcor-maveo-box", "dh,imx6ull-dhcor-som",
+		     "fsl,imx6ull";
+
+	aliases {
+		/delete-property/ mmc0; /* Avoid double definitions */
+		/delete-property/ mmc1;
+		mmc2 = &usdhc2; /* eMMC should be mmc2 */
+		spi0 = &ecspi4;
+		spi3 = &ecspi1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "usb-otg1-vbus";
+	};
+
+	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "usb-otg2-vbus";
+	};
+
+	/* WiFi pin WL_REG_ON is connected to GPIO 5.9 */
+	usdhc1_pwrseq: usdhc1-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+	};
+};
+
+/* BT pin BT_REG_ON is connected to GPIO 1.18 */
+&bluetooth {
+	shutdown-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
+};
+
+/* X10 connector */
+&ecspi4 {
+	cs-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&pinctrl_ecspi4>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	spidev@0 {
+		compatible = "dh,dhcom-board";
+		reg = <0>;
+		spi-cpha;
+		spi-cpol;
+		spi-max-frequency = <54000000>;
+	};
+};
+
+&gpio1 {
+	gpio-line-names =
+		"", "", "", "",
+		"", "BUTTON-USER", "", "",
+		"BUTTON-RESET", "", "", "",
+		"", "", "", "",
+		"", "", "BT-REG-ON", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "";
+};
+
+&gpio2 {
+	gpio-line-names =
+		"PSOC-GPIO-1", "", "", "X10-12",
+		"X10-10", "PSOC-GPIO-2", "PSOC-GPIO-3", "",
+		"X10-11", "X10-9", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "";
+};
+
+&gpio3 {
+	gpio-line-names =
+		"DHCOR-HW0", "DHCOR-HW1", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names =
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "MAVEO-BOX-HW0", "LED-G", "MAVEO-BOX-VAR1",
+		"MAVEO-BOX-VAR0", "MAVEO-BOX-HW1", "MAVEO-BOX-HW2", "LED-B",
+		"LED-R", "", "", "",
+		"", "", "", "";
+};
+
+&gpio5 {
+	gpio-line-names =
+		"PSOC-SWD-IO", "PSOC-SWD-CLK", "PSOC-RESET", "ZIGBEE-PROG",
+		"ZIGBEE-RESET", "", "PSOC-PWR-FAIL-OUT", "NFC-ENABLE",
+		"NFC-IRQ", "WL-REG-ON", "DHCOR-BOOT-M0", "DHCOR-BOOT-M1",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "",
+		"", "", "", "";
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&gpio1 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio1 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+/* Console UART */
+&uart1 {
+	pinctrl-0 = <&pinctrl_uart1>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+/* BT on LGA */
+&uart2 {
+	pinctrl-0 = <&pinctrl_uart2 &pinctrl_bt_gpio>;
+};
+
+/* Zigbee UART */
+&uart3 {
+	pinctrl-0 = <&pinctrl_uart3 &pinctrl_snvs_zigbee_gpio>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usbotg1 {
+	adp-disable;
+	disable-over-current; /* Overcurrent pin isn't connected */
+	dr_mode = "otg";
+	hnp-disable;
+	pinctrl-0 = <&pinctrl_usbotg1>;
+	pinctrl-names = "default";
+	srp-disable;
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	status = "okay";
+};
+
+&usbotg2 {
+	disable-over-current; /* Overcurrent pin isn't connected */
+	dr_mode = "host";
+	pinctrl-0 = <&pinctrl_usbotg2>;
+	pinctrl-names = "default";
+	tpl-support;
+	vbus-supply = <&reg_usb_otg2_vbus>;
+	status = "okay";
+};
+
+&usbphy1 {
+	fsl,tx-d-cal = <106>;
+};
+
+&usbphy2 {
+	fsl,tx-d-cal = <106>;
+};
+
+/* WiFi on LGA */
+&usdhc1 {
+	mmc-pwrseq = <&usdhc1_pwrseq>;
+	pinctrl-0 = <&pinctrl_usdhc1_wifi &pinctrl_snvs_wifi_gpio>;
+};
+
+/* eMMC */
+&usdhc2 {
+	bus-width = <8>;
+	no-1-8-v;
+	non-removable;
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-names = "default";
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-0 = <&pinctrl_hog_maveo_box>;
+	pinctrl-names = "default";
+
+	pinctrl_hog_maveo_box: hog-maveo-box-grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO05__GPIO1_IO05	0x120b0    /* BUTTON_USER */
+			MX6UL_PAD_GPIO1_IO08__GPIO1_IO08	0x120b0    /* BUTTON_RESET */
+			MX6UL_PAD_CSI_PIXCLK__GPIO4_IO18	0x400120b0 /* LED_G */
+			MX6UL_PAD_CSI_DATA02__GPIO4_IO23	0x400120b0 /* LED_B */
+			MX6UL_PAD_CSI_DATA03__GPIO4_IO24	0x400120b0 /* LED_R */
+			MX6UL_PAD_ENET2_RX_DATA1__GPIO2_IO09	0x400120b0 /* X10_9 */
+			MX6UL_PAD_ENET1_TX_DATA1__GPIO2_IO04	0x400120b0 /* X10_10 */
+			MX6UL_PAD_ENET2_RX_DATA0__GPIO2_IO08	0x400120b0 /* X10_11 */
+			MX6UL_PAD_ENET1_TX_DATA0__GPIO2_IO03	0x400120b0 /* X10_12 */
+			MX6UL_PAD_ENET1_RX_DATA0__GPIO2_IO00	0x400120b0 /* PSOC_GPIO_1 */
+			MX6UL_PAD_ENET1_TX_EN__GPIO2_IO05	0x400120b0 /* PSOC_GPIO_2 */
+			MX6UL_PAD_ENET1_TX_CLK__GPIO2_IO06	0x400120b0 /* PSOC_GPIO_3 */
+			MX6UL_PAD_CSI_MCLK__GPIO4_IO17		0x120b0    /* MAVEO_BOX_HW0 */
+			MX6UL_PAD_CSI_DATA00__GPIO4_IO21	0x120b0    /* MAVEO_BOX_HW1 */
+			MX6UL_PAD_CSI_DATA01__GPIO4_IO22	0x120b0    /* MAVEO_BOX_HW2 */
+			MX6UL_PAD_CSI_HSYNC__GPIO4_IO20		0x120b0    /* MAVEO_BOX_VAR0 */
+			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x120b0    /* MAVEO_BOX_VAR1 */
+			MX6UL_PAD_LCD_CLK__GPIO3_IO00		0x120b0    /* DHCOR_HW0 */
+			MX6UL_PAD_LCD_ENABLE__GPIO3_IO01	0x120b0    /* DHCOR_HW1 */
+			MX6UL_PAD_LCD_DATA00__GPIO3_IO05	0x120b0
+			MX6UL_PAD_LCD_DATA01__GPIO3_IO06	0x120b0
+			MX6UL_PAD_LCD_DATA02__GPIO3_IO07	0x120b0
+			MX6UL_PAD_LCD_DATA03__GPIO3_IO08	0x120b0
+			MX6UL_PAD_LCD_DATA04__GPIO3_IO09	0x120b0
+			MX6UL_PAD_LCD_DATA05__GPIO3_IO10	0x120b0
+			MX6UL_PAD_LCD_DATA06__GPIO3_IO11	0x120b0
+			MX6UL_PAD_LCD_DATA07__GPIO3_IO12	0x120b0
+			MX6UL_PAD_LCD_DATA08__GPIO3_IO13	0x120b0
+			MX6UL_PAD_LCD_DATA09__GPIO3_IO14	0x120b0
+			MX6UL_PAD_LCD_DATA10__GPIO3_IO15	0x120b0
+			MX6UL_PAD_LCD_DATA11__GPIO3_IO16	0x120b0
+			MX6UL_PAD_LCD_DATA12__GPIO3_IO17	0x120b0
+			MX6UL_PAD_LCD_DATA13__GPIO3_IO18	0x120b0
+			MX6UL_PAD_LCD_DATA14__GPIO3_IO19	0x120b0
+			MX6UL_PAD_LCD_DATA15__GPIO3_IO20	0x120b0
+			MX6UL_PAD_LCD_DATA16__GPIO3_IO21	0x120b0
+			MX6UL_PAD_LCD_DATA17__GPIO3_IO22	0x120b0
+			MX6UL_PAD_LCD_DATA18__GPIO3_IO23	0x120b0
+		>;
+	};
+
+	pinctrl_bt_gpio: bt-gpio-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_CTS_B__GPIO1_IO18	0x400120b0 /* BT_REG_ON */
+		>;
+	};
+
+	pinctrl_ecspi4: ecspi4-grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_TX_CLK__ECSPI4_MISO	0x100b1
+			MX6UL_PAD_ENET2_TX_EN__ECSPI4_MOSI	0x100b1
+			MX6UL_PAD_ENET2_TX_DATA1__ECSPI4_SCLK	0x100b1
+			MX6UL_PAD_ENET2_RX_ER__GPIO2_IO15	0x1b0b0 /* SS0 */
+		>;
+	};
+
+	pinctrl_i2c2: i2c2-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART5_TX_DATA__I2C2_SCL	0x4001b8b0
+			MX6UL_PAD_UART5_RX_DATA__I2C2_SDA	0x4001b8b0
+		>;
+	};
+
+	pinctrl_i2c2_gpio: i2c2-gpio-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART5_TX_DATA__GPIO1_IO30	0x4001b8b0
+			MX6UL_PAD_UART5_RX_DATA__GPIO1_IO31	0x4001b8b0
+		>;
+	};
+
+	pinctrl_uart1: uart1-grp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart3: uart3-grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_READY_B__UART3_DCE_TX	0x1b0b1
+			MX6UL_PAD_NAND_CE0_B__UART3_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_usbotg1: usbotg1-grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO00__ANATOP_OTG1_ID	0x17059
+			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0x120b0 /* USB_OTG1_PWR */
+		>;
+	};
+
+	pinctrl_usbotg2: usbotg2-grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0x120b0 /* USB_OTG2_PWR */
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2-grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x10069
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x17059
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x17059
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x17059
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x17059
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x17059
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x17059
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x17059
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x17059
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x17059
+			MX6UL_PAD_NAND_ALE__USDHC2_RESET_B	0x17059 /* SD2 Reset */
+		>;
+	};
+};
+
+&iomuxc_snvs {
+	pinctrl-0 = <&pinctrl_snvs_hog_maveo_box>;
+	pinctrl-names = "default";
+
+	pinctrl_snvs_hog_maveo_box: snvs-hog-maveo-box-grp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x400120b0 /* PSOC_SWD_IO */
+			MX6ULL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x400120b0 /* PSOC_SWD_CLK */
+			MX6ULL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x400120b0 /* PSOC_RESET */
+			MX6ULL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x400120b0 /* PSOC_PWR_FAIL_OUT */
+			MX6ULL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x400120b0 /* NFC_ENABLE */
+			MX6ULL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x400120b0 /* NFC_IRQ */
+			MX6ULL_PAD_BOOT_MODE0__GPIO5_IO10	0x120b0    /* DHCOR_BOOT_M0 */
+			MX6ULL_PAD_BOOT_MODE1__GPIO5_IO11	0x120b0    /* DHCOR_BOOT_M1 */
+		>;
+	};
+
+	pinctrl_snvs_wifi_gpio: snvs-wifi-gpio-grp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER9__GPIO5_IO09	0x400120b0 /* WL_REG_ON */
+		>;
+	};
+
+	pinctrl_snvs_zigbee_gpio: snvs-zigbee-gpio-grp {
+		fsl,pins = <
+			MX6ULL_PAD_SNVS_TAMPER3__GPIO5_IO03	0x400120b0 /* ZIGBEE_PROG */
+			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x400120b0 /* ZIGBEE_RESET */
+		>;
+	};
+};
-- 
2.11.0

