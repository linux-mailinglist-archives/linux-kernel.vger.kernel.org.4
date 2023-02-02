Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F1B68830C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjBBPsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjBBPsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:48:25 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD38C14C;
        Thu,  2 Feb 2023 07:47:54 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.17]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MVw6g-1p8ABP1T4K-00X4vH;
 Thu, 02 Feb 2023 16:33:24 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-imx@nxp.com, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v6 10/10] arm64: dts: freescale: add apalis imx8 aka quadmax carrier board support
Date:   Thu,  2 Feb 2023 16:32:20 +0100
Message-Id: <20230202153221.197308-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230202153221.197308-1-marcel@ziswiler.com>
References: <20230202153221.197308-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4NooJNZyE6PmPVu+XzFlu2w+XHsZtLWbr8O46W1UgzYAfTJdFOZ
 IrIyaVj8/Ro2yXF2Sy5dmc4NRh9V9gPZCKU5KmQt4JxxAfw1JtgNHDUi2uPxkf1XwhyagtW
 WauM3FQrPLVGfSe/gkRJQkxhM6Je8V5bv4H6OerzfNlhDcTUxJ3Kd7ad+irQ8GRHZXYfteg
 rBipCfhxDRjv3ivHzCKmw==
UI-OutboundReport: notjunk:1;M01:P0:tMf3pWk1/i8=;LcIOf8Eg1CWeRiFyPlhkrtbgbCD
 Er+8493IPnQ0yq/ai63zhG4aT7hqoRmI/tYYqRbudNbHwbnJf4XD/QmN65ctT9QVE5Q8YqKsy
 2YSgCnLhoQPaa4hTJ0F9hc3xo3/KOOEKnsTUS99tsyQlj6VB9Pc50uRvWKI5lZn+TThPqjZAR
 YH3+rLdZ1XX7OpmvgTZtHo0TL73LfTCLssAxyOC4E4441gPKZVX1RV7fWlsPKFJjHS1fGYjXl
 fkol3zH3dQkUGNPfZRBK6/suD/PSXRrqarYpCOTbxQEKTW2Xt0kWp/kGOTbuFfBRwurl1zTWA
 UwfFpUGEhmNiOdLmIzm77R5fWpUd5FO273r2+JouYiwve+nouNTZ6FaIWoldebX5liP/K+Fw7
 GJomJkqF0dG0XPZio2IHxv7fEi7kXT+2xomb4MqwMYDDuT/CUFWjHGBnX31Mvj03xJkogxyS2
 3lhYtJC6noyhIPPRmAMBEdYCJDKdVYx/et9rIT0CvdjQdtTze0GiFDdQou0V4oIiPlp25VYn7
 cpANj7u05TXiKvc8M0dA8uaRKGgN23Azd93C0gRQZWRSkQf8H7JMsM3p6tyvbTDikwjmIbY4N
 ei96CEhtozW0sghXpJrhyuqTi6/cf6J/ikKzQyFuhEZOP7ua2GLnrKyx2mJfvxWbhMMOEshrN
 g2Uj8yKrABzItUYEgZBcCKJWRnHpCwDurRqcqMCavS4Qlgx0O5tE9JYCUk5lwOI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

The previous patch added the device tree to support Toradex Apalis
iMX8 [1] aka QuadMax a computer on module which can be used on
different carrier boards which this patch introduces.

The module consists of an NXP i.MX 8 family SoC (either i.MX 8QuadMax or
8QuadPlus), two PF8100 PMICs, a KSZ9131 Gigabit Ethernet PHY, 2, 4 or 8
GB of LPDDR4 RAM, an eMMC, an SGTL5000 analogue audio codec, an USB3503A
USB HSIC hub, an optional I2C EEPROM plus an optional Bluetooth/Wi-Fi
module.

Anything that is not self-contained on the module is disabled by
default.

The carrier board device trees contained in this patch include the
module's device tree and enable the supported peripherals of the
carrier board.

Some level of display functionality just landed upstream but requires
further integration/testing on our side. Therefore, currently only
basic console UART, eMMC and Ethernet functionality work fine.

