Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4208C677F78
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjAWPTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjAWPTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:19:31 -0500
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6AD29177;
        Mon, 23 Jan 2023 07:18:51 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4P0tyJ6NTZzMqBk7;
        Mon, 23 Jan 2023 16:17:44 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4P0tyJ1vp7zMqXNr;
        Mon, 23 Jan 2023 16:17:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1674487064;
        bh=NGLwp0GY1OF2DwMEj8qnWtv0AIQWx6dwRPS3v8teXNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TiRmdH0NJGakbf5zhK9xD3BU9U14kMPzD2CvpLIRWWZlg3r+Ke6ewDs4NxijwR4MX
         AqP9rQqKr7AfH1dC8mGqlwHN5yIgm+c2uAcmK3g+qwy4HfSt1gQjBHFxSGc3tyKJ/h
         WRaZa2CU6GtTy9ops5UxO6RE8NfKJ3VmfgHTBsuQ=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: imx8mp-verdin: Add yavia carrier board
Date:   Mon, 23 Jan 2023 16:17:34 +0100
Message-Id: <20230123151734.44184-4-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123151734.44184-1-dev@pschenker.ch>
References: <20230123151734.44184-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Add new carrier board device tree Yavia for the Verdin iMX8M Plus SoM.

Yavia is a compact carrier board providing easy access to the most
common features of the Verdin family. The intended use of the carrier
board is application software development. The board is compatible with
all current and future Verdin SoMs.

Co-developed-by: Aishwarya Kothari <aishwarya.kothari@toradex.com>
Signed-off-by: Aishwarya Kothari <aishwarya.kothari@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v2:
- Switch deprecated label in led node with color, function and
  function-enumerator

 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../freescale/imx8mp-verdin-nonwifi-yavia.dts |  18 ++
 .../freescale/imx8mp-verdin-wifi-yavia.dts    |  18 ++
 .../dts/freescale/imx8mp-verdin-yavia.dtsi    | 213 ++++++++++++++++++
 4 files changed, 251 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-yavia.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-yavia.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 432f0c981eb8..df895e3798b8 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -98,8 +98,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mpxl.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-dev.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-nonwifi-yavia.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-wifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-wifi-dev.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-wifi-yavia.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-hummingboard-pulse.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-kontron-pitx-imx8m.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-yavia.dts b/arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-yavia.dts
