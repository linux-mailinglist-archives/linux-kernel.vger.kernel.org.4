Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1555BB042
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiIPPcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIPPcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:32:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2317915C3;
        Fri, 16 Sep 2022 08:32:32 -0700 (PDT)
Received: from localhost.localdomain (unknown [186.189.224.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: adalessandro)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8AB8B6601FAA;
        Fri, 16 Sep 2022 16:32:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663342350;
        bh=SDfL43uN7TS0CIFsjEl56ILa0pLZzGPF0gpzroZOqo4=;
        h=From:To:Cc:Subject:Date:From;
        b=dnioMijY8E0B3dPuLCOzUrpMDx9NKdoQemIUis94V24SH6whLLgLCmGJEiOe3b9gg
         p7jgGdjUHDiYORI7STU8m9Y++hQTCp1rAzzpftGE0k4xmCu85pCANlKyIF/e1890Bs
         P4FHFzwvqgaERnsfTZH2bQ0+BktwVqd620FQsEVsSeQYgddbSA7kPR2CslUPYf79ot
         9cca6llq0kZd/GdsfVymoyq4wxASSBxZ2uAU678Bg6Zr6q7oFHYBi0kymCA0lDmM+S
         M78yDTZRj64skUcYI6YD5lRaLptzsVtR7LfEDo6R7tDgqR8Npg5+pHvNmVGDvOa4Ry
         jbskuXoZ04ClQ==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
Cc:     ariel.dalessandro@collabora.com, arnd@arndb.de,
        f.fainelli@gmail.com, krzyszccf.kozlowski+dt@linaro.org,
        nsaenz@kernel.org, olof@lixom.net, robh+dt@kernel.org,
        soc@kernel.org, stefan.wahren@i2se.com, william.zhang@broadcom.com
Subject: [PATCH] ARM: dts: Add Raspberry Pi Compute Module 4 CANOPi Board
Date:   Fri, 16 Sep 2022 12:31:56 -0300
Message-Id: <20220916153156.30412-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Eclipse KUKSA CANOPi [0] is a baseboard for the Raspberry Compute
Module 4 (CM4). It contains a VIA VL805 4 Port USB controller and two
MCP251xFD based CAN-FD interfaces.

[0] https://github.com/boschresearch/kuksa.hardware

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts  | 139 ++++++++++++++++++
 arch/arm64/boot/dts/broadcom/Makefile         |   1 +
 .../dts/broadcom/bcm2711-rpi-cm4-canopi.dts   |   2 +
 4 files changed, 143 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-canopi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 05d8aef6e5d2..8930ab2c132c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -98,6 +98,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
 	bcm2837-rpi-zero-2-w.dtb \
 	bcm2711-rpi-400.dtb \
 	bcm2711-rpi-4-b.dtb \
+	bcm2711-rpi-cm4-canopi.dtb \
 	bcm2711-rpi-cm4-io.dtb \
 	bcm2835-rpi-zero.dtb \
 	bcm2835-rpi-zero-w.dtb
diff --git a/arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts b/arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts
new file mode 100644
index 000000000000..52ec5908883c
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2711-rpi-cm4-canopi.dts
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+#include "bcm2711-rpi-cm4.dtsi"
+
+/ {
+	model = "Raspberry Pi Compute Module 4 CANOPi Board";
+
+	clocks {
+		clk_mcp251xfd_osc: mcp251xfd-osc {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <20000000>;
+		};
+	};
+
+	leds {
+		led-act {
+			gpios = <&gpio 42 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-pwr {
+			label = "PWR";
+			gpios = <&expgpio 2 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+			linux,default-trigger = "default-on";
+		};
+	};
+};
+
+&ddc0 {
+	status = "okay";
+};
+
+&ddc1 {
+	status = "okay";
+};
+
+&hdmi0 {
+	status = "okay";
+};
+
+&hdmi1 {
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_gpio44>;
+	status = "okay";
+	clock-frequency = <100000>;
+
+	pcf85063a@51 {
+		compatible = "nxp,pcf85063a";
+		reg = <0x51>;
+	};
+};
+
+&pcie0 {
+	pci@0,0 {
+		device_type = "pci";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+
+		reg = <0 0 0 0 0>;
+
+		usb@0,0 {
+			reg = <0 0 0 0 0>;
+			resets = <&reset RASPBERRYPI_FIRMWARE_RESET_ID_USB>;
+		};
+	};
+};
+
+&pixelvalve0 {
+	status = "okay";
+};
+
+&pixelvalve1 {
+	status = "okay";
+};
+
+&pixelvalve2 {
+	status = "okay";
+};
+
+&pixelvalve4 {
+	status = "okay";
+};
+
+&spi {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_gpio7>;
+	cs-gpios = <&gpio 8 1>, <&gpio 7 1>;
+	dmas = <&dma 6>, <&dma 7>;
+	dma-names = "tx", "rx";
+
+	mcp251xfd0: mcp251xfd@0 {
+		compatible = "microchip,mcp251xfd";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcp251xfd0_pins>;
+		spi-max-frequency = <20000000>;
+		interrupt-parent = <&gpio>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&clk_mcp251xfd_osc>;
+	};
+
+	mcp251xfd1: mcp251xfd@1 {
+		compatible = "microchip,mcp251xfd";
+		reg = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcp251xfd1_pins>;
+		spi-max-frequency = <20000000>;
+		interrupt-parent = <&gpio>;
+		interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&clk_mcp251xfd_osc>;
+	};
+};
+
+&gpio {
+	mcp251xfd0_pins: mcp251xfd0_pins {
+		brcm,pins = <27>;
+		brcm,function = <BCM2835_FSEL_GPIO_IN>;
+	};
+
+	mcp251xfd1_pins: mcp251xfd1_pins {
+		brcm,pins = <22>;
+		brcm,function = <BCM2835_FSEL_GPIO_IN>;
+	};
+};
+
+&vc4 {
+	status = "okay";
+};
+
+&vec {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index e8584d3b698f..7cd88b8c0345 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
 			      bcm2711-rpi-4-b.dtb \
+			      bcm2711-rpi-cm4-canopi.dtb \
 			      bcm2711-rpi-cm4-io.dtb \
 			      bcm2837-rpi-3-a-plus.dtb \
 			      bcm2837-rpi-3-b.dtb \
diff --git a/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-canopi.dts b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-canopi.dts
new file mode 100644
index 000000000000..e9369aa0eb39
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-canopi.dts
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "arm/bcm2711-rpi-cm4-canopi.dts"
-- 
2.37.2