As there is no i.MX 8QuadPlus device tree upstream those have been
dropped. However, apart from an error message during boot about it
failing to bring up the second Cortex-A72 core this boots fine on
QuadPlus' as well.

[1] https://www.toradex.com/computer-on-modules/apalis-arm-family/nxp-imx-8

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

(no changes since v5)

Changes in v5:
- Remove LVDS PWM support waiting for Liu's patches to land first.
- Remove bkl1_pwm functionality depending on the above.
- Squashing all Apalis iMX8 specific device tree patches. As outlined by
  Krzysztof reviewers may simply use b4 diff.

Changes in v4:
- Shorten subject.

Changes in v3:
- Only use V1.1 compatible for V1.1 module dtsi.
- Split patch into separate module and carrier boards parts as suggested
  by Shawn.
- Put reg after compatible as requested by Shawn.
- Move atmel_mxt_ts and rtc_i2c into module dtsi to save such
  duplications as suggested by Shawn.
- Change iomuxc pinctrl indent style as suggested by Shawn.
- Change led node names to the preferred first form as suggested by
  Shawn. While at it also add color (yikes), default-state and function
  properties and remove the deprecated label property.
- Put enable-active-high properties after the gpio ones as suggested by
  Shawn. Thanks!
- Remove adc node's vref-supply and accompanying reg_vref_1v8 regulator
  node.
- Rename gpio-hogs adherring to dt schema naming convention.

 arch/arm64/boot/dts/freescale/Makefile        |   5 +
 .../boot/dts/freescale/imx8-apalis-eval.dtsi  | 144 ++++++++++
 .../dts/freescale/imx8-apalis-ixora-v1.1.dtsi | 220 ++++++++++++++
 .../dts/freescale/imx8-apalis-ixora-v1.2.dtsi | 270 ++++++++++++++++++
 .../boot/dts/freescale/imx8qm-apalis-eval.dts |  16 ++
 .../freescale/imx8qm-apalis-ixora-v1.1.dts    |  16 ++
 .../dts/freescale/imx8qm-apalis-v1.1-eval.dts |  16 ++
 .../imx8qm-apalis-v1.1-ixora-v1.1.dts         |  16 ++
 .../imx8qm-apalis-v1.1-ixora-v1.2.dts         |  16 ++
 9 files changed, 719 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-eval.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-ixora-v1.1.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-ixora-v1.1.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-ixora-v1.2.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index ef6f364eaa18..c0d621d1d86e 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -112,6 +112,11 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mq-pico-pi.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-thor96.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-rmb3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-zest.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8qm-apalis-eval.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8qm-apalis-ixora-v1.1.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8qm-apalis-v1.1-eval.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8qm-apalis-v1.1-ixora-v1.1.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8qm-apalis-v1.1-ixora-v1.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qm-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-ai_ml.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-eval-v3.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
