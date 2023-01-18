Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA68A67201D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjAROtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjAROse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:48:34 -0500
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5356F334
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:41:07 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NxpNG3fHhzMq66p;
        Wed, 18 Jan 2023 15:41:02 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NxpNF6FZMzFXv;
        Wed, 18 Jan 2023 15:41:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1674052862;
        bh=/oCw/pPxMTr3pySmihQDNQ+YgrdWfQyvSqmNinheXiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxS7v/VVCWYL6jKSl2SmfaTrdGW4pEO8lODDhbNqXOnm+OnKv53eojqB2k4o/Ak88
         omLH+G1gYEJUAfSdTeEuRZu9IE60en3iuHUSFC1MmH0p6aay38IFHfIe/QNPLe6Moq
         y1nq0/BWAB01eyYpCvnoTrRqM3a7Ilz46lPPfQmo=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: imx8mm-verdin: Add yavia carrier board
Date:   Wed, 18 Jan 2023 15:40:41 +0100
Message-Id: <20230118144042.7705-3-dev@pschenker.ch>
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

Add new carrier board device tree Yavia for the Verdin iMX8M Mini SoM.

Yavia is a compact carrier board providing easy access to the most
common features of the Verdin family. The intended use of the carrier
board is application software development. The board is compatible with
all current and future Verdin SoMs.

Co-developed-by: Aishwarya Kothari <aishwarya.kothari@toradex.com>
Signed-off-by: Aishwarya Kothari <aishwarya.kothari@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../freescale/imx8mm-verdin-nonwifi-yavia.dts |  18 ++
 .../freescale/imx8mm-verdin-wifi-yavia.dts    |  18 ++
 .../dts/freescale/imx8mm-verdin-yavia.dtsi    | 155 ++++++++++++++++++
 4 files changed, 193 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-yavia.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-yavia.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-yavia.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index e0f6a7970f58..432f0c981eb8 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -75,8 +75,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7903.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7904.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-dev.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-nonwifi-yavia.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-wifi-dahlia.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-wifi-dev.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-verdin-wifi-yavia.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-bsh-smm-s2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-bsh-smm-s2pro.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-yavia.dts b/arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-yavia.dts
new file mode 100644
index 000000000000..c71825ecf2ea
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-yavia.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8mm-verdin.dtsi"
+#include "imx8mm-verdin-nonwifi.dtsi"
+#include "imx8mm-verdin-yavia.dtsi"
+
+/ {
+	model = "Toradex Verdin iMX8M Mini on Yavia Board";
+	compatible = "toradex,verdin-imx8mm-nonwifi-yavia",
+		     "toradex,verdin-imx8mm-nonwifi",
+		     "toradex,verdin-imx8mm",
+		     "fsl,imx8mm";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-yavia.dts b/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-yavia.dts
new file mode 100644
index 000000000000..fe39de9310d6
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-yavia.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8mm-verdin.dtsi"
+#include "imx8mm-verdin-wifi.dtsi"
+#include "imx8mm-verdin-yavia.dtsi"
+
+/ {
+	model = "Toradex Verdin iMX8M Mini WB on Yavia Board";
+	compatible = "toradex,verdin-imx8mm-wifi-yavia",
+		     "toradex,verdin-imx8mm-wifi",
+		     "toradex,verdin-imx8mm",
+		     "fsl,imx8mm";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-yavia.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin-yavia.dtsi
new file mode 100644
index 000000000000..d00253cf9a55
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-yavia.dtsi
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ */
+
+/ {
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
+		led-2 {
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
+/* Verdin SPI_1 */
+&ecspi2 {
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
+&fec1 {
+	status = "okay";
+};
+
+&gpio3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpios_ext_yavia>;
+};
+
+&hwmon_temp {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+/* Verdin I2C_1 */
+&i2c4 {
+	status = "okay";
+};
+
+/* Verdin PCIE_1 */
+&pcie0 {
+	status = "okay";
+};
+
+&pcie_phy {
+	status = "okay";
+};
+
+/* Verdin PWM_3_DSI */
+&pwm1 {
+	status = "okay";
+};
+
+/* Verdin PWM_1 */
+&pwm2 {
+	status = "okay";
+};
+
+/* Verdin PWM_2 */
+&pwm3 {
+	status = "okay";
+};
+
+/* Verdin UART_3 */
+&uart1 {
+	status = "okay";
+};
+
+/* Verdin UART_1 */
+&uart2 {
+	status = "okay";
+};
+
+/* Verdin UART_2 */
+&uart3 {
+	status = "okay";
+};
+
+/* Verdin USB_1 */
+&usbotg1 {
+	status = "okay";
+};
+
+/* Verdin USB_2 */
+&usbotg2 {
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
+			MX8MM_IOMUXC_NAND_ALE_GPIO3_IO0		0x106	/* SODIMM 52 */
+			MX8MM_IOMUXC_NAND_CE0_B_GPIO3_IO1	0x106	/* SODIMM 54 */
+			MX8MM_IOMUXC_NAND_DATA00_GPIO3_IO6	0x106	/* SODIMM 56 */
+			MX8MM_IOMUXC_NAND_DATA01_GPIO3_IO7	0x106	/* SODIMM 58 */
+			MX8MM_IOMUXC_NAND_DATA02_GPIO3_IO8	0x106	/* SODIMM 60 */
+			MX8MM_IOMUXC_NAND_DATA03_GPIO3_IO9	0x106	/* SODIMM 62 */
+		>;
+	};
+
+	pinctrl_gpios_ext_yavia: gpiosextyaviagrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_CE1_B_GPIO3_IO2	0x106	/* SODIMM 64 */
+			MX8MM_IOMUXC_NAND_DQS_GPIO3_IO14	0x106	/* SODIMM 66 */
+		>;
+	};
+};
-- 
2.39.0