new file mode 100644
index 000000000000..b28477df1ec6
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-yavia.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8mp-verdin.dtsi"
+#include "imx8mp-verdin-nonwifi.dtsi"
+#include "imx8mp-verdin-yavia.dtsi"
+
+/ {
+	model = "Toradex Verdin iMX8M Plus on Yavia Board";
+	compatible = "toradex,verdin-imx8mp-nonwifi-yavia",
+		     "toradex,verdin-imx8mp-nonwifi",
+		     "toradex,verdin-imx8mp",
+		     "fsl,imx8mp";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-yavia.dts b/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-yavia.dts
new file mode 100644
index 000000000000..100bef12089c
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-yavia.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8mp-verdin.dtsi"
+#include "imx8mp-verdin-wifi.dtsi"
+#include "imx8mp-verdin-yavia.dtsi"
+
+/ {
+	model = "Toradex Verdin iMX8M Plus WB on Yavia Board";
+	compatible = "toradex,verdin-imx8mp-wifi-yavia",
+		     "toradex,verdin-imx8mp-wifi",
+		     "toradex,verdin-imx8mp",
+		     "fsl,imx8mp";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
new file mode 100644
index 000000000000..bd7b31cc3760
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ */
+
+#include <dt-bindings/leds/common.h>
+
+/ {
+	/* Carrier Board Supply +V1.8 */
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "+V1.8_SW";
+	};
+
+	/* Carrier Board Supply +V3.3 */
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_SW";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds_yavia>;
+
+		/* SODIMM 52 - LD1_RED */
+		led-0 {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <1>;
+			gpios = <&gpio3 0 GPIO_ACTIVE_HIGH>;
+		};
+		/* SODIMM 54 - LD1_GREEN */
+		led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <1>;
+			gpios = <&gpio3 1 GPIO_ACTIVE_HIGH>;
+		};
+		/* SODIMM 56 - LD1_BLUE */
+		led-2 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <1>;
+			gpios = <&gpio3 6 GPIO_ACTIVE_HIGH>;
+		};
+		/* SODIMM 58 - LD2_RED */
+		led-3 {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <2>;
+			gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		};
+		/* SODIMM 60 - LD2_GREEN */
+		led-4 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <2>;
+			gpios = <&gpio3 8 GPIO_ACTIVE_HIGH>;
+		};
+		/* SODIMM 62 - LD2_BLUE */
+		led-5 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_DEBUG;
+			function-enumerator = <2>;
+			gpios = <&gpio3 9 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&backlight {
+	power-supply = <&reg_3p3v>;
+};
+
+/* Verdin SPI_1 */
+&ecspi1 {
+	status = "okay";
+};
+
+/* EEPROM on display adapter boards */
+&eeprom_display_adapter {
+	status = "okay";
+};
+
+/* EEPROM on Verdin yavia board */
+&eeprom_carrier_board {
+	status = "okay";
+};
+
+&eqos {
+	status = "okay";
+};
+
+&flexcan1 {
+	status = "okay";
+};
+
+&hwmon_temp {
+	status = "okay";
+};
+
+/* Verdin I2C_2_DSI */
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+/* Verdin PCIE_1 */
+&pcie {
+	status = "okay";
+};
+
+&pcie_phy{
+	status = "okay";
+};
+
+/* Verdin PWM_1 */
+&pwm1 {
+	status = "okay";
+};
+
+/* Verdin PWM_2 */
+&pwm2 {
+	status = "okay";
+};
+
+/* Verdin PWM_3_DSI */
+&pwm3 {
+	status = "okay";
+};
+
+&reg_usdhc2_vmmc {
+	vin-supply = <&reg_3p3v>;
+};
+
+/* Verdin UART_1 */
+&uart1 {
+	status = "okay";
+};
+
+/* Verdin UART_2 */
+&uart2 {
+	status = "okay";
+};
+
+/* Verdin UART_3, used as the Linux Console */
+&uart3 {
+	status = "okay";
+};
+
+/* Verdin USB_1 */
+&usb3_phy0 {
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	status = "okay";
+};
+
+/* Verdin USB_2 */
+&usb3_phy1 {
+	status = "okay";
+};
+
+&usb3_1 {
+	status = "okay";
+};
+
+&usb_dwc3_1 {
+	disable-over-current;
+	status = "okay";
+};
+
+/* Verdin SD_1 */
+&usdhc2 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_leds_yavia: ledsyaviagrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_ALE__GPIO3_IO00	0x106	/* SODIMM 52 */
+			MX8MP_IOMUXC_NAND_CE0_B__GPIO3_IO01	0x106	/* SODIMM 54 */
+			MX8MP_IOMUXC_NAND_DATA00__GPIO3_IO06	0x106	/* SODIMM 56 */
+			MX8MP_IOMUXC_NAND_DATA01__GPIO3_IO07	0x106	/* SODIMM 58 */
+			MX8MP_IOMUXC_NAND_DATA02__GPIO3_IO08	0x106	/* SODIMM 60 */
+			MX8MP_IOMUXC_NAND_DATA03__GPIO3_IO09	0x106	/* SODIMM 62 */
+		>;
+	};
+
+	pinctrl_gpios_ext_yavia: gpiosextyaviagrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_CE1_B__GPIO3_IO02	0x106	/* SODIMM 64 */
+			MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14	0x106	/* SODIMM 66 */
+		>;
+	};
+};
-- 
2.39.0