new file mode 100644
index 000000000000..685d4294f4f1
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/ {
+	aliases {
+		rtc0 = &rtc_i2c;
+		rtc1 = &rtc;
+	};
+
+	reg_usb_host_vbus: regulator-usb-host-vbus {
+		regulator-name = "VCC USBH2(ABCD) / USBH(3|4)";
+	};
+};
+
+&adc0 {
+	status = "okay";
+};
+
+&adc1 {
+	status = "okay";
+};
+
+/* TODO: Audio Mixer */
+
+/* TODO: Asynchronous Sample Rate Converter (ASRC) */
+
+/* TODO: Display Controller */
+
+/* TODO: DPU */
+
+/* Apalis ETH1 */
+&fec1 {
+	status = "okay";
+};
+
+/* Apalis CAN1 */
+&flexcan1 {
+	status = "okay";
+};
+
+/* Apalis CAN2 */
+&flexcan2 {
+	status = "okay";
+};
+
+/* TODO: GPU */
+
+/* Apalis I2C1 */
+&i2c2 {
+	status = "okay";
+
+	/* M41T0M6 real time clock on carrier board */
+	rtc_i2c: rtc@68 {
+		status = "okay";
+	};
+};
+
+/* Apalis I2C3 (CAM) */
+&i2c3 {
+	status = "okay";
+};
+
+/* Apalis SPI1 */
+&lpspi0 {
+	status = "okay";
+};
+
+/* Apalis SPI2 */
+&lpspi2 {
+	status = "okay";
+};
+
+/* Apalis UART3 */
+&lpuart0 {
+	status = "okay";
+};
+
+/* Apalis UART1 */
+&lpuart1 {
+	status = "okay";
+};
+
+/* Apalis UART4 */
+&lpuart2 {
+	status = "okay";
+};
+
+/* Apalis UART2 */
+&lpuart3 {
+	status = "okay";
+};
+
+/* Apalis PWM3, MXM3 pin 6 */
+&lsio_pwm0 {
+	status = "okay";
+};
+
+/* Apalis PWM4, MXM3 pin 8 */
+&lsio_pwm1 {
+	status = "okay";
+};
+
+/* Apalis PWM1, MXM3 pin 2 */
+&lsio_pwm2 {
+	status = "okay";
+};
+
+/* Apalis PWM2, MXM3 pin 4 */
+&lsio_pwm3 {
+	status = "okay";
+};
+
+/* TODO: Apalis PCIE1 */
+
+/* TODO: Apalis BKL1_PWM */
+
+/* TODO: Apalis DAP1 */
+
+/* TODO: Apalis Analogue Audio */
+
+/* TODO: Apalis SATA1 */
+
+/* TODO: Apalis SPDIF1 */
+
+/* TODO: Apalis USBH2, Apalis USBH3 and on-module Wi-Fi via on-module HSIC Hub */
+
+/* Apalis USBO1 */
+&usbotg1 {
+	status = "okay";
+};
+
+/* TODO: Apalis USBH4 SuperSpeed */
+
+/* Apalis MMC1 */
+&usdhc2 {
+	status = "okay";
+};
+
+/* Apalis SD1 */
+&usdhc3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
new file mode 100644
index 000000000000..987dcaa43343
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+#include <dt-bindings/leds/common.h>
+
+/ {
+	aliases {
+		rtc0 = &rtc_i2c;
+		rtc1 = &rtc;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds_ixora>;
+
+		/* LED_4_GREEN / MXM3_188 */
+		led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			default-state = "off";
+			function = LED_FUNCTION_STATUS;
+			gpios = <&lsio_gpio5 27 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* LED_4_RED / MXM3_178 */
+		led-2 {
+			color = <LED_COLOR_ID_RED>;
+			default-state = "off";
+			function = LED_FUNCTION_STATUS;
+			gpios = <&lsio_gpio5 29 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* LED_5_GREEN / MXM3_152 */
+		led-3 {
+			color = <LED_COLOR_ID_GREEN>;
+			default-state = "off";
+			function = LED_FUNCTION_STATUS;
+			gpios = <&lsio_gpio5 20 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* LED_5_RED / MXM3_156 */
+		led-4 {
+			color = <LED_COLOR_ID_RED>;
+			default-state = "off";
+			function = LED_FUNCTION_STATUS;
+			gpios = <&lsio_gpio5 21 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	reg_usb_host_vbus: regulator-usb-host-vbus {
+		regulator-name = "VCC_USBH(2|4)";
+	};
+};
+
+&adc0 {
+	status = "okay";
+};
+
+&adc1 {
+	status = "okay";
+};
+
+/* TODO: Audio Mixer */
+
+/* TODO: Asynchronous Sample Rate Converter (ASRC) */
+
+/* TODO: Display Controller */
+
+/* TODO: DPU */
+
+/* Apalis ETH1 */
+&fec1 {
+	status = "okay";
+};
+
+/* Apalis CAN1 */
+&flexcan1 {
+	status = "okay";
+};
+
+/* Apalis CAN2 */
+&flexcan2 {
+	status = "okay";
+};
+
+/* TODO: GPU */
+
+/* Apalis I2C1 */
+&i2c2 {
+	status = "okay";
+
+	/* M41T0M6 real time clock on carrier board */
+	rtc_i2c: rtc@68 {
+		status = "okay";
+	};
+};
+
+/* Apalis I2C3 (CAM) */
+&i2c3 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-0 = <&pinctrl_cam1_gpios>, <&pinctrl_dap1_gpios>,
+		    <&pinctrl_esai0_gpios>, <&pinctrl_fec2_gpios>,
+		    <&pinctrl_gpio3>, <&pinctrl_gpio4>, <&pinctrl_gpio_usbh_oc_n>,
+		    <&pinctrl_lpuart1ctrl>, <&pinctrl_lvds0_i2c0_gpio>,
+		    <&pinctrl_lvds1_i2c0_gpios>, <&pinctrl_mipi_dsi_0_1_en>,
+		    <&pinctrl_mipi_dsi1_gpios>, <&pinctrl_mlb_gpios>,
+		    <&pinctrl_qspi1a_gpios>, <&pinctrl_sata1_act>,
+		    <&pinctrl_sim0_gpios>, <&pinctrl_uart24_forceoff>,
+		    <&pinctrl_usdhc1_gpios>;
+
+	pinctrl_leds_ixora: ledsixoragrp {
+		fsl,pins = <IMX8QM_USDHC2_DATA1_LSIO_GPIO5_IO27	0x06000061>, /* LED_4_GREEN */
+			   <IMX8QM_USDHC2_DATA3_LSIO_GPIO5_IO29	0x06000061>, /* LED_4_RED */
+			   <IMX8QM_USDHC1_DATA5_LSIO_GPIO5_IO20	0x06000061>, /* LED_5_GREEN */
+			   <IMX8QM_USDHC1_DATA6_LSIO_GPIO5_IO21	0x06000061>; /* LED_5_RED */
+	};
+
+	pinctrl_uart24_forceoff: uart24forceoffgrp {
+		fsl,pins = <IMX8QM_USDHC2_CMD_LSIO_GPIO5_IO25		0x00000021>;
+	};
+};
+
+/* Apalis SPI1 */
+&lpspi0 {
+	status = "okay";
+};
+
+/* Apalis SPI2 */
+&lpspi2 {
+	status = "okay";
+};
+
+/* Apalis UART3 */
+&lpuart0 {
+	status = "okay";
+};
+
+/* Apalis UART1 */
+&lpuart1 {
+	status = "okay";
+};
+
+/* Apalis UART4 */
+&lpuart2 {
+	status = "okay";
+};
+
+/* Apalis UART2 */
+&lpuart3 {
+	status = "okay";
+};
+
+&lsio_gpio5 {
+	ngpios = <32>;
+	gpio-line-names = "gpio5-00", "gpio5-01", "gpio5-02", "gpio5-03",
+			  "gpio5-04", "gpio5-05", "gpio5-06", "gpio5-07",
+			  "gpio5-08", "gpio5-09", "gpio5-10", "gpio5-11",
+			  "gpio5-12", "gpio5-13", "gpio5-14", "gpio5-15",
+			  "gpio5-16", "gpio5-17", "gpio5-18", "gpio5-19",
+			  "LED-5-GREEN", "LED-5-RED", "gpio5-22", "gpio5-23",
+			  "gpio5-24", "UART24-FORCEOFF", "gpio5-26",
+			  "LED-4-GREEN", "gpio5-28", "LED-4-RED", "gpio5-30",
+			  "gpio5-31";
+};
+
+/* Apalis PWM3, MXM3 pin 6 */
+&lsio_pwm0 {
+	status = "okay";
+};
+
+/* Apalis PWM4, MXM3 pin 8 */
+&lsio_pwm1 {
+	status = "okay";
+};
+
+/* Apalis PWM1, MXM3 pin 2 */
+&lsio_pwm2 {
+	status = "okay";
+};
+
+/* Apalis PWM2, MXM3 pin 4 */
+&lsio_pwm3 {
+	status = "okay";
+};
+
+/* TODO: Apalis PCIE1 */
+
+/* TODO: Apalis BKL1_PWM */
+
+/* TODO: Apalis DAP1 */
+
+/* TODO: Analogue Audio */
+
+/* TODO: Apalis SATA1 */
+
+/* TODO: Apalis SPDIF1 */
+
+/* TODO: Apalis USBH2, Apalis USBH3 and on-module Wi-Fi via on-module HSIC Hub */
+
+/* Apalis USBO1 */
+&usbotg1 {
+	status = "okay";
+};
+
+/* TODO: Apalis USBH4 SuperSpeed */
+
+/* Apalis MMC1 */
+&usdhc2 {
+	bus-width = <4>;
+	pinctrl-0 = <&pinctrl_usdhc2_4bit>, <&pinctrl_mmc1_cd>;
+	pinctrl-1 = <&pinctrl_usdhc2_4bit_100mhz>, <&pinctrl_mmc1_cd>;
+	pinctrl-2 = <&pinctrl_usdhc2_4bit_200mhz>, <&pinctrl_mmc1_cd>;
+	pinctrl-3 = <&pinctrl_usdhc2_4bit_sleep>, <&pinctrl_mmc1_cd_sleep>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
new file mode 100644
index 000000000000..e39ee4970816
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+#include <dt-bindings/leds/common.h>
+
+/ {
+	aliases {
+		rtc0 = &rtc_i2c;
+		rtc1 = &rtc;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds_ixora>;
+
+		/* LED_4_GREEN / MXM3_188 */
+		led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			default-state = "off";
+			function = LED_FUNCTION_STATUS;
+			gpios = <&lsio_gpio5 27 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* LED_4_RED / MXM3_178 */
+		led-2 {
+			color = <LED_COLOR_ID_RED>;
+			default-state = "off";
+			function = LED_FUNCTION_STATUS;
+			gpios = <&lsio_gpio5 29 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* LED_5_GREEN / MXM3_152 */
+		led-3 {
+			color = <LED_COLOR_ID_GREEN>;
+			default-state = "off";
+			function = LED_FUNCTION_STATUS;
+			gpios = <&lsio_gpio5 20 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* LED_5_RED / MXM3_156 */
+		led-4 {
+			color = <LED_COLOR_ID_RED>;
+			default-state = "off";
+			function = LED_FUNCTION_STATUS;
+			gpios = <&lsio_gpio5 21 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	reg_3v3_vmmc: regulator-3v3-vmmc {
+		compatible = "regulator-fixed";
+		/* MMC1_PWR_CTRL */
+		gpio = <&lsio_gpio5 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_3v3_vmmc>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3v3_vmmc";
+	};
+
+	reg_can1_supply: regulator-can1-supply {
+		compatible = "regulator-fixed";
+		gpio = <&lsio_gpio5 22 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_can1_power>;
+		regulator-name = "can1_supply";
+	};
+
+	reg_can2_supply: regulator-can2-supply {
+		compatible = "regulator-fixed";
+		gpio = <&lsio_gpio2 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sata1_act>;
+		regulator-name = "can2_supply";
+	};
+
+	reg_usb_host_vbus: regulator-usb-host-vbus {
+		regulator-name = "VCC_USBH(2|4)";
+	};
+};
+
+&adc0 {
+	status = "okay";
+};
+
+&adc1 {
+	status = "okay";
+};
+
+/* TODO: Audio Mixer */
+
+/* TODO: Asynchronous Sample Rate Converter (ASRC) */
+
+/* TODO: Display Controller */
+
+/* TODO: DPU */
+
+/* Apalis ETH1 */
+&fec1 {
+	status = "okay";
+};
+
+/* Apalis CAN1 */
+&flexcan1 {
+	xceiver-supply = <&reg_can1_supply>;
+	status = "okay";
+};
+
+/* Apalis CAN2 */
+&flexcan2 {
+	xceiver-supply = <&reg_can2_supply>;
+	status = "okay";
+};
+
+/* TODO: GPU */
+
+/* Apalis I2C1 */
+&i2c2 {
+	status = "okay";
+
+	eeprom: eeprom@50 {
+		compatible = "atmel,24c02";
+		pagesize = <16>;
+		reg = <0x50>;
+	};
+
+	/* M41T0M6 real time clock on carrier board */
+	rtc_i2c: rtc@68 {
+		status = "okay";
+	};
+};
+
+/* Apalis I2C3 (CAM) */
+&i2c3 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-0 = <&pinctrl_cam1_gpios>, <&pinctrl_dap1_gpios>,
+		    <&pinctrl_esai0_gpios>, <&pinctrl_fec2_gpios>,
+		    <&pinctrl_gpio3>, <&pinctrl_gpio4>, <&pinctrl_gpio_usbh_oc_n>,
+		    <&pinctrl_lpuart1ctrl>, <&pinctrl_lvds0_i2c0_gpio>,
+		    <&pinctrl_lvds1_i2c0_gpios>, <&pinctrl_mipi_dsi_0_1_en>,
+		    <&pinctrl_mipi_dsi1_gpios>, <&pinctrl_mlb_gpios>,
+		    <&pinctrl_qspi1a_gpios>, <&pinctrl_sim0_gpios>,
+		    <&pinctrl_uart24_forceoff>, <&pinctrl_usdhc1_gpios>;
+
+	/* PMIC MMC1 power-switch */
+	pinctrl_enable_3v3_vmmc: enable3v3vmmcgrp {
+		fsl,pins = <IMX8QM_USDHC1_DATA4_LSIO_GPIO5_IO19	0x00000021>; /* MXM3_148, PMIC */
+	};
+
+	/* FlexCAN PMIC */
+	pinctrl_enable_can1_power: enablecan1powergrp {
+		fsl,pins = <IMX8QM_USDHC1_DATA7_LSIO_GPIO5_IO22	0x00000021>; /* MXM3_158, PMIC */
+	};
+
+	pinctrl_leds_ixora: ledsixoragrp {
+		fsl,pins = <IMX8QM_USDHC2_DATA1_LSIO_GPIO5_IO27	0x06000061>, /* LED_4_GREEN */
+			   <IMX8QM_USDHC2_DATA3_LSIO_GPIO5_IO29	0x06000061>, /* LED_4_RED */
+			   <IMX8QM_USDHC1_DATA5_LSIO_GPIO5_IO20	0x06000061>, /* LED_5_GREEN */
+			   <IMX8QM_USDHC1_DATA6_LSIO_GPIO5_IO21	0x06000061>; /* LED_5_RED */
+	};
+
+	pinctrl_uart24_forceoff: uart24forceoffgrp {
+		fsl,pins = <IMX8QM_USDHC2_CMD_LSIO_GPIO5_IO25		0x00000021>;
+	};
+};
+
+/* Apalis SPI1 */
+&lpspi0 {
+	status = "okay";
+};
+
+/* Apalis SPI2 */
+&lpspi2 {
+	status = "okay";
+};
+
+/* Apalis UART3 */
+&lpuart0 {
+	status = "okay";
+};
+
+/* Apalis UART1 */
+&lpuart1 {
+	status = "okay";
+};
+
+/* Apalis UART4 */
+&lpuart2 {
+	status = "okay";
+};
+
+/* Apalis UART2 */
+&lpuart3 {
+	status = "okay";
+};
+
+&lsio_gpio5 {
+	ngpios = <32>;
+	gpio-line-names = "gpio5-00", "gpio5-01", "gpio5-02", "gpio5-03",
+			  "gpio5-04", "gpio5-05", "gpio5-06", "gpio5-07",
+			  "gpio5-08", "gpio5-09", "gpio5-10", "gpio5-11",
+			  "gpio5-12", "gpio5-13", "gpio5-14", "gpio5-15",
+			  "gpio5-16", "gpio5-17", "gpio5-18", "gpio5-19",
+			  "LED-5-GREEN", "LED-5-RED", "gpio5-22", "gpio5-23",
+			  "gpio5-24", "UART24-FORCEOFF", "gpio5-26",
+			  "LED-4-GREEN", "gpio5-28", "LED-4-RED", "gpio5-30",
+			  "gpio5-31";
+};
+
+/* Apalis PWM3, MXM3 pin 6 */
+&lsio_pwm0 {
+	status = "okay";
+};
+
+/* Apalis PWM4, MXM3 pin 8 */
+&lsio_pwm1 {
+	status = "okay";
+};
+
+/* Apalis PWM1, MXM3 pin 2 */
+&lsio_pwm2 {
+	status = "okay";
+};
+
+/* Apalis PWM2, MXM3 pin 4 */
+&lsio_pwm3 {
+	status = "okay";
+};
+
+/* TODO: Apalis PCIE1 */
+
+/* TODO: Apalis BKL1_PWM */
+
+/* TODO: Apalis DAP1 */
+
+/* TODO: Analogue Audio */
+
+/* TODO: Apalis SATA1 */
+
+/* TODO: Apalis SPDIF1 */
+
+/* TODO: Apalis USBH2, Apalis USBH3 and on-module Wi-Fi via on-module HSIC Hub */
+
+/* Apalis USBO1 */
+&usbotg1 {
+	status = "okay";
+};
+
+/* TODO: Apalis USBH4 SuperSpeed */
+
+/* Apalis MMC1 */
+&usdhc2 {
+	bus-width = <4>;
+	cap-power-off-card;
+	/delete-property/ no-1-8-v;
+	pinctrl-0 = <&pinctrl_usdhc2_4bit>, <&pinctrl_mmc1_cd>;
+	pinctrl-1 = <&pinctrl_usdhc2_4bit_100mhz>, <&pinctrl_mmc1_cd>;
+	pinctrl-2 = <&pinctrl_usdhc2_4bit_200mhz>, <&pinctrl_mmc1_cd>;
+	pinctrl-3 = <&pinctrl_usdhc2_4bit_sleep>, <&pinctrl_mmc1_cd_sleep>;
+	vmmc-supply = <&reg_3v3_vmmc>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-apalis-eval.dts b/arch/arm64/boot/dts/freescale/imx8qm-apalis-eval.dts
new file mode 100644
index 000000000000..5ab0921eb599
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-apalis-eval.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8qm-apalis.dtsi"
+#include "imx8-apalis-eval.dtsi"
+
+/ {
+	model = "Toradex Apalis iMX8QM/QP on Apalis Evaluation Board";
+	compatible = "toradex,apalis-imx8-eval",
+		     "toradex,apalis-imx8",
+		     "fsl,imx8qm";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-apalis-ixora-v1.1.dts b/arch/arm64/boot/dts/freescale/imx8qm-apalis-ixora-v1.1.dts
new file mode 100644
index 000000000000..68ce58dc7102
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-apalis-ixora-v1.1.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8qm-apalis.dtsi"
+#include "imx8-apalis-ixora-v1.1.dtsi"
+
+/ {
+	model = "Toradex Apalis iMX8QM/QP on Apalis Ixora V1.1 Carrier Board";
+	compatible = "toradex,apalis-imx8-ixora-v1.1",
+		     "toradex,apalis-imx8",
+		     "fsl,imx8qm";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval.dts b/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval.dts
new file mode 100644
index 000000000000..c8ff75831556
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8qm-apalis-v1.1.dtsi"
+#include "imx8-apalis-eval.dtsi"
+
+/ {
+	model = "Toradex Apalis iMX8QM V1.1 on Apalis Evaluation Board";
+	compatible = "toradex,apalis-imx8-v1.1-eval",
+		     "toradex,apalis-imx8-v1.1",
+		     "fsl,imx8qm";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-ixora-v1.1.dts b/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-ixora-v1.1.dts
new file mode 100644
index 000000000000..ad7f644968fa
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-ixora-v1.1.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8qm-apalis-v1.1.dtsi"
+#include "imx8-apalis-ixora-v1.1.dtsi"
+
+/ {
+	model = "Toradex Apalis iMX8QM V1.1 on Apalis Ixora V1.1 Carrier Board";
+	compatible = "toradex,apalis-imx8-v1.1-ixora-v1.1",
+		     "toradex,apalis-imx8-v1.1",
+		     "fsl,imx8qm";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-ixora-v1.2.dts b/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-ixora-v1.2.dts
new file mode 100644
index 000000000000..3b2e8c93b846
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-ixora-v1.2.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2022 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8qm-apalis-v1.1.dtsi"
+#include "imx8-apalis-ixora-v1.2.dtsi"
+
+/ {
+	model = "Toradex Apalis iMX8QM V1.1 on Apalis Ixora V1.2 Carrier Board";
+	compatible = "toradex,apalis-imx8-v1.1-ixora-v1.2",
+		     "toradex,apalis-imx8-v1.1",
+		     "fsl,imx8qm";
+};
-- 
2.36.1

