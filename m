Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C0C672019
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjAROtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjAROsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:48:31 -0500
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [IPv6:2001:1600:4:17::42aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F92E6C57C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:41:05 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NxpNH1j16zMqHk6;
        Wed, 18 Jan 2023 15:41:03 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NxpNG4Nk9zFYJ;
        Wed, 18 Jan 2023 15:41:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1674052863;
        bh=Dw+BJj7/6vlNW0mSYEjwBL6wCNrdZJztboGrZ3QKTqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m6hZzqGdsZuj0smaUJW7qy+/DmmALSxS2PEOPepKADOfOHhquCee0Cq59khg3vIEP
         ghEW+OSOvjbxa0VOk8Pxk7s5Gu+NXYOcAZ4mn7/DCccl+hS0jvtmDIcQE8mrUUWXHi
         Ia+Ru67xbpixv2PeHHu6rkWbMHArl9xwkuh2r7YU=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
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
Subject: [PATCH 3/3] arm64: dts: imx8mp-verdin: Add yavia carrier board
Date:   Wed, 18 Jan 2023 15:40:42 +0100
Message-Id: <20230118144042.7705-4-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118144042.7705-1-dev@pschenker.ch>
References: <20230118144042.7705-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../freescale/imx8mp-verdin-nonwifi-yavia.dts |  18 ++
 .../freescale/imx8mp-verdin-wifi-yavia.dts    |  18 ++
 .../dts/freescale/imx8mp-verdin-yavia.dtsi    | 199 ++++++++++++++++++
 4 files changed, 237 insertions(+)
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
index 000000000000..a29ac3fa1651
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ */
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
+		/* SODIMM 52 */
+		led-1 {
+			label = "LD1_RED";
+			gpios = <&gpio3 0 GPIO_ACTIVE_HIGH>;
+		};
+		/* SODIMM 54 */
+		led-2{
+			label = "LD1_GREEN";
+			gpios = <&gpio3 1 GPIO_ACTIVE_HIGH>;
+		};
+		/* SODIMM 56 */
+		led-3 {
+			label = "LD1_BLUE";
+			gpios = <&gpio3 6 GPIO_ACTIVE_HIGH>;
+		};
+		/* SODIMM 58 */
+		led-4 {
+			label = "LD2_RED";
+			gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		};
+		/* SODIMM 60 */
+		led-5 {
+			label = "LD2_GREEN";
+			gpios = <&gpio3 8 GPIO_ACTIVE_HIGH>;
+		};
+		/* SODIMM 62 */
+		led-6 {
+			label = "LD2_BLUE";
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

