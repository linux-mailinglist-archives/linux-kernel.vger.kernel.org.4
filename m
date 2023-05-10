Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B3F6FDC90
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbjEJLVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjEJLVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:21:47 -0400
X-Greylist: delayed 180 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 04:21:42 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D57A1;
        Wed, 10 May 2023 04:21:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683717337; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=J+1EAuLJokg4C+dYGA0M6FoT04+N0uIEdidg6fxEqu7O8uAh9UfKzqHNZBLTCQzwFK
    XAOSmFBB/b8Z98K5hzEfzVFNEPAhIHl6RZy3fYjS4ckoYo/kWHAeGCYgoGNUyFtxUYR7
    0RNkNaY6750lkBz+JDMYx3Qq2w6yfvAVYD4fxCZB+3XrYNKR1llbnx3ORXI+6CfWcr0q
    jHNlq7hmN67LloB6d7379XRVv1Ve193lkYRAzv5yMhr+5jnMfUQFQLmRsA3MmtjgSMwY
    px9olVKdogHpkVLwd/R3DWAXd4trPjJPBjFgxzTNl4yRr6oVKiKG9yIcpAtXjmAhCIpD
    p26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1683717337;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7upIsiVeWndtxTPEBohl0p4xeRRcIer4RHSycw0Iylc=;
    b=qwIkRBmchJCasA1tSz9XLAnfTWktHBnjuCbvi4t9uEepKk+ILHFnwkZbydkP6Es2jw
    UU1FbYc78cFaP0fwT94KB7qtdmFf+RGkqA5w7zetDe9SOwaGsWUOhx4A59/f6SvS2Jup
    yr/xiYraPjO/ZKUK0QAUtwmgLVT2YoOIJbi5uFn4cT8SKaEeAv4F/Mk01bem1p719VvP
    D5OWddEBvi2HHXuLdW5dRFIY1aXSlTxFlHcbys56QO5fdZ30Hq9TqoG6yOxe2XUVYQYR
    J9khQqCKW1Ia81RKtzyuxNFV2+dujSabgxIPxvxN2WRmozKhW7iszvUyArXzziQM5zoa
    5HIw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1683717337;
    s=strato-dkim-0002; d=ict42.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7upIsiVeWndtxTPEBohl0p4xeRRcIer4RHSycw0Iylc=;
    b=KZKkrfyZwraiqMYEGOyo6/cW6cCCA0styhP/i8W0tUXDkBql+vpUUHum6eBF1cW2hy
    EQpHaLB8WcLNRmNQSpuhousw0HUQKpmBMmE4oqcwzCaDPcep4KR3IEzHRX0FXjLyjpKn
    BhNjxE6L5oeP6wFUZj33yWDhYrQBmBPbkEwagOmLX6V+zYpXdDKd98Rvk9HfE3bq1qo/
    XPcmbus/uJtC11Pt/yQ7YNhdwHVGromSUIcD0DDkmDPoiSSR2x02j+1CzqvDLC4CciPz
    i/cHiSYNR7TONHzxaJIvhka08VVovcUGd+d3DlilD5HUoEbOYU22RgZ4Xh8FN2ZNhyox
    1jpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1683717337;
    s=strato-dkim-0003; d=ict42.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7upIsiVeWndtxTPEBohl0p4xeRRcIer4RHSycw0Iylc=;
    b=+pqbGB/04rS3mmSZAC0A8ZucTCv6qiY+i6g+UueA4l4eUgB0hnGdpfOplKoHhkzlug
    EZOldJ7vJ5UcsVMzTOAg==
X-RZG-AUTH: ":IHkAYkmvNfSwjg/qSc4u8zZOVaURsoXe3UH2mQA0KglxDI1B7BeEcdPLARTmoNSwY8PK6ePqLwYCwAs="
Received: from debian-test.local.in-circuit.de
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id R2b608z4ABFaJXx
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 10 May 2023 13:15:36 +0200 (CEST)
From:   Ludwig Kormann <ludwig.kormann@ict42.de>
To:     samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andre.przywara@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] arm: dts: sunxi: Add ICnova A20 ADB4006 board
Date:   Wed, 10 May 2023 13:15:28 +0200
Message-Id: <20230510111528.2155582-3-ludwig.kormann@ict42.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230510111528.2155582-1-ludwig.kormann@ict42.de>
References: <20230510111528.2155582-1-ludwig.kormann@ict42.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Signed-off-by: Ludwig Kormann <ludwig.kormann@ict42.de>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/sun7i-a20-icnova-a20-adb4006.dts | 137 ++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi   |  62 ++++++++
 3 files changed, 200 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 59829fc90315..b4e10c379edf 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1335,6 +1335,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
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

