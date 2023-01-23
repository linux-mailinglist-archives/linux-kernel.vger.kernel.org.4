Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52728677F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjAWPUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjAWPUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:20:16 -0500
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B272A9AA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:19:43 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4P0tyJ19LyzMqX7l;
        Mon, 23 Jan 2023 16:17:44 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4P0tyH4DCczMqXNp;
        Mon, 23 Jan 2023 16:17:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1674487064;
        bh=+8gDwawrJxcJAlEtw0VJvo/ZnmBWx007KlWqpnE3LXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O3c+12628Ccw4QZNurat96yAYXcbcNVveMDhpQc40P/+ey22Bw9bhKMbHAU7Q9+ZF
         7gIHSW6cMKH7ELEN51m+lBXlAMz46z7zUgSOl3/z500OcZcAWUhMH923sDOEeAtPLI
         O6+Jj4Az2LZQ/r0Ml6hhkGQjNNoMEoA/dVOpObuU=
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
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: dts: imx8mm-verdin: Add yavia carrier board
Date:   Mon, 23 Jan 2023 16:17:33 +0100
Message-Id: <20230123151734.44184-3-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123151734.44184-1-dev@pschenker.ch>
References: <20230123151734.44184-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Changes in v2:
- Switch deprecated label in led node with color, function and
  function-enumerator

 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../freescale/imx8mm-verdin-nonwifi-yavia.dts |  18 ++
 .../freescale/imx8mm-verdin-wifi-yavia.dts    |  18 ++
 .../dts/freescale/imx8mm-verdin-yavia.dtsi    | 169 ++++++++++++++++++
 4 files changed, 207 insertions(+)
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
index 000000000000..1e28c78e381f
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-yavia.dtsi
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ */
+
+#include <dt-bindings/leds/common.h>
+
+/ {
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

