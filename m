Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E206E901E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjDTK0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbjDTKZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:25:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AE010E;
        Thu, 20 Apr 2023 03:24:50 -0700 (PDT)
Received: from debian-test.local.in-circuit.de ([84.160.205.173]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MkHd3-1qZXrS352n-00kjbY; Thu, 20 Apr 2023 12:24:23 +0200
From:   Ludwig Kormann <ludwig.kormann@in-circuit.de>
To:     samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andre.przywara@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] arm: dts: sunxi: Add ICnova A20 ADB4006 board
Date:   Thu, 20 Apr 2023 12:24:09 +0200
Message-Id: <20230420102409.1394618-3-ludwig.kormann@in-circuit.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230420102409.1394618-1-ludwig.kormann@in-circuit.de>
References: <20230420102409.1394618-1-ludwig.kormann@in-circuit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JbOfNKJY/XEtp6xkqjP477VwoJD1Qd9/OAA6HP5NHPxfW9FyPkG
 SCU38rRyPfux0sEwYxcfMDBjKKYiUAD0r4BA4il1i9vhUfijqGBADEbzsCvDQ2rmqCG3H8+
 cQbuZvQmAK5GFW4q6eRPgpMVfAQ2aKE1vWDzJvYQ5uLnPtXkUxW7s0kEKn2c6Xhi7LgM1VX
 BHOA5ryj/1sDCo9msAMSw==
UI-OutboundReport: notjunk:1;M01:P0:AVn3Uaprw/4=;j3zIXB8WhXc/d/QsB7681u99fpJ
 nbQ0YeJXJYQZcdkBRklk/nQaV2dR+qY65HzmF4VVcZF1XarM1uqHrvv6l+GKu5Wvm7nQHW1DE
 J9zb2rDUWiUHiMamot6kPS3jhwqcWueB5nYKGZRDwxcNMT041PRdOd+s5cyBeZxVPAxS3MF8a
 oroSCv3M2tVjrD98qAAlM7a8WJPliFP2o2BFM2Z4DMZe5JJmdzx5RduXO96YIqCxyXyLHwnoQ
 8138yTvCb/4CK5YXXbYlCbki4x4Q59r6FgyHrQugtWA/1G4XA9Oc3c209kU85N6GZhTNKjc88
 fRQ+gB+qUAstFJPzakvs3TQzX+7113F4EuE/YU2Fy7YrxmXzWht+smApvhIowvmVXeocJFR05
 ZnPAbD00HI7i60v3rylbhc4CBMXBLnOn6/Pj8DArjUkB+Ul58aCgjyPnxN4/u0JU9CV81QlDl
 wrmfjnhFm7GhR+irWoSzE2QbVXJd2vRfC3nLAFQDmeiwMO3GX6q1JFRlUxWVkZrgTDB1Exsf4
 KaraBHnR/AWP5VUKWCn8BFVfQtRUZMt5jRn2F2dLdHOfs7KIQBgjLxor5JhM2s2kp1fXWiL5t
 lDVBhZw6RTUmmDn80onzL6xS0G2jRUE62On/fBghB3y5XZ5NrKAawt26azHVWKq+6DNnqisq6
 xoTOA4KUO4QR5EGeKmyuPlA2/xesIlNyQ5NrMewnBA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add board support for ICnova A20 SomPi compute module on
ICnova ADB4006 development board.

Specification:
SoM
- Processor: Allwinner A20 Cortex-A7 Dual Core at 1GHz
- 512MB DDR3 RAM
- Fast Ethernet (Phy: Realtek RTL8201CP)
ADB4006
- I2C
- 2x USB 2.0
- 1x Fast Ethernet port
- 1x SATA
- 2x buttons (PWRON, Boot)
- 2x LEDS
- serial console
- HDMI
- µSD-Card slot
- Audio Line-In / Line-Out
- GPIO pinheaders

https://wiki.in-circuit.de/index.php5?title=ICnova_ADB4006
https://wiki.in-circuit.de/index.php5?title=ICnova_A20_SODIMM

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Ludwig Kormann <ludwig.kormann@in-circuit.de>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/sun7i-a20-icnova-a20-adb4006.dts | 137 ++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi   |  62 ++++++++
 3 files changed, 200 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3cc32722c394..b6b408417261 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1321,6 +1321,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
 	sun7i-a20-hummingbird.dtb \
 	sun7i-a20-itead-ibox.dtb \
 	sun7i-a20-i12-tvbox.dtb \
+	sun7i-a20-icnova-a20-adb4006.dtb \
 	sun7i-a20-icnova-swac.dtb \
 	sun7i-a20-lamobo-r1.dtb \
 	sun7i-a20-linutronix-testbox-v2.dtb \
diff --git a/arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts b/arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts
new file mode 100644
index 000000000000..577ead1d02a0
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// Copyright (C) 2023 In-Circuit GmbH
+
+/dts-v1/;
+
+#include "sun7i-a20-icnova-a20.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "In-Circuit ICnova A20 ADB4006";
+	compatible = "incircuit,icnova-a20-adb4006", "incircuit,icnova-a20",
+		     "allwinner,sun7i-a20";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_YELLOW>;
+			gpios = <&pio 7 21 GPIO_ACTIVE_HIGH>; /* PH21 */
+			default-state = "on";
+		};
+
+		led-1 {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>; /* PH20 */
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&ahci {
+	target-supply = <&reg_ahci_5v>;
+	status = "okay";
+};
+
+&codec {
+	status = "okay";
+};
+
+&de {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&otg_sram {
+	status = "okay";
+};
+
+&reg_ahci_5v {
+	status = "okay";
+};
+
+&ac_power_supply {
+	status = "okay";
+};
+
+&reg_usb1_vbus {
+	status = "okay";
+};
+
+&reg_usb2_vbus {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
+	usb0_vbus_det-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi b/arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi
new file mode 100644
index 000000000000..46616c6bc899
--- /dev/null
+++ b/arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+// Copyright (C) 2023 In-Circuit GmbH
+
+#include "sun7i-a20.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_mii_pins>;
+	phy-handle = <&phy1>;
+	phy-mode = "mii";
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	axp209: pmic@34 {
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&gmac_mdio {
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+	};
+};
+
+#include "axp209.dtsi"
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
-- 
2.30.2

