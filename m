Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCE26FF49E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbjEKOio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238481AbjEKOhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:37:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928F23C01;
        Thu, 11 May 2023 07:37:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC9CF64E47;
        Thu, 11 May 2023 14:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1DCC433EF;
        Thu, 11 May 2023 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683815820;
        bh=T/CckZr82nlt771/HAuYeof1LyMg5yJtbjhb7nr4yZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDILcVfd1SXKlY3zkcAK4fsTpGbKdTn34hJAsDk/UH2vq9s2QlhVluKOf79ywteZ8
         II8ZpyJ2O6qtMYWU9sRO3Yy4b/VJpabZ3MA6dirqhfH+NZDkshXXI3R57EINmqFsUc
         ncY5weLKG1wDT2z1OH9jznj9pnDbnhj+UieJ/hq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.111
Date:   Thu, 11 May 2023 23:36:43 +0900
Message-Id: <2023051142-visitor-chokehold-078b@gregkh>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023051142-washstand-hacking-f1ce@gregkh>
References: <2023051142-washstand-hacking-f1ce@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 781af18b5984..4d0a49688376 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 110
+SUBLEVEL = 111
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 3923b38e798d..bb5e00b36d8d 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -609,6 +609,22 @@ &i2c3 {
 	clock-frequency = <100000>;
 };
 
+&mcspi1 {
+	status = "disabled";
+};
+
+&mcspi2 {
+	status = "disabled";
+};
+
+&mcspi3 {
+	status = "disabled";
+};
+
+&mcspi4 {
+	status = "disabled";
+};
+
 &usb_otg_hs {
 	interface-type = <0>;
 	usb-phy = <&usb2_phy>;
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 08bc5f46649d..9dcf308b3ad4 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -424,8 +424,8 @@ pcie0: pci@40000000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x40200000 0x40200000 0 0x00100000>,
-				 <0x82000000 0 0x40300000 0x40300000 0 0x00d00000>;
+			ranges = <0x81000000 0x0 0x00000000 0x40200000 0x0 0x00100000>,
+				 <0x82000000 0x0 0x40300000 0x40300000 0x0 0x00d00000>;
 
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 4139d3817bd6..f4139411c41e 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -808,8 +808,8 @@ pcie0: pci@1b500000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00100000   /* downstream I/O */
-				  0x82000000 0 0x08000000 0x08000000 0 0x07e00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x0fe00000 0x0 0x00010000   /* I/O */
+				  0x82000000 0x0 0x08000000 0x08000000 0x0 0x07e00000>; /* MEM */
 
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
@@ -859,8 +859,8 @@ pcie1: pci@1b700000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00100000   /* downstream I/O */
-				  0x82000000 0 0x2e000000 0x2e000000 0 0x03e00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x31e00000 0x0 0x00010000   /* I/O */
+				  0x82000000 0x0 0x2e000000 0x2e000000 0x0 0x03e00000>; /* MEM */
 
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
@@ -910,8 +910,8 @@ pcie2: pci@1b900000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00100000   /* downstream I/O */
-				  0x82000000 0 0x32000000 0x32000000 0 0x03e00000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x35e00000 0x0 0x00010000   /* I/O */
+				  0x82000000 0x0 0x32000000 0x32000000 0x0 0x03e00000>; /* MEM */
 
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 11eae3e3a944..bce0a1255453 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -6,6 +6,6 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
 			      bcm2837-rpi-3-b-plus.dtb \
 			      bcm2837-rpi-cm3-io3.dtb
 
-subdir-y	+= bcm4908
+subdir-y	+= bcmbca
 subdir-y	+= northstar2
 subdir-y	+= stingray
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/Makefile b/arch/arm64/boot/dts/broadcom/bcm4908/Makefile
deleted file mode 100644
index cc75854519ac..000000000000
--- a/arch/arm64/boot/dts/broadcom/bcm4908/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_BCM4908) += bcm4906-netgear-r8000p.dtb
-dtb-$(CONFIG_ARCH_BCM4908) += bcm4906-tplink-archer-c2300-v1.dtb
-dtb-$(CONFIG_ARCH_BCM4908) += bcm4908-asus-gt-ac5300.dtb
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
deleted file mode 100644
index 2dd028438c22..000000000000
--- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
+++ /dev/null
@@ -1,157 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/leds/common.h>
-
-#include "bcm4906.dtsi"
-
-/ {
-	compatible = "netgear,r8000p", "brcm,bcm4906", "brcm,bcm4908";
-	model = "Netgear R8000P";
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x00 0x00 0x00 0x20000000>;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led-power-white {
-			function = LED_FUNCTION_POWER;
-			color = <LED_COLOR_ID_WHITE>;
-			gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
-		};
-
-		led-power-amber {
-			function = LED_FUNCTION_POWER;
-			color = <LED_COLOR_ID_AMBER>;
-			gpios = <&gpio0 9 GPIO_ACTIVE_LOW>;
-		};
-
-		led-wps {
-			function = LED_FUNCTION_WPS;
-			color = <LED_COLOR_ID_WHITE>;
-			gpios = <&gpio0 10 GPIO_ACTIVE_LOW>;
-		};
-
-		led-2ghz {
-			function = "2ghz";
-			color = <LED_COLOR_ID_WHITE>;
-			gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
-		};
-
-		led-5ghz-1 {
-			function = "5ghz-1";
-			color = <LED_COLOR_ID_WHITE>;
-			gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
-		};
-
-		led-5ghz-2 {
-			function = "5ghz-2";
-			color = <LED_COLOR_ID_WHITE>;
-			gpios = <&gpio0 16 GPIO_ACTIVE_LOW>;
-		};
-
-		led-usb2 {
-			function = "usb2";
-			color = <LED_COLOR_ID_WHITE>;
-			gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
-		};
-
-		led-usb3 {
-			function = "usb3";
-			color = <LED_COLOR_ID_WHITE>;
-			gpios = <&gpio0 18 GPIO_ACTIVE_LOW>;
-		};
-
-		led-wifi {
-			function = "wifi";
-			color = <LED_COLOR_ID_WHITE>;
-			gpios = <&gpio0 56 GPIO_ACTIVE_LOW>;
-		};
-	};
-};
-
-&enet {
-	nvmem-cells = <&base_mac_addr>;
-	nvmem-cell-names = "mac-address";
-};
-
-&usb_phy {
-	brcm,ioc = <1>;
-	status = "okay";
-};
-
-&ehci {
-	status = "okay";
-};
-
-&ohci {
-	status = "okay";
-};
-
-&xhci {
-	status = "okay";
-};
-
-&ports {
-	port@0 {
-		label = "lan4";
-	};
-
-	port@1 {
-		label = "lan3";
-	};
-
-	port@2 {
-		label = "lan2";
-	};
-
-	port@3 {
-		label = "lan1";
-	};
-
-	port@7 {
-		reg = <7>;
-		phy-mode = "internal";
-		phy-handle = <&phy12>;
-		label = "wan";
-	};
-};
-
-&nandcs {
-	nand-ecc-strength = <4>;
-	nand-ecc-step-size = <512>;
-	nand-on-flash-bbt;
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	partitions {
-		compatible = "fixed-partitions";
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		partition@0 {
-			compatible = "nvmem-cells";
-			label = "cferom";
-			reg = <0x0 0x100000>;
-
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x0 0x100000>;
-
-			base_mac_addr: mac@106a0 {
-				reg = <0x106a0 0x6>;
-			};
-		};
-
-		partition@100000 {
-			compatible = "brcm,bcm4908-firmware";
-			label = "firmware";
-			reg = <0x100000 0x4400000>;
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
deleted file mode 100644
index b63eefab48bd..000000000000
--- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
+++ /dev/null
@@ -1,182 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/leds/common.h>
-
-#include "bcm4906.dtsi"
-
-/ {
-	compatible = "tplink,archer-c2300-v1", "brcm,bcm4906", "brcm,bcm4908";
-	model = "TP-Link Archer C2300 V1";
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x00 0x00 0x00 0x20000000>;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led-power {
-			function = LED_FUNCTION_POWER;
-			color = <LED_COLOR_ID_BLUE>;
-			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
-		};
-
-		led-2ghz {
-			function = "2ghz";
-			color = <LED_COLOR_ID_BLUE>;
-			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
-		};
-
-		led-5ghz {
-			function = "5ghz";
-			color = <LED_COLOR_ID_BLUE>;
-			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
-		};
-
-		led-wan-amber {
-			function = LED_FUNCTION_WAN;
-			color = <LED_COLOR_ID_AMBER>;
-			gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
-		};
-
-		led-wan-blue {
-			function = LED_FUNCTION_WAN;
-			color = <LED_COLOR_ID_BLUE>;
-			gpios = <&gpio0 10 GPIO_ACTIVE_LOW>;
-		};
-
-		led-lan {
-			function = LED_FUNCTION_LAN;
-			color = <LED_COLOR_ID_BLUE>;
-			gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
-		};
-
-		led-wps {
-			function = LED_FUNCTION_WPS;
-			color = <LED_COLOR_ID_BLUE>;
-			gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
-		};
-
-		led-usb2 {
-			function = "usb2";
-			color = <LED_COLOR_ID_BLUE>;
-			gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
-		};
-
-		led-usb3 {
-			function = "usbd3";
-			color = <LED_COLOR_ID_BLUE>;
-			gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
-		};
-
-		led-brightness {
-			function = LED_FUNCTION_BACKLIGHT;
-			color = <LED_COLOR_ID_WHITE>;
-			gpios = <&gpio0 19 GPIO_ACTIVE_LOW>;
-		};
-	};
-
-	gpio-keys-polled {
-		compatible = "gpio-keys-polled";
-		poll-interval = <100>;
-
-		brightness {
-			label = "LEDs";
-			linux,code = <KEY_BRIGHTNESS_ZERO>;
-			gpios = <&gpio0 18 GPIO_ACTIVE_LOW>;
-		};
-
-		wps {
-			label = "WPS";
-			linux,code = <KEY_WPS_BUTTON>;
-			gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
-		};
-
-		wifi {
-			label = "WiFi";
-			linux,code = <KEY_RFKILL>;
-			gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
-		};
-
-		restart {
-			label = "Reset";
-			linux,code = <KEY_RESTART>;
-			gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
-		};
-	};
-};
-
-&usb_phy {
-	brcm,ioc = <1>;
-	status = "okay";
-};
-
-&ehci {
-	status = "okay";
-};
-
-&ohci {
-	status = "okay";
-};
-
-&xhci {
-	status = "okay";
-};
-
-&ports {
-	port@0 {
-		label = "lan4";
-	};
-
-	port@1 {
-		label = "lan3";
-	};
-
-	port@2 {
-		label = "lan2";
-	};
-
-	port@3 {
-		label = "lan1";
-	};
-
-	port@7 {
-		reg = <7>;
-		phy-mode = "internal";
-		phy-handle = <&phy12>;
-		label = "wan";
-	};
-};
-
-&nandcs {
-	nand-ecc-strength = <4>;
-	nand-ecc-step-size = <512>;
-	nand-on-flash-bbt;
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	partitions {
-		compatible = "brcm,bcm4908-partitions";
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		partition@0 {
-			label = "cferom";
-			reg = <0x0 0x100000>;
-		};
-
-		partition@100000 {
-			compatible = "brcm,bcm4908-firmware";
-			reg = <0x100000 0x3900000>;
-		};
-
-		partition@5800000 {
-			compatible = "brcm,bcm4908-firmware";
-			reg = <0x3a00000 0x3900000>;
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906.dtsi b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906.dtsi
deleted file mode 100644
index d084c33d5ca8..000000000000
--- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906.dtsi
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-
-#include "bcm4908.dtsi"
-
-/ {
-	cpus {
-		/delete-node/ cpu@2;
-
-		/delete-node/ cpu@3;
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
-	};
-
-	pmu {
-		compatible = "arm,cortex-a53-pmu";
-		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&cpu0>, <&cpu1>;
-	};
-};
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
deleted file mode 100644
index 169fbb7cfd34..000000000000
--- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
+++ /dev/null
@@ -1,159 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-
-#include "bcm4908.dtsi"
-
-/ {
-	compatible = "asus,gt-ac5300", "brcm,bcm4908";
-	model = "Asus GT-AC5300";
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x00 0x00 0x00 0x40000000>;
-	};
-
-	gpio-keys-polled {
-		compatible = "gpio-keys-polled";
-		poll-interval = <100>;
-
-		wifi {
-			label = "WiFi";
-			linux,code = <KEY_RFKILL>;
-			gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
-		};
-
-		wps {
-			label = "WPS";
-			linux,code = <KEY_WPS_BUTTON>;
-			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
-		};
-
-		restart {
-			label = "Reset";
-			linux,code = <KEY_RESTART>;
-			gpios = <&gpio0 30 GPIO_ACTIVE_LOW>;
-		};
-
-		brightness {
-			label = "LEDs";
-			linux,code = <KEY_BRIGHTNESS_ZERO>;
-			gpios = <&gpio0 31 GPIO_ACTIVE_LOW>;
-		};
-	};
-};
-
-&enet {
-	nvmem-cells = <&base_mac_addr>;
-	nvmem-cell-names = "mac-address";
-};
-
-&usb_phy {
-	brcm,ioc = <1>;
-	status = "okay";
-};
-
-&ehci {
-	status = "okay";
-};
-
-&ohci {
-	status = "okay";
-};
-
-&xhci {
-	status = "okay";
-};
-
-&ports {
-	port@0 {
-		label = "lan2";
-	};
-
-	port@1 {
-		label = "lan1";
-	};
-
-	port@2 {
-		label = "lan6";
-	};
-
-	port@3 {
-		label = "lan5";
-	};
-
-	/* External BCM53134S switch */
-	port@7 {
-		label = "sw";
-		reg = <7>;
-		phy-mode = "rgmii";
-
-		fixed-link {
-			speed = <1000>;
-			full-duplex;
-		};
-	};
-};
-
-&mdio {
-	/* lan8 */
-	ethernet-phy@0 {
-		reg = <0>;
-	};
-
-	/* lan7 */
-	ethernet-phy@1 {
-		reg = <1>;
-	};
-
-	/* lan4 */
-	ethernet-phy@2 {
-		reg = <2>;
-	};
-
-	/* lan3 */
-	ethernet-phy@3 {
-		reg = <3>;
-	};
-};
-
-&nandcs {
-	nand-ecc-strength = <4>;
-	nand-ecc-step-size = <512>;
-	nand-on-flash-bbt;
-	brcm,nand-has-wp;
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	partitions {
-		compatible = "brcm,bcm4908-partitions";
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		partition@0 {
-			compatible = "nvmem-cells";
-			label = "cferom";
-			reg = <0x0 0x100000>;
-
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x0 0x100000>;
-
-			base_mac_addr: mac@106a0 {
-				reg = <0x106a0 0x6>;
-			};
-		};
-
-		partition@100000 {
-			compatible = "brcm,bcm4908-firmware";
-			reg = <0x100000 0x5700000>;
-		};
-
-		partition@5800000 {
-			compatible = "brcm,bcm4908-firmware";
-			reg = <0x5800000 0x5700000>;
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi
deleted file mode 100644
index e510a6961cf9..000000000000
--- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi
+++ /dev/null
@@ -1,339 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
-
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/phy/phy.h>
-#include <dt-bindings/soc/bcm-pmb.h>
-
-/dts-v1/;
-
-/ {
-	interrupt-parent = <&gic>;
-
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu@0 {
-			device_type = "cpu";
-			compatible = "brcm,brahma-b53";
-			reg = <0x0>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0xfff8>;
-			next-level-cache = <&l2>;
-		};
-
-		cpu1: cpu@1 {
-			device_type = "cpu";
-			compatible = "brcm,brahma-b53";
-			reg = <0x1>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0xfff8>;
-			next-level-cache = <&l2>;
-		};
-
-		cpu2: cpu@2 {
-			device_type = "cpu";
-			compatible = "brcm,brahma-b53";
-			reg = <0x2>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0xfff8>;
-			next-level-cache = <&l2>;
-		};
-
-		cpu3: cpu@3 {
-			device_type = "cpu";
-			compatible = "brcm,brahma-b53";
-			reg = <0x3>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0xfff8>;
-			next-level-cache = <&l2>;
-		};
-
-		l2: l2-cache0 {
-			compatible = "cache";
-		};
-	};
-
-	axi@81000000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x00 0x00 0x81000000 0x4000>;
-
-		gic: interrupt-controller@1000 {
-			compatible = "arm,gic-400";
-			#interrupt-cells = <3>;
-			#address-cells = <0>;
-			interrupt-controller;
-			reg = <0x1000 0x1000>,
-			      <0x2000 0x2000>;
-		};
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-	};
-
-	pmu {
-		compatible = "arm,cortex-a53-pmu";
-		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
-	};
-
-	clocks {
-		periph_clk: periph_clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <50000000>;
-			clock-output-names = "periph";
-		};
-	};
-
-	soc {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x00 0x00 0x80000000 0x281000>;
-
-		enet: ethernet@2000 {
-			compatible = "brcm,bcm4908-enet";
-			reg = <0x2000 0x1000>;
-
-			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "rx", "tx";
-		};
-
-		usb_phy: usb-phy@c200 {
-			compatible = "brcm,bcm4908-usb-phy";
-			reg = <0xc200 0x100>;
-			reg-names = "ctrl";
-			power-domains = <&pmb BCM_PMB_HOST_USB>;
-			dr_mode = "host";
-			brcm,has-xhci;
-			brcm,has-eohci;
-			#phy-cells = <1>;
-			status = "disabled";
-		};
-
-		ehci: usb@c300 {
-			compatible = "generic-ehci";
-			reg = <0xc300 0x100>;
-			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-			phys = <&usb_phy PHY_TYPE_USB2>;
-			status = "disabled";
-		};
-
-		ohci: usb@c400 {
-			compatible = "generic-ohci";
-			reg = <0xc400 0x100>;
-			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
-			phys = <&usb_phy PHY_TYPE_USB2>;
-			status = "disabled";
-		};
-
-		xhci: usb@d000 {
-			compatible = "generic-xhci";
-			reg = <0xd000 0x8c8>;
-			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-			phys = <&usb_phy PHY_TYPE_USB3>;
-			status = "disabled";
-		};
-
-		bus@80000 {
-			compatible = "simple-bus";
-			#size-cells = <1>;
-			#address-cells = <1>;
-			ranges = <0 0x80000 0x50000>;
-
-			ethernet-switch@0 {
-				compatible = "brcm,bcm4908-switch";
-				reg = <0x0 0x40000>,
-				      <0x40000 0x110>,
-				      <0x40340 0x30>,
-				      <0x40380 0x30>,
-				      <0x40600 0x34>,
-				      <0x40800 0x208>;
-				reg-names = "core", "reg", "intrl2_0",
-					    "intrl2_1", "fcb", "acb";
-				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
-				brcm,num-gphy = <5>;
-				brcm,num-rgmii-ports = <2>;
-
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				ports: ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					port@0 {
-						reg = <0>;
-						phy-mode = "internal";
-						phy-handle = <&phy8>;
-					};
-
-					port@1 {
-						reg = <1>;
-						phy-mode = "internal";
-						phy-handle = <&phy9>;
-					};
-
-					port@2 {
-						reg = <2>;
-						phy-mode = "internal";
-						phy-handle = <&phy10>;
-					};
-
-					port@3 {
-						reg = <3>;
-						phy-mode = "internal";
-						phy-handle = <&phy11>;
-					};
-
-					port@8 {
-						reg = <8>;
-						phy-mode = "internal";
-						ethernet = <&enet>;
-
-						fixed-link {
-							speed = <1000>;
-							full-duplex;
-						};
-					};
-				};
-			};
-
-			mdio: mdio@405c0 {
-				compatible = "brcm,unimac-mdio";
-				reg = <0x405c0 0x8>;
-				reg-names = "mdio";
-				#size-cells = <0>;
-				#address-cells = <1>;
-
-				phy8: ethernet-phy@8 {
-					reg = <8>;
-				};
-
-				phy9: ethernet-phy@9 {
-					reg = <9>;
-				};
-
-				phy10: ethernet-phy@a {
-					reg = <10>;
-				};
-
-				phy11: ethernet-phy@b {
-					reg = <11>;
-				};
-
-				phy12: ethernet-phy@c {
-					reg = <12>;
-				};
-			};
-		};
-
-		procmon: syscon@280000 {
-			compatible = "simple-bus";
-			reg = <0x280000 0x1000>;
-			ranges;
-
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			pmb: power-controller@2800c0 {
-				compatible = "brcm,bcm4908-pmb";
-				reg = <0x2800c0 0x40>;
-				#power-domain-cells = <1>;
-			};
-		};
-	};
-
-	bus@ff800000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x00 0x00 0xff800000 0x3000>;
-
-		twd: timer-mfd@400 {
-			compatible = "brcm,bcm4908-twd", "simple-mfd", "syscon";
-			reg = <0x400 0x4c>;
-		};
-
-		gpio0: gpio-controller@500 {
-			compatible = "brcm,bcm6345-gpio";
-			reg-names = "dirout", "dat";
-			reg = <0x500 0x28>, <0x528 0x28>;
-
-			#gpio-cells = <2>;
-			gpio-controller;
-		};
-
-		uart0: serial@640 {
-			compatible = "brcm,bcm6345-uart";
-			reg = <0x640 0x18>;
-			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&periph_clk>;
-			clock-names = "refclk";
-			status = "okay";
-		};
-
-		nand@1800 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";
-			reg = <0x1800 0x600>, <0x2000 0x10>;
-			reg-names = "nand", "nand-int-base";
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "nand";
-			status = "okay";
-
-			nandcs: nand@0 {
-				compatible = "brcm,nandcs";
-				reg = <0>;
-			};
-		};
-
-		misc@2600 {
-			compatible = "brcm,misc", "simple-mfd";
-			reg = <0x2600 0xe4>;
-
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0x00 0x2600 0xe4>;
-
-			reset-controller@2644 {
-				compatible = "brcm,bcm4908-misc-pcie-reset";
-				reg = <0x44 0x04>;
-				#reset-cells = <1>;
-			};
-		};
-	};
-
-	reboot {
-		compatible = "syscon-reboot";
-		regmap = <&twd>;
-		offset = <0x34>;
-		mask = <1>;
-	};
-};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
new file mode 100644
index 000000000000..dc68357849a9
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_BCMBCA) += \
+				bcm4906-netgear-r8000p.dtb \
+				bcm4906-tplink-archer-c2300-v1.dtb \
+				bcm4908-asus-gt-ac5300.dtb \
+				bcm4908-netgear-raxe500.dtb \
+				bcm4912-asus-gt-ax6000.dtb \
+				bcm94912.dtb \
+				bcm963158.dtb \
+				bcm96858.dtb
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts
new file mode 100644
index 000000000000..2dd028438c22
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+#include "bcm4906.dtsi"
+
+/ {
+	compatible = "netgear,r8000p", "brcm,bcm4906", "brcm,bcm4908";
+	model = "Netgear R8000P";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00 0x00 0x00 0x20000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-power-white {
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_WHITE>;
+			gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-power-amber {
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_AMBER>;
+			gpios = <&gpio0 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-wps {
+			function = LED_FUNCTION_WPS;
+			color = <LED_COLOR_ID_WHITE>;
+			gpios = <&gpio0 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-2ghz {
+			function = "2ghz";
+			color = <LED_COLOR_ID_WHITE>;
+			gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-5ghz-1 {
+			function = "5ghz-1";
+			color = <LED_COLOR_ID_WHITE>;
+			gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-5ghz-2 {
+			function = "5ghz-2";
+			color = <LED_COLOR_ID_WHITE>;
+			gpios = <&gpio0 16 GPIO_ACTIVE_LOW>;
+		};
+
+		led-usb2 {
+			function = "usb2";
+			color = <LED_COLOR_ID_WHITE>;
+			gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
+		};
+
+		led-usb3 {
+			function = "usb3";
+			color = <LED_COLOR_ID_WHITE>;
+			gpios = <&gpio0 18 GPIO_ACTIVE_LOW>;
+		};
+
+		led-wifi {
+			function = "wifi";
+			color = <LED_COLOR_ID_WHITE>;
+			gpios = <&gpio0 56 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&enet {
+	nvmem-cells = <&base_mac_addr>;
+	nvmem-cell-names = "mac-address";
+};
+
+&usb_phy {
+	brcm,ioc = <1>;
+	status = "okay";
+};
+
+&ehci {
+	status = "okay";
+};
+
+&ohci {
+	status = "okay";
+};
+
+&xhci {
+	status = "okay";
+};
+
+&ports {
+	port@0 {
+		label = "lan4";
+	};
+
+	port@1 {
+		label = "lan3";
+	};
+
+	port@2 {
+		label = "lan2";
+	};
+
+	port@3 {
+		label = "lan1";
+	};
+
+	port@7 {
+		reg = <7>;
+		phy-mode = "internal";
+		phy-handle = <&phy12>;
+		label = "wan";
+	};
+};
+
+&nandcs {
+	nand-ecc-strength = <4>;
+	nand-ecc-step-size = <512>;
+	nand-on-flash-bbt;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			compatible = "nvmem-cells";
+			label = "cferom";
+			reg = <0x0 0x100000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0x100000>;
+
+			base_mac_addr: mac@106a0 {
+				reg = <0x106a0 0x6>;
+			};
+		};
+
+		partition@100000 {
+			compatible = "brcm,bcm4908-firmware";
+			label = "firmware";
+			reg = <0x100000 0x4400000>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-tplink-archer-c2300-v1.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-tplink-archer-c2300-v1.dts
new file mode 100644
index 000000000000..b63eefab48bd
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-tplink-archer-c2300-v1.dts
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+#include "bcm4906.dtsi"
+
+/ {
+	compatible = "tplink,archer-c2300-v1", "brcm,bcm4906", "brcm,bcm4908";
+	model = "TP-Link Archer C2300 V1";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00 0x00 0x00 0x20000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-power {
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
+		};
+
+		led-2ghz {
+			function = "2ghz";
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led-5ghz {
+			function = "5ghz";
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
+		};
+
+		led-wan-amber {
+			function = LED_FUNCTION_WAN;
+			color = <LED_COLOR_ID_AMBER>;
+			gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-wan-blue {
+			function = LED_FUNCTION_WAN;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpio0 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-lan {
+			function = LED_FUNCTION_LAN;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-wps {
+			function = LED_FUNCTION_WPS;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-usb2 {
+			function = "usb2";
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-usb3 {
+			function = "usbd3";
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
+		};
+
+		led-brightness {
+			function = LED_FUNCTION_BACKLIGHT;
+			color = <LED_COLOR_ID_WHITE>;
+			gpios = <&gpio0 19 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		poll-interval = <100>;
+
+		brightness {
+			label = "LEDs";
+			linux,code = <KEY_BRIGHTNESS_ZERO>;
+			gpios = <&gpio0 18 GPIO_ACTIVE_LOW>;
+		};
+
+		wps {
+			label = "WPS";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
+		};
+
+		wifi {
+			label = "WiFi";
+			linux,code = <KEY_RFKILL>;
+			gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
+		};
+
+		restart {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&usb_phy {
+	brcm,ioc = <1>;
+	status = "okay";
+};
+
+&ehci {
+	status = "okay";
+};
+
+&ohci {
+	status = "okay";
+};
+
+&xhci {
+	status = "okay";
+};
+
+&ports {
+	port@0 {
+		label = "lan4";
+	};
+
+	port@1 {
+		label = "lan3";
+	};
+
+	port@2 {
+		label = "lan2";
+	};
+
+	port@3 {
+		label = "lan1";
+	};
+
+	port@7 {
+		reg = <7>;
+		phy-mode = "internal";
+		phy-handle = <&phy12>;
+		label = "wan";
+	};
+};
+
+&nandcs {
+	nand-ecc-strength = <4>;
+	nand-ecc-step-size = <512>;
+	nand-on-flash-bbt;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	partitions {
+		compatible = "brcm,bcm4908-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "cferom";
+			reg = <0x0 0x100000>;
+		};
+
+		partition@100000 {
+			compatible = "brcm,bcm4908-firmware";
+			reg = <0x100000 0x3900000>;
+		};
+
+		partition@5800000 {
+			compatible = "brcm,bcm4908-firmware";
+			reg = <0x3a00000 0x3900000>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906.dtsi
new file mode 100644
index 000000000000..d084c33d5ca8
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+#include "bcm4908.dtsi"
+
+/ {
+	cpus {
+		/delete-node/ cpu@2;
+
+		/delete-node/ cpu@3;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts
new file mode 100644
index 000000000000..169fbb7cfd34
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+#include "bcm4908.dtsi"
+
+/ {
+	compatible = "asus,gt-ac5300", "brcm,bcm4908";
+	model = "Asus GT-AC5300";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00 0x00 0x00 0x40000000>;
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		poll-interval = <100>;
+
+		wifi {
+			label = "WiFi";
+			linux,code = <KEY_RFKILL>;
+			gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
+		};
+
+		wps {
+			label = "WPS";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
+		};
+
+		restart {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio0 30 GPIO_ACTIVE_LOW>;
+		};
+
+		brightness {
+			label = "LEDs";
+			linux,code = <KEY_BRIGHTNESS_ZERO>;
+			gpios = <&gpio0 31 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&enet {
+	nvmem-cells = <&base_mac_addr>;
+	nvmem-cell-names = "mac-address";
+};
+
+&usb_phy {
+	brcm,ioc = <1>;
+	status = "okay";
+};
+
+&ehci {
+	status = "okay";
+};
+
+&ohci {
+	status = "okay";
+};
+
+&xhci {
+	status = "okay";
+};
+
+&ports {
+	port@0 {
+		label = "lan2";
+	};
+
+	port@1 {
+		label = "lan1";
+	};
+
+	port@2 {
+		label = "lan6";
+	};
+
+	port@3 {
+		label = "lan5";
+	};
+
+	/* External BCM53134S switch */
+	port@7 {
+		label = "sw";
+		reg = <7>;
+		phy-mode = "rgmii";
+
+		fixed-link {
+			speed = <1000>;
+			full-duplex;
+		};
+	};
+};
+
+&mdio {
+	/* lan8 */
+	ethernet-phy@0 {
+		reg = <0>;
+	};
+
+	/* lan7 */
+	ethernet-phy@1 {
+		reg = <1>;
+	};
+
+	/* lan4 */
+	ethernet-phy@2 {
+		reg = <2>;
+	};
+
+	/* lan3 */
+	ethernet-phy@3 {
+		reg = <3>;
+	};
+};
+
+&nandcs {
+	nand-ecc-strength = <4>;
+	nand-ecc-step-size = <512>;
+	nand-on-flash-bbt;
+	brcm,nand-has-wp;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	partitions {
+		compatible = "brcm,bcm4908-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			compatible = "nvmem-cells";
+			label = "cferom";
+			reg = <0x0 0x100000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0x100000>;
+
+			base_mac_addr: mac@106a0 {
+				reg = <0x106a0 0x6>;
+			};
+		};
+
+		partition@100000 {
+			compatible = "brcm,bcm4908-firmware";
+			reg = <0x100000 0x5700000>;
+		};
+
+		partition@5800000 {
+			compatible = "brcm,bcm4908-firmware";
+			reg = <0x5800000 0x5700000>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-netgear-raxe500.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-netgear-raxe500.dts
new file mode 100644
index 000000000000..3c2cf2d238b6
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-netgear-raxe500.dts
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+#include "bcm4908.dtsi"
+
+/ {
+	compatible = "netgear,raxe500", "brcm,bcm4908";
+	model = "Netgear RAXE500";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00 0x00 0x00 0x40000000>;
+	};
+};
+
+&ehci {
+	status = "okay";
+};
+
+&ohci {
+	status = "okay";
+};
+
+&xhci {
+	status = "okay";
+};
+
+&ports {
+	port@0 {
+		label = "lan4";
+	};
+
+	port@1 {
+		label = "lan3";
+	};
+
+	port@2 {
+		label = "lan2";
+	};
+
+	port@3 {
+		label = "lan1";
+	};
+
+	port@7 {
+		reg = <7>;
+		phy-mode = "internal";
+		phy-handle = <&phy12>;
+		label = "wan";
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
new file mode 100644
index 000000000000..b7db95ce0bbf
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/soc/bcm-pmb.h>
+
+/dts-v1/;
+
+/ {
+	interrupt-parent = <&gic>;
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "brcm,brahma-b53";
+			reg = <0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0xfff8>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "brcm,brahma-b53";
+			reg = <0x1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0xfff8>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "brcm,brahma-b53";
+			reg = <0x2>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0xfff8>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "brcm,brahma-b53";
+			reg = <0x3>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0xfff8>;
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache0 {
+			compatible = "cache";
+		};
+	};
+
+	axi@81000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x81000000 0x4000>;
+
+		gic: interrupt-controller@1000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x1000 0x1000>,
+			      <0x2000 0x2000>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
+	clocks {
+		periph_clk: periph_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <50000000>;
+			clock-output-names = "periph";
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x80000000 0x281000>;
+
+		enet: ethernet@2000 {
+			compatible = "brcm,bcm4908-enet";
+			reg = <0x2000 0x1000>;
+
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "rx", "tx";
+		};
+
+		usb_phy: usb-phy@c200 {
+			compatible = "brcm,bcm4908-usb-phy";
+			reg = <0xc200 0x100>;
+			reg-names = "ctrl";
+			power-domains = <&pmb BCM_PMB_HOST_USB>;
+			dr_mode = "host";
+			brcm,has-xhci;
+			brcm,has-eohci;
+			#phy-cells = <1>;
+			status = "disabled";
+		};
+
+		ehci: usb@c300 {
+			compatible = "generic-ehci";
+			reg = <0xc300 0x100>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb_phy PHY_TYPE_USB2>;
+			status = "disabled";
+		};
+
+		ohci: usb@c400 {
+			compatible = "generic-ohci";
+			reg = <0xc400 0x100>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb_phy PHY_TYPE_USB2>;
+			status = "disabled";
+		};
+
+		xhci: usb@d000 {
+			compatible = "generic-xhci";
+			reg = <0xd000 0x8c8>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb_phy PHY_TYPE_USB3>;
+			status = "disabled";
+		};
+
+		bus@80000 {
+			compatible = "simple-bus";
+			#size-cells = <1>;
+			#address-cells = <1>;
+			ranges = <0 0x80000 0x50000>;
+
+			ethernet-switch@0 {
+				compatible = "brcm,bcm4908-switch";
+				reg = <0x0 0x40000>,
+				      <0x40000 0x110>,
+				      <0x40340 0x30>,
+				      <0x40380 0x30>,
+				      <0x40600 0x34>,
+				      <0x40800 0x208>;
+				reg-names = "core", "reg", "intrl2_0",
+					    "intrl2_1", "fcb", "acb";
+				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+				brcm,num-gphy = <5>;
+				brcm,num-rgmii-ports = <2>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ports: ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						phy-mode = "internal";
+						phy-handle = <&phy8>;
+					};
+
+					port@1 {
+						reg = <1>;
+						phy-mode = "internal";
+						phy-handle = <&phy9>;
+					};
+
+					port@2 {
+						reg = <2>;
+						phy-mode = "internal";
+						phy-handle = <&phy10>;
+					};
+
+					port@3 {
+						reg = <3>;
+						phy-mode = "internal";
+						phy-handle = <&phy11>;
+					};
+
+					port@8 {
+						reg = <8>;
+						phy-mode = "internal";
+						ethernet = <&enet>;
+
+						fixed-link {
+							speed = <1000>;
+							full-duplex;
+						};
+					};
+				};
+			};
+
+			mdio: mdio@405c0 {
+				compatible = "brcm,unimac-mdio";
+				reg = <0x405c0 0x8>;
+				reg-names = "mdio";
+				#size-cells = <0>;
+				#address-cells = <1>;
+
+				phy8: ethernet-phy@8 {
+					reg = <8>;
+				};
+
+				phy9: ethernet-phy@9 {
+					reg = <9>;
+				};
+
+				phy10: ethernet-phy@a {
+					reg = <10>;
+				};
+
+				phy11: ethernet-phy@b {
+					reg = <11>;
+				};
+
+				phy12: ethernet-phy@c {
+					reg = <12>;
+				};
+			};
+		};
+
+		procmon: bus@280000 {
+			compatible = "simple-bus";
+			reg = <0x280000 0x1000>;
+			ranges;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			pmb: power-controller@2800c0 {
+				compatible = "brcm,bcm4908-pmb";
+				reg = <0x2800c0 0x40>;
+				#power-domain-cells = <1>;
+			};
+		};
+	};
+
+	bus@ff800000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0xff800000 0x3000>;
+
+		twd: timer-mfd@400 {
+			compatible = "brcm,bcm4908-twd", "simple-mfd", "syscon";
+			reg = <0x400 0x4c>;
+		};
+
+		gpio0: gpio-controller@500 {
+			compatible = "brcm,bcm6345-gpio";
+			reg-names = "dirout", "dat";
+			reg = <0x500 0x28>, <0x528 0x28>;
+
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
+		uart0: serial@640 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0x640 0x18>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&periph_clk>;
+			clock-names = "refclk";
+			status = "okay";
+		};
+
+		nand@1800 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";
+			reg = <0x1800 0x600>, <0x2000 0x10>;
+			reg-names = "nand", "nand-int-base";
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "nand_ctlrdy";
+			status = "okay";
+
+			nandcs: nand@0 {
+				compatible = "brcm,nandcs";
+				reg = <0>;
+			};
+		};
+
+		misc@2600 {
+			compatible = "brcm,misc", "simple-mfd";
+			reg = <0x2600 0xe4>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x00 0x2600 0xe4>;
+
+			reset-controller@2644 {
+				compatible = "brcm,bcm4908-misc-pcie-reset";
+				reg = <0x44 0x04>;
+				#reset-cells = <1>;
+			};
+		};
+	};
+
+	reboot {
+		compatible = "syscon-reboot";
+		regmap = <&twd>;
+		offset = <0x34>;
+		mask = <1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912-asus-gt-ax6000.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912-asus-gt-ax6000.dts
new file mode 100644
index 000000000000..ed554666e95e
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912-asus-gt-ax6000.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+/dts-v1/;
+
+#include "bcm4912.dtsi"
+
+/ {
+	compatible = "asus,gt-ax6000", "brcm,bcm4912", "brcm,bcmbca";
+	model = "Asus GT-AX6000";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00 0x00 0x00 0x40000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
new file mode 100644
index 000000000000..3d016c2ce675
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 Broadcom Ltd.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "brcm,bcm4912", "brcm,bcmbca";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		B53_0: cpu@0 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		B53_1: cpu@1 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		B53_2: cpu@2 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		B53_3: cpu@3 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		L2_0: l2-cache0 {
+			compatible = "cache";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	pmu: pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&B53_0>, <&B53_1>,
+			<&B53_2>, <&B53_3>;
+	};
+
+	clocks: clocks {
+		periph_clk: periph-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+		};
+		uart_clk: uart-clk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clocks = <&periph_clk>;
+			clock-div = <4>;
+			clock-mult = <1>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	axi@81000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x81000000 0x8000>;
+
+		gic: interrupt-controller@1000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			reg = <0x1000 0x1000>,
+				<0x2000 0x2000>,
+				<0x4000 0x2000>,
+				<0x6000 0x2000>;
+		};
+	};
+
+	bus@ff800000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0xff800000 0x800000>;
+
+		uart0: serial@12000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x12000 0x1000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_clk>, <&uart_clk>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
new file mode 100644
index 000000000000..13629702f70b
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 Broadcom Ltd.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "brcm,bcm63158", "brcm,bcmbca";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		B53_0: cpu@0 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		B53_1: cpu@1 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		B53_2: cpu@2 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		B53_3: cpu@3 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		L2_0: l2-cache0 {
+			compatible = "cache";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	pmu: pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&B53_0>, <&B53_1>,
+			<&B53_2>, <&B53_3>;
+	};
+
+	clocks: clocks {
+		periph_clk: periph-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+		};
+		uart_clk: uart-clk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clocks = <&periph_clk>;
+			clock-div = <4>;
+			clock-mult = <1>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	axi@81000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x81000000 0x8000>;
+
+		gic: interrupt-controller@1000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			reg = <0x1000 0x1000>,
+				<0x2000 0x2000>,
+				<0x4000 0x2000>,
+				<0x6000 0x2000>;
+		};
+	};
+
+	bus@ff800000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0xff800000 0x800000>;
+
+		uart0: serial@12000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x12000 0x1000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_clk>, <&uart_clk>;
+			clock-names = "uartclk", "apb_pclk";
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
new file mode 100644
index 000000000000..29a880c6c858
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 Broadcom Ltd.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "brcm,bcm6858", "brcm,bcmbca";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		B53_0: cpu@0 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		B53_1: cpu@1 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		B53_2: cpu@2 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+
+		B53_3: cpu@3 {
+			compatible = "brcm,brahma-b53";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			next-level-cache = <&L2_0>;
+			enable-method = "psci";
+		};
+		L2_0: l2-cache0 {
+			compatible = "cache";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	pmu: pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&B53_0>, <&B53_1>,
+			<&B53_2>, <&B53_3>;
+	};
+
+	clocks: clocks {
+		periph_clk:periph-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	axi@81000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x81000000 0x8000>;
+
+		gic: interrupt-controller@1000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x1000 0x1000>, /* GICD */
+				<0x2000 0x2000>, /* GICC */
+				<0x4000 0x2000>, /* GICH */
+				<0x6000 0x2000>; /* GICV */
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
+					IRQ_TYPE_LEVEL_HIGH)>;
+		};
+	};
+
+	bus@ff800000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0xff800000 0x62000>;
+
+		uart0: serial@640 {
+			compatible = "brcm,bcm6345-uart";
+			reg = <0x640 0x18>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&periph_clk>;
+			clock-names = "refclk";
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts
new file mode 100644
index 000000000000..a3623e6f6919
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 Broadcom Ltd.
+ */
+
+/dts-v1/;
+
+#include "bcm4912.dtsi"
+
+/ {
+	model = "Broadcom BCM94912 Reference Board";
+	compatible = "brcm,bcm94912", "brcm,bcm4912", "brcm,bcmbca";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x08000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts
new file mode 100644
index 000000000000..eba07e0b1ca6
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 Broadcom Ltd.
+ */
+
+/dts-v1/;
+
+#include "bcm63158.dtsi"
+
+/ {
+	model = "Broadcom BCM963158 Reference Board";
+	compatible = "brcm,bcm963158", "brcm,bcm63158", "brcm,bcmbca";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x08000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts
new file mode 100644
index 000000000000..0cbf582f5d54
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022 Broadcom Ltd.
+ */
+
+/dts-v1/;
+
+#include "bcm6858.dtsi"
+
+/ {
+	model = "Broadcom BCM96858 Reference Board";
+	compatible = "brcm,bcm96858", "brcm,bcm6858", "brcm,bcmbca";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x08000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 30ac0b2e8c89..3ca198f866c3 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -433,10 +433,8 @@ pcie0: pci@20000000 {
 			phys = <&pcie_phy0>;
 			phy-names = "pciephy";
 
-			ranges = <0x81000000 0 0x20200000 0 0x20200000
-				  0 0x10000>, /* downstream I/O */
-				 <0x82000000 0 0x20220000 0 0x20220000
-				  0 0xfde0000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x0 0x20200000 0x0 0x10000>,
+				 <0x82000000 0x0 0x20220000 0x0 0x20220000 0x0 0xfde0000>;
 
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 68e82c755986..17eeff106bab 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -661,10 +661,8 @@ pcie1: pci@10000000 {
 			phys = <&pcie_phy1>;
 			phy-names = "pciephy";
 
-			ranges = <0x81000000 0 0x10200000 0x10200000
-				  0 0x10000>,   /* downstream I/O */
-				 <0x82000000 0 0x10220000 0x10220000
-				  0 0xfde0000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x10200000 0x0 0x10000>,   /* I/O */
+				 <0x82000000 0x0 0x10220000 0x10220000 0x0 0xfde0000>; /* MEM */
 
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
@@ -725,10 +723,8 @@ pcie0: pci@20000000 {
 			phys = <&pcie_phy0>;
 			phy-names = "pciephy";
 
-			ranges = <0x81000000 0 0x20200000 0x20200000
-				  0 0x10000>, /* downstream I/O */
-				 <0x82000000 0 0x20220000 0x20220000
-				  0 0xfde0000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x20200000 0x0 0x10000>,   /* I/O */
+				 <0x82000000 0x0 0x20220000 0x20220000 0x0 0xfde0000>; /* MEM */
 
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
diff --git a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
index 3a3790a52a2c..e2d08915ec42 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
@@ -540,8 +540,7 @@ hd3ss460_en: en_high {
 };
 
 &pmi8994_spmi_regulators {
-	vdd_gfx: s2@1700 {
-		reg = <0x1700 0x100>;
+	vdd_gfx: s2 {
 		regulator-min-microvolt = <980000>;
 		regulator-max-microvolt = <980000>;
 	};
diff --git a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
index 48de66bf19c4..55198190bbea 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
@@ -183,8 +183,7 @@ &pmi8994_spmi_regulators {
 	 * power domain.. which still isn't enough and forces us to bind
 	 * OXILI_CX and OXILI_GX together!
 	 */
-	vdd_gfx: s2@1700 {
-		reg = <0x1700 0x100>;
+	vdd_gfx: s2 {
 		regulator-name = "VDD_GFX";
 		regulator-min-microvolt = <980000>;
 		regulator-max-microvolt = <980000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 40174220e8e2..b22d3c8db3b3 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1555,8 +1555,8 @@ pcie0: pcie@600000 {
 
 				#address-cells = <3>;
 				#size-cells = <2>;
-				ranges = <0x01000000 0x0 0x0c200000 0x0c200000 0x0 0x100000>,
-					<0x02000000 0x0 0x0c300000 0x0c300000 0x0 0xd00000>;
+				ranges = <0x01000000 0x0 0x00000000 0x0c200000 0x0 0x100000>,
+					 <0x02000000 0x0 0x0c300000 0x0c300000 0x0 0xd00000>;
 
 				device_type = "pci";
 
@@ -1609,8 +1609,8 @@ pcie1: pcie@608000 {
 
 				#address-cells = <3>;
 				#size-cells = <2>;
-				ranges = <0x01000000 0x0 0x0d200000 0x0d200000 0x0 0x100000>,
-					<0x02000000 0x0 0x0d300000 0x0d300000 0x0 0xd00000>;
+				ranges = <0x01000000 0x0 0x00000000 0x0d200000 0x0 0x100000>,
+					 <0x02000000 0x0 0x0d300000 0x0d300000 0x0 0xd00000>;
 
 				device_type = "pci";
 
@@ -1660,8 +1660,8 @@ pcie2: pcie@610000 {
 
 				#address-cells = <3>;
 				#size-cells = <2>;
-				ranges = <0x01000000 0x0 0x0e200000 0x0e200000 0x0 0x100000>,
-					<0x02000000 0x0 0x0e300000 0x0e300000 0x0 0x1d00000>;
+				ranges = <0x01000000 0x0 0x00000000 0x0e200000 0x0 0x100000>,
+					 <0x02000000 0x0 0x0e300000 0x0e300000 0x0 0x1d00000>;
 
 				device_type = "pci";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 5350b911f4f6..b7d72b0d579e 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -951,7 +951,7 @@ pcie0: pci@1c00000 {
 			phy-names = "pciephy";
 			status = "disabled";
 
-			ranges = <0x01000000 0x0 0x1b200000 0x1b200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x1b200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x1b300000 0x1b300000 0x0 0xd00000>;
 
 			#interrupt-cells = <1>;
@@ -1473,7 +1473,7 @@ stm: stm@6002000 {
 			compatible = "arm,coresight-stm", "arm,primecell";
 			reg = <0x06002000 0x1000>,
 			      <0x16280000 0x180000>;
-			reg-names = "stm-base", "stm-data-base";
+			reg-names = "stm-base", "stm-stimulus-base";
 			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dts
index 6ebde0828550..8a98a6f849c4 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dts
@@ -26,7 +26,7 @@ trackpad: trackpad@2c {
 		interrupt-parent = <&tlmm>;
 		interrupts = <58 IRQ_TYPE_EDGE_FALLING>;
 
-		vcc-supply = <&pp3300_fp_tp>;
+		vdd-supply = <&pp3300_fp_tp>;
 		hid-descr-addr = <0x20>;
 
 		wakeup-source;
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index ed293f635f14..d973aa39e410 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -196,8 +196,8 @@ CPU0: cpu@0 {
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			capacity-dmips-mhz = <607>;
-			dynamic-power-coefficient = <100>;
+			capacity-dmips-mhz = <611>;
+			dynamic-power-coefficient = <154>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -221,8 +221,8 @@ CPU1: cpu@100 {
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			capacity-dmips-mhz = <607>;
-			dynamic-power-coefficient = <100>;
+			capacity-dmips-mhz = <611>;
+			dynamic-power-coefficient = <154>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -243,8 +243,8 @@ CPU2: cpu@200 {
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			capacity-dmips-mhz = <607>;
-			dynamic-power-coefficient = <100>;
+			capacity-dmips-mhz = <611>;
+			dynamic-power-coefficient = <154>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -265,8 +265,8 @@ CPU3: cpu@300 {
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			capacity-dmips-mhz = <607>;
-			dynamic-power-coefficient = <100>;
+			capacity-dmips-mhz = <611>;
+			dynamic-power-coefficient = <154>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -288,7 +288,7 @@ CPU4: cpu@400 {
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			dynamic-power-coefficient = <396>;
+			dynamic-power-coefficient = <442>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -310,7 +310,7 @@ CPU5: cpu@500 {
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			dynamic-power-coefficient = <396>;
+			dynamic-power-coefficient = <442>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -332,7 +332,7 @@ CPU6: cpu@600 {
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			dynamic-power-coefficient = <396>;
+			dynamic-power-coefficient = <442>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -354,7 +354,7 @@ CPU7: cpu@700 {
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			dynamic-power-coefficient = <396>;
+			dynamic-power-coefficient = <442>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -1988,8 +1988,8 @@ pcie0: pci@1c00000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
-				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0xd00000>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0xd00000>;
 
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
@@ -2093,7 +2093,7 @@ pcie1: pci@1c08000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
 
 			interrupts = <GIC_SPI 307 IRQ_TYPE_EDGE_RISING>;
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 4e3b772a8bde..181e32b8a272 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1393,8 +1393,8 @@ pcie0: pci@1c00000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
-				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
+				 <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x3d00000>;
 
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
@@ -1494,7 +1494,7 @@ pcie1: pci@1c08000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
 
 			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
@@ -1602,7 +1602,7 @@ pcie2: pci@1c10000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x01000000 0x0 0x64200000 0x0 0x64200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x64200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x64300000 0x0 0x64300000 0x0 0x3d00000>;
 
 			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 9eb08be3b98e..50189209b660 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -49,17 +49,14 @@ cluster1_opp: opp_table10 {
 		opp-shared;
 		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 		};
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 		};
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index 9e616b0f04d4..adcb03fa2314 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -60,17 +60,14 @@ cluster1_opp: opp_table10 {
 		opp-shared;
 		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 		};
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 		};
 		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <820000>;
 			clock-latency-ns = <300000>;
 			opp-suspend;
 		};
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index ad21bb1417aa..d662eeb7d80a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1051,7 +1051,6 @@ main_sdhci0: mmc@4f80000 {
 		ti,itap-del-sel-mmc-hs = <0xa>;
 		ti,itap-del-sel-ddr52 = <0x3>;
 		ti,trm-icp = <0x8>;
-		ti,strobe-sel = <0x77>;
 		dma-coherent;
 	};
 
diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index e1e10a24519b..8de1a840ad97 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -116,6 +116,7 @@ void user_regs_reset_single_step(struct user_pt_regs *regs,
 void kernel_enable_single_step(struct pt_regs *regs);
 void kernel_disable_single_step(void);
 int kernel_active_single_step(void);
+void kernel_rewind_single_step(struct pt_regs *regs);
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 int reinstall_suspended_bps(struct pt_regs *regs);
diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
index 8297bccf0784..5cd4d09bc69d 100644
--- a/arch/arm64/include/asm/scs.h
+++ b/arch/arm64/include/asm/scs.h
@@ -9,15 +9,16 @@
 #ifdef CONFIG_SHADOW_CALL_STACK
 	scs_sp	.req	x18
 
-	.macro scs_load tsk
-	ldr	scs_sp, [\tsk, #TSK_TI_SCS_SP]
+	.macro scs_load_current
+	get_current_task scs_sp
+	ldr	scs_sp, [scs_sp, #TSK_TI_SCS_SP]
 	.endm
 
 	.macro scs_save tsk
 	str	scs_sp, [\tsk, #TSK_TI_SCS_SP]
 	.endm
 #else
-	.macro scs_load tsk
+	.macro scs_load_current
 	.endm
 
 	.macro scs_save tsk
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index bf9fe71589bc..732f0890416d 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -438,6 +438,11 @@ int kernel_active_single_step(void)
 }
 NOKPROBE_SYMBOL(kernel_active_single_step);
 
+void kernel_rewind_single_step(struct pt_regs *regs)
+{
+	set_regs_spsr_ss(regs);
+}
+
 /* ptrace API */
 void user_enable_single_step(struct task_struct *task)
 {
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 34e38eb00f05..c56b262a2749 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -272,7 +272,7 @@ alternative_if ARM64_HAS_ADDRESS_AUTH
 alternative_else_nop_endif
 1:
 
-	scs_load tsk
+	scs_load_current
 	.else
 	add	x21, sp, #PT_REGS_SIZE
 	get_current_task tsk
@@ -855,7 +855,7 @@ SYM_FUNC_START(cpu_switch_to)
 	msr	sp_el0, x1
 	ptrauth_keys_install_kernel x1, x8, x9, x10
 	scs_save x0
-	scs_load x1
+	scs_load_current
 	ret
 SYM_FUNC_END(cpu_switch_to)
 NOKPROBE(cpu_switch_to)
@@ -883,19 +883,19 @@ NOKPROBE(ret_from_fork)
  */
 SYM_FUNC_START(call_on_irq_stack)
 #ifdef CONFIG_SHADOW_CALL_STACK
-	stp	scs_sp, xzr, [sp, #-16]!
+	get_current_task x16
+	scs_save x16
 	ldr_this_cpu scs_sp, irq_shadow_call_stack_ptr, x17
 #endif
+
 	/* Create a frame record to save our LR and SP (implicit in FP) */
 	stp	x29, x30, [sp, #-16]!
 	mov	x29, sp
 
 	ldr_this_cpu x16, irq_stack_ptr, x17
-	mov	x15, #IRQ_STACK_SIZE
-	add	x16, x16, x15
 
 	/* Move to the new stack and call the function there */
-	mov	sp, x16
+	add	sp, x16, #IRQ_STACK_SIZE
 	blr	x1
 
 	/*
@@ -904,9 +904,7 @@ SYM_FUNC_START(call_on_irq_stack)
 	 */
 	mov	sp, x29
 	ldp	x29, x30, [sp], #16
-#ifdef CONFIG_SHADOW_CALL_STACK
-	ldp	scs_sp, xzr, [sp], #16
-#endif
+	scs_load_current
 	ret
 SYM_FUNC_END(call_on_irq_stack)
 NOKPROBE(call_on_irq_stack)
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index ab6566bf1c33..512a921edad5 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -409,7 +409,7 @@ SYM_FUNC_END(__create_page_tables)
 	stp	xzr, xzr, [sp, #S_STACKFRAME]
 	add	x29, sp, #S_STACKFRAME
 
-	scs_load \tsk
+	scs_load_current
 
 	adr_l	\tmp1, __per_cpu_offset
 	ldr	w\tmp2, [\tsk, #TSK_CPU]
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index cda9c1e9864f..4e1f983df3d1 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -224,6 +224,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		 */
 		if (!kernel_active_single_step())
 			kernel_enable_single_step(linux_regs);
+		else
+			kernel_rewind_single_step(linux_regs);
 		err = 0;
 		break;
 	default:
diff --git a/arch/ia64/kernel/salinfo.c b/arch/ia64/kernel/salinfo.c
index a25ab9b37953..bb99b543dc67 100644
--- a/arch/ia64/kernel/salinfo.c
+++ b/arch/ia64/kernel/salinfo.c
@@ -581,7 +581,7 @@ static int salinfo_cpu_pre_down(unsigned int cpu)
  * 'data' contains an integer that corresponds to the feature we're
  * testing
  */
-static int proc_salinfo_show(struct seq_file *m, void *v)
+static int __maybe_unused proc_salinfo_show(struct seq_file *m, void *v)
 {
 	unsigned long data = (unsigned long)v;
 	seq_puts(m, (sal_platform_features & data) ? "1\n" : "0\n");
diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index 42e025cfbd08..9817caba0702 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -77,7 +77,7 @@ void *per_cpu_init(void)
 	return __per_cpu_start + __per_cpu_offset[smp_processor_id()];
 }
 
-static inline void
+static inline __init void
 alloc_per_cpu_data(void)
 {
 	size_t size = PERCPU_PAGE_SIZE * num_possible_cpus();
diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
index f993cb36c062..921db957d2e6 100644
--- a/arch/ia64/mm/hugetlbpage.c
+++ b/arch/ia64/mm/hugetlbpage.c
@@ -58,7 +58,7 @@ huge_pte_offset (struct mm_struct *mm, unsigned long addr, unsigned long sz)
 
 	pgd = pgd_offset(mm, taddr);
 	if (pgd_present(*pgd)) {
-		p4d = p4d_offset(pgd, addr);
+		p4d = p4d_offset(pgd, taddr);
 		if (p4d_present(*p4d)) {
 			pud = pud_offset(p4d, taddr);
 			if (pud_present(*pud)) {
diff --git a/arch/mips/fw/lib/cmdline.c b/arch/mips/fw/lib/cmdline.c
index f24cbb4a39b5..892765b742bb 100644
--- a/arch/mips/fw/lib/cmdline.c
+++ b/arch/mips/fw/lib/cmdline.c
@@ -53,7 +53,7 @@ char *fw_getenv(char *envname)
 {
 	char *result = NULL;
 
-	if (_fw_envp != NULL) {
+	if (_fw_envp != NULL && fw_envp(0) != NULL) {
 		/*
 		 * Return a pointer to the given environment variable.
 		 * YAMON uses "name", "value" pairs, while U-Boot uses
diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index c68f3349c174..d32906e89aaf 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -173,7 +173,6 @@ handler:							;\
 	l.sw    PT_GPR28(r1),r28					;\
 	l.sw    PT_GPR29(r1),r29					;\
 	/* r30 already save */					;\
-/*        l.sw    PT_GPR30(r1),r30*/					;\
 	l.sw    PT_GPR31(r1),r31					;\
 	TRACE_IRQS_OFF_ENTRY						;\
 	/* Store -1 in orig_gpr11 for non-syscall exceptions */	;\
@@ -211,9 +210,8 @@ handler:							;\
 	l.sw    PT_GPR27(r1),r27					;\
 	l.sw    PT_GPR28(r1),r28					;\
 	l.sw    PT_GPR29(r1),r29					;\
-	/* r31 already saved */					;\
-	l.sw    PT_GPR30(r1),r30					;\
-/*        l.sw    PT_GPR31(r1),r31	*/				;\
+	/* r30 already saved */						;\
+	l.sw    PT_GPR31(r1),r31					;\
 	/* Store -1 in orig_gpr11 for non-syscall exceptions */	;\
 	l.addi	r30,r0,-1					;\
 	l.sw	PT_ORIG_GPR11(r1),r30				;\
diff --git a/arch/parisc/kernel/real2.S b/arch/parisc/kernel/real2.S
index 2b16d8d6598f..c37010a13586 100644
--- a/arch/parisc/kernel/real2.S
+++ b/arch/parisc/kernel/real2.S
@@ -248,9 +248,6 @@ ENTRY_CFI(real64_call_asm)
 	/* save fn */
 	copy	%arg2, %r31
 
-	/* set up the new ap */
-	ldo	64(%arg1), %r29
-
 	/* load up the arg registers from the saved arg area */
 	/* 32-bit calling convention passes first 4 args in registers */
 	ldd	0*REG_SZ(%arg1), %arg0		/* note overwriting arg0 */
@@ -262,7 +259,9 @@ ENTRY_CFI(real64_call_asm)
 	ldd	7*REG_SZ(%arg1), %r19
 	ldd	1*REG_SZ(%arg1), %arg1		/* do this one last! */
 
+	/* set up real-mode stack and real-mode ap */
 	tophys_r1 %sp
+	ldo	-16(%sp), %r29			/* Reference param save area */
 
 	b,l	rfi_virt2real,%r2
 	nop
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 2dae702e7a5a..a4cd2484dbca 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -415,7 +415,7 @@ static char *__fetch_rtas_last_error(char *altbuf)
 				buf = kmalloc(RTAS_ERROR_LOG_MAX, GFP_ATOMIC);
 		}
 		if (buf)
-			memcpy(buf, rtas_err_buf, RTAS_ERROR_LOG_MAX);
+			memmove(buf, rtas_err_buf, RTAS_ERROR_LOG_MAX);
 	}
 
 	return buf;
diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index 30342b60aa63..42c3d40355d9 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -984,7 +984,7 @@ static void mpc5121_clk_provide_migration_support(void)
 
 #define NODE_PREP do { \
 	of_address_to_resource(np, 0, &res); \
-	snprintf(devname, sizeof(devname), "%08x.%s", res.start, np->name); \
+	snprintf(devname, sizeof(devname), "%pa.%s", &res.start, np->name); \
 } while (0)
 
 #define NODE_CHK(clkname, clkitem, regnode, regflag) do { \
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index 609bda2ad5dd..4d9200bdba78 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -145,7 +145,7 @@ static struct irq_domain * __init flipper_pic_init(struct device_node *np)
 	}
 	io_base = ioremap(res.start, resource_size(&res));
 
-	pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
+	pr_info("controller at 0x%pa mapped to 0x%p\n", &res.start, io_base);
 
 	__flipper_quiesce(io_base);
 
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index a4b020e4b6af..132e5c175e2d 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -171,7 +171,7 @@ static struct irq_domain *hlwd_pic_init(struct device_node *np)
 		return NULL;
 	}
 
-	pr_info("controller at 0x%08x mapped to 0x%p\n", res.start, io_base);
+	pr_info("controller at 0x%pa mapped to 0x%p\n", &res.start, io_base);
 
 	__hlwd_quiesce(io_base);
 
diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
index a802ef957d63..458a63a30e80 100644
--- a/arch/powerpc/platforms/embedded6xx/wii.c
+++ b/arch/powerpc/platforms/embedded6xx/wii.c
@@ -89,8 +89,8 @@ static void __iomem *wii_ioremap_hw_regs(char *name, char *compatible)
 
 	hw_regs = ioremap(res.start, resource_size(&res));
 	if (hw_regs) {
-		pr_info("%s at 0x%08x mapped to 0x%p\n", name,
-			res.start, hw_regs);
+		pr_info("%s at 0x%pa mapped to 0x%p\n", name,
+			&res.start, hw_regs);
 	}
 
 out_put:
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 042bb38fa5c2..a06297aa3f1b 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -216,9 +216,8 @@ int __init tsi108_setup_pci(struct device_node *dev, u32 cfg_phys, int primary)
 
 	(hose)->ops = &tsi108_direct_pci_ops;
 
-	printk(KERN_INFO "Found tsi108 PCI host bridge at 0x%08x. "
-	       "Firmware bus number: %d->%d\n",
-	       rsrc.start, hose->first_busno, hose->last_busno);
+	pr_info("Found tsi108 PCI host bridge at 0x%pa. Firmware bus number: %d->%d\n",
+		&rsrc.start, hose->first_busno, hose->last_busno);
 
 	/* Interpret the "ranges" property */
 	/* This also maps the I/O region and sets isa_io/mem_base */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e800d7981e99..f3a3a3ebebf5 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -569,8 +569,7 @@ static void __init create_kernel_page_table(pgd_t *pgdir, bool early)
  * this means 2 PMD entries whereas for 32-bit kernel, this is only 1 PGDIR
  * entry.
  */
-static void __init create_fdt_early_page_table(pgd_t *pgdir,
-					       uintptr_t fix_fdt_va,
+static void __init create_fdt_early_page_table(uintptr_t fix_fdt_va,
 					       uintptr_t dtb_pa)
 {
 	uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);
@@ -678,8 +677,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	create_kernel_page_table(early_pg_dir, true);
 
 	/* Setup early mapping for FDT early scan */
-	create_fdt_early_page_table(early_pg_dir,
-				    __fix_to_virt(FIX_FDT), dtb_pa);
+	create_fdt_early_page_table(__fix_to_virt(FIX_FDT), dtb_pa);
 
 	/*
 	 * Bootime fixmap only can handle PMD_SIZE mapping. Thus, boot-ioremap
diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index d432164b23b7..c31ec0fea300 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -381,7 +381,7 @@ static int __init sq_api_init(void)
 	if (unlikely(!sq_cache))
 		return ret;
 
-	sq_bitmap = kzalloc(size, GFP_KERNEL);
+	sq_bitmap = kcalloc(size, sizeof(long), GFP_KERNEL);
 	if (unlikely(!sq_bitmap))
 		goto out;
 
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index b8e7ea9e71e2..fc12d970a07c 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -115,6 +115,8 @@
 
 #define INTEL_FAM6_LUNARLAKE_M		0xBD
 
+#define INTEL_FAM6_ARROWLAKE		0xC6
+
 /* "Small Core" Processors (Atom/E-Core) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index ed7d9cf71f68..4df7d694369a 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -412,10 +412,9 @@ static unsigned int reserve_eilvt_offset(int offset, unsigned int new)
 		if (vector && !eilvt_entry_is_changeable(vector, new))
 			/* may not change if vectors are different */
 			return rsvd;
-		rsvd = atomic_cmpxchg(&eilvt_offsets[offset], rsvd, new);
-	} while (rsvd != new);
+	} while (!atomic_try_cmpxchg(&eilvt_offsets[offset], &rsvd, new));
 
-	rsvd &= ~APIC_EILVT_MASKED;
+	rsvd = new & ~APIC_EILVT_MASKED;
 	if (rsvd && rsvd != vector)
 		pr_info("LVT offset %d assigned for vector 0x%02x\n",
 			offset, rsvd);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index c1bb384935b0..bb71b628edcb 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2479,17 +2479,21 @@ static int io_apic_get_redir_entries(int ioapic)
 
 unsigned int arch_dynirq_lower_bound(unsigned int from)
 {
+	unsigned int ret;
+
 	/*
 	 * dmar_alloc_hwirq() may be called before setup_IO_APIC(), so use
 	 * gsi_top if ioapic_dynirq_base hasn't been initialized yet.
 	 */
-	if (!ioapic_initialized)
-		return gsi_top;
+	ret = ioapic_dynirq_base ? : gsi_top;
+
 	/*
-	 * For DT enabled machines ioapic_dynirq_base is irrelevant and not
-	 * updated. So simply return @from if ioapic_dynirq_base == 0.
+	 * For DT enabled machines ioapic_dynirq_base is irrelevant and
+	 * always 0. gsi_top can be 0 if there is no IO/APIC registered.
+	 * 0 is an invalid interrupt number for dynamic allocations. Return
+	 * @from instead.
 	 */
-	return ioapic_dynirq_base ? : from;
+	return ret ? : from;
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6469d3135d26..d4e75be64a4c 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -210,10 +210,10 @@ static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
  * A list of the banks enabled on each logical CPU. Controls which respective
  * descriptors to initialize later in mce_threshold_create_device().
  */
-static DEFINE_PER_CPU(unsigned int, bank_map);
+static DEFINE_PER_CPU(u64, bank_map);
 
 /* Map of banks that have more than MCA_MISC0 available. */
-static DEFINE_PER_CPU(u32, smca_misc_banks_map);
+static DEFINE_PER_CPU(u64, smca_misc_banks_map);
 
 static void amd_threshold_interrupt(void);
 static void amd_deferred_error_interrupt(void);
@@ -242,7 +242,7 @@ static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
 		return;
 
 	if (low & MASK_BLKPTR_LO)
-		per_cpu(smca_misc_banks_map, cpu) |= BIT(bank);
+		per_cpu(smca_misc_banks_map, cpu) |= BIT_ULL(bank);
 
 }
 
@@ -505,7 +505,7 @@ static u32 smca_get_block_address(unsigned int bank, unsigned int block,
 	if (!block)
 		return MSR_AMD64_SMCA_MCx_MISC(bank);
 
-	if (!(per_cpu(smca_misc_banks_map, cpu) & BIT(bank)))
+	if (!(per_cpu(smca_misc_banks_map, cpu) & BIT_ULL(bank)))
 		return 0;
 
 	return MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
@@ -549,7 +549,7 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 	int new;
 
 	if (!block)
-		per_cpu(bank_map, cpu) |= (1 << bank);
+		per_cpu(bank_map, cpu) |= BIT_ULL(bank);
 
 	memset(&b, 0, sizeof(b));
 	b.cpu			= cpu;
@@ -1061,7 +1061,7 @@ static void amd_threshold_interrupt(void)
 		return;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
-		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
+		if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
 			continue;
 
 		first_block = bp[bank]->blocks;
@@ -1538,7 +1538,7 @@ int mce_threshold_create_device(unsigned int cpu)
 		return -ENOMEM;
 
 	for (bank = 0; bank < numbanks; ++bank) {
-		if (!(this_cpu_read(bank_map) & (1 << bank)))
+		if (!(this_cpu_read(bank_map) & BIT_ULL(bank)))
 			continue;
 		err = threshold_create_bank(bp, cpu, bank);
 		if (err) {
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index ba0efc30fac5..8d3c649a1769 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -289,12 +289,16 @@ static void __init ms_hyperv_init_platform(void)
 	 * To mirror what Windows does we should extract CPU management
 	 * features and use the ReservedIdentityBit to detect if Linux is the
 	 * root partition. But that requires negotiating CPU management
-	 * interface (a process to be finalized).
+	 * interface (a process to be finalized). For now, use the privilege
+	 * flag as the indicator for running as root.
 	 *
-	 * For now, use the privilege flag as the indicator for running as
-	 * root.
+	 * Hyper-V should never specify running as root and as a Confidential
+	 * VM. But to protect against a compromised/malicious Hyper-V trying
+	 * to exploit root behavior to expose Confidential VM memory, ignore
+	 * the root partition setting if also a Confidential VM.
 	 */
-	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_CPU_MANAGEMENT) {
+	if ((ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
+	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
 		hv_root_partition = true;
 		pr_info("Hyper-V: running as root partition\n");
 	}
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c95c3675e8d5..ec56ed91b503 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7493,6 +7493,21 @@ static int vmx_check_intercept(struct kvm_vcpu *vcpu,
 		/* FIXME: produce nested vmexit and return X86EMUL_INTERCEPTED.  */
 		break;
 
+	case x86_intercept_pause:
+		/*
+		 * PAUSE is a single-byte NOP with a REPE prefix, i.e. collides
+		 * with vanilla NOPs in the emulator.  Apply the interception
+		 * check only to actual PAUSE instructions.  Don't check
+		 * PAUSE-loop-exiting, software can't expect a given PAUSE to
+		 * exit, i.e. KVM is within its rights to allow L2 to execute
+		 * the PAUSE.
+		 */
+		if ((info->rep_prefix != REPE_PREFIX) ||
+		    !nested_cpu_has2(vmcs12, CPU_BASED_PAUSE_EXITING))
+			return X86EMUL_CONTINUE;
+
+		break;
+
 	/* TODO: check more intercepts... */
 	default:
 		break;
diff --git a/block/blk-core.c b/block/blk-core.c
index ed6271dcc1b1..0c4a4e42ad87 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1421,6 +1421,13 @@ bool blk_update_request(struct request *req, blk_status_t error,
 		req->q->integrity.profile->complete_fn(req, nr_bytes);
 #endif
 
+	/*
+	 * Upper layers may call blk_crypto_evict_key() anytime after the last
+	 * bio_endio().  Therefore, the keyslot must be released before that.
+	 */
+	if (blk_crypto_rq_has_keyslot(req) && nr_bytes >= blk_rq_bytes(req))
+		__blk_crypto_rq_put_keyslot(req);
+
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
 		     !(req->rq_flags & RQF_QUIET)))
 		print_req_error(req, error, __func__);
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 0d36aae538d7..8e0834557620 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -60,6 +60,11 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return rq->crypt_ctx;
 }
 
+static inline bool blk_crypto_rq_has_keyslot(struct request *rq)
+{
+	return rq->crypt_keyslot;
+}
+
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 static inline bool bio_crypt_rq_ctx_compatible(struct request *rq,
@@ -93,6 +98,11 @@ static inline bool blk_crypto_rq_is_encrypted(struct request *rq)
 	return false;
 }
 
+static inline bool blk_crypto_rq_has_keyslot(struct request *rq)
+{
+	return false;
+}
+
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 void __bio_crypt_advance(struct bio *bio, unsigned int bytes);
@@ -127,14 +137,21 @@ static inline bool blk_crypto_bio_prep(struct bio **bio_ptr)
 	return true;
 }
 
-blk_status_t __blk_crypto_init_request(struct request *rq);
-static inline blk_status_t blk_crypto_init_request(struct request *rq)
+blk_status_t __blk_crypto_rq_get_keyslot(struct request *rq);
+static inline blk_status_t blk_crypto_rq_get_keyslot(struct request *rq)
 {
 	if (blk_crypto_rq_is_encrypted(rq))
-		return __blk_crypto_init_request(rq);
+		return __blk_crypto_rq_get_keyslot(rq);
 	return BLK_STS_OK;
 }
 
+void __blk_crypto_rq_put_keyslot(struct request *rq);
+static inline void blk_crypto_rq_put_keyslot(struct request *rq)
+{
+	if (blk_crypto_rq_has_keyslot(rq))
+		__blk_crypto_rq_put_keyslot(rq);
+}
+
 void __blk_crypto_free_request(struct request *rq);
 static inline void blk_crypto_free_request(struct request *rq)
 {
@@ -173,7 +190,7 @@ static inline blk_status_t blk_crypto_insert_cloned_request(struct request *rq)
 {
 
 	if (blk_crypto_rq_is_encrypted(rq))
-		return blk_crypto_init_request(rq);
+		return blk_crypto_rq_get_keyslot(rq);
 	return BLK_STS_OK;
 }
 
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 103c2e2d50d6..5029a50807d5 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -13,6 +13,7 @@
 #include <linux/blkdev.h>
 #include <linux/keyslot-manager.h>
 #include <linux/module.h>
+#include <linux/ratelimit.h>
 #include <linux/slab.h>
 
 #include "blk-crypto-internal.h"
@@ -216,26 +217,26 @@ static bool bio_crypt_check_alignment(struct bio *bio)
 	return true;
 }
 
-blk_status_t __blk_crypto_init_request(struct request *rq)
+blk_status_t __blk_crypto_rq_get_keyslot(struct request *rq)
 {
 	return blk_ksm_get_slot_for_key(rq->q->ksm, rq->crypt_ctx->bc_key,
 					&rq->crypt_keyslot);
 }
 
-/**
- * __blk_crypto_free_request - Uninitialize the crypto fields of a request.
- *
- * @rq: The request whose crypto fields to uninitialize.
- *
- * Completely uninitializes the crypto fields of a request. If a keyslot has
- * been programmed into some inline encryption hardware, that keyslot is
- * released. The rq->crypt_ctx is also freed.
- */
-void __blk_crypto_free_request(struct request *rq)
+void __blk_crypto_rq_put_keyslot(struct request *rq)
 {
 	blk_ksm_put_slot(rq->crypt_keyslot);
+	rq->crypt_keyslot = NULL;
+}
+
+void __blk_crypto_free_request(struct request *rq)
+{
+	/* The keyslot, if one was needed, should have been released earlier. */
+	if (WARN_ON_ONCE(rq->crypt_keyslot))
+		__blk_crypto_rq_put_keyslot(rq);
+
 	mempool_free(rq->crypt_ctx, bio_crypt_ctx_pool);
-	blk_crypto_rq_set_defaults(rq);
+	rq->crypt_ctx = NULL;
 }
 
 /**
@@ -384,29 +385,39 @@ int blk_crypto_start_using_key(const struct blk_crypto_key *key,
 }
 
 /**
- * blk_crypto_evict_key() - Evict a key from any inline encryption hardware
- *			    it may have been programmed into
- * @q: The request queue who's associated inline encryption hardware this key
- *     might have been programmed into
- * @key: The key to evict
+ * blk_crypto_evict_key() - Evict a blk_crypto_key from a request_queue
+ * @q: a request_queue on which I/O using the key may have been done
+ * @key: the key to evict
  *
- * Upper layers (filesystems) must call this function to ensure that a key is
- * evicted from any hardware that it might have been programmed into.  The key
- * must not be in use by any in-flight IO when this function is called.
+ * For a given request_queue, this function removes the given blk_crypto_key
+ * from the keyslot management structures and evicts it from any underlying
+ * hardware keyslot(s) or blk-crypto-fallback keyslot it may have been
+ * programmed into.
  *
- * Return: 0 on success or if key is not present in the q's ksm, -err on error.
+ * Upper layers must call this before freeing the blk_crypto_key.  It must be
+ * called for every request_queue the key may have been used on.  The key must
+ * no longer be in use by any I/O when this function is called.
+ *
+ * Context: May sleep.
  */
-int blk_crypto_evict_key(struct request_queue *q,
-			 const struct blk_crypto_key *key)
+void blk_crypto_evict_key(struct request_queue *q,
+			  const struct blk_crypto_key *key)
 {
-	if (blk_ksm_crypto_cfg_supported(q->ksm, &key->crypto_cfg))
-		return blk_ksm_evict_key(q->ksm, key);
+	int err;
 
+	if (blk_ksm_crypto_cfg_supported(q->ksm, &key->crypto_cfg))
+		err = blk_ksm_evict_key(q->ksm, key);
+	else
+		err = blk_crypto_fallback_evict_key(key);
 	/*
-	 * If the request queue's associated inline encryption hardware didn't
-	 * have support for the key, then the key might have been programmed
-	 * into the fallback keyslot manager, so try to evict from there.
+	 * An error can only occur here if the key failed to be evicted from a
+	 * keyslot (due to a hardware or driver issue) or is allegedly still in
+	 * use by I/O (due to a kernel bug).  Even in these cases, the key is
+	 * still unlinked from the keyslot management structures, and the caller
+	 * is allowed and expected to free it right away.  There's nothing
+	 * callers can do to handle errors, so just log them and return void.
 	 */
-	return blk_crypto_fallback_evict_key(key);
+	if (err)
+		pr_warn_ratelimited("error %d evicting key\n", err);
 }
 EXPORT_SYMBOL_GPL(blk_crypto_evict_key);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index d1435b657297..1affc5fd35f0 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -818,6 +818,8 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (!blk_discard_mergable(req))
 		elv_merge_requests(q, req, next);
 
+	blk_crypto_rq_put_keyslot(next);
+
 	/*
 	 * 'next' is going away, so update stats accordingly
 	 */
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 01e281801453..bbbbcd2c1941 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2228,7 +2228,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 
 	blk_mq_bio_to_request(rq, bio, nr_segs);
 
-	ret = blk_crypto_init_request(rq);
+	ret = blk_crypto_rq_get_keyslot(rq);
 	if (ret != BLK_STS_OK) {
 		bio->bi_status = ret;
 		bio_endio(bio);
diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 2c4a55bea6ca..2a7a36551cfa 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -343,25 +343,16 @@ bool blk_ksm_crypto_cfg_supported(struct blk_keyslot_manager *ksm,
 	return true;
 }
 
-/**
- * blk_ksm_evict_key() - Evict a key from the lower layer device.
- * @ksm: The keyslot manager to evict from
- * @key: The key to evict
- *
- * Find the keyslot that the specified key was programmed into, and evict that
- * slot from the lower layer device. The slot must not be in use by any
- * in-flight IO when this function is called.
- *
- * Context: Process context. Takes and releases ksm->lock.
- * Return: 0 on success or if there's no keyslot with the specified key, -EBUSY
- *	   if the keyslot is still in use, or another -errno value on other
- *	   error.
+/*
+ * This is an internal function that evicts a key from an inline encryption
+ * device that can be either a real device or the blk-crypto-fallback "device".
+ * It is used only by blk_crypto_evict_key(); see that function for details.
  */
 int blk_ksm_evict_key(struct blk_keyslot_manager *ksm,
 		      const struct blk_crypto_key *key)
 {
 	struct blk_ksm_keyslot *slot;
-	int err = 0;
+	int err;
 
 	if (blk_ksm_is_passthrough(ksm)) {
 		if (ksm->ksm_ll_ops.keyslot_evict) {
@@ -375,22 +366,30 @@ int blk_ksm_evict_key(struct blk_keyslot_manager *ksm,
 
 	blk_ksm_hw_enter(ksm);
 	slot = blk_ksm_find_keyslot(ksm, key);
-	if (!slot)
-		goto out_unlock;
+	if (!slot) {
+		/*
+		 * Not an error, since a key not in use by I/O is not guaranteed
+		 * to be in a keyslot.  There can be more keys than keyslots.
+		 */
+		err = 0;
+		goto out;
+	}
 
 	if (WARN_ON_ONCE(atomic_read(&slot->slot_refs) != 0)) {
+		/* BUG: key is still in use by I/O */
 		err = -EBUSY;
-		goto out_unlock;
+		goto out_remove;
 	}
 	err = ksm->ksm_ll_ops.keyslot_evict(ksm, key,
 					    blk_ksm_get_slot_idx(slot));
-	if (err)
-		goto out_unlock;
-
+out_remove:
+	/*
+	 * Callers free the key even on error, so unlink the key from the hash
+	 * table and clear slot->key even on error.
+	 */
 	hlist_del(&slot->hash_node);
 	slot->key = NULL;
-	err = 0;
-out_unlock:
+out:
 	blk_ksm_hw_exit(ksm);
 	return err;
 }
diff --git a/crypto/algapi.c b/crypto/algapi.c
index f3d95af3e428..c1af76ec65f5 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -456,7 +456,9 @@ void crypto_unregister_alg(struct crypto_alg *alg)
 	if (WARN(ret, "Algorithm %s is not registered", alg->cra_driver_name))
 		return;
 
-	BUG_ON(refcount_read(&alg->cra_refcnt) != 1);
+	if (WARN_ON(refcount_read(&alg->cra_refcnt) != 1))
+		return;
+
 	if (alg->cra_destroy)
 		alg->cra_destroy(alg);
 
diff --git a/crypto/drbg.c b/crypto/drbg.c
index 761104e93d44..44b0a7f62402 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1516,6 +1516,14 @@ static int drbg_prepare_hrng(struct drbg_state *drbg)
 		return 0;
 
 	drbg->jent = crypto_alloc_rng("jitterentropy_rng", 0, 0);
+	if (IS_ERR(drbg->jent)) {
+		const int err = PTR_ERR(drbg->jent);
+
+		drbg->jent = NULL;
+		if (fips_enabled)
+			return err;
+		pr_info("DRBG: Continuing without Jitter RNG\n");
+	}
 
 	return 0;
 }
@@ -1571,14 +1579,6 @@ static int drbg_instantiate(struct drbg_state *drbg, struct drbg_string *pers,
 		if (ret)
 			goto free_everything;
 
-		if (IS_ERR(drbg->jent)) {
-			ret = PTR_ERR(drbg->jent);
-			drbg->jent = NULL;
-			if (fips_enabled || ret != -ENOENT)
-				goto free_everything;
-			pr_info("DRBG: Continuing without Jitter RNG\n");
-		}
-
 		reseed = false;
 	}
 
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 8c3f82c9fff3..18fb04523f93 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -14,6 +14,8 @@
 #include <linux/acpi.h>
 #include <acpi/processor.h>
 
+#include <xen/xen.h>
+
 #include "internal.h"
 
 static bool __init processor_physically_present(acpi_handle handle)
@@ -47,6 +49,15 @@ static bool __init processor_physically_present(acpi_handle handle)
 		return false;
 	}
 
+	if (xen_initial_domain())
+		/*
+		 * When running as a Xen dom0 the number of processors Linux
+		 * sees can be different from the real number of processors on
+		 * the system, and we still need to execute _PDC for all of
+		 * them.
+		 */
+		return xen_processor_present(acpi_id);
+
 	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
 	cpuid = acpi_get_cpuid(handle, type, acpi_id);
 
diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index 647f11cf165d..fe4b66dae01b 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -329,6 +329,7 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
 {
 	u32 epid;
 	struct viot_endpoint *ep;
+	struct device *aliased_dev = data;
 	u32 domain_nr = pci_domain_nr(pdev->bus);
 
 	list_for_each_entry(ep, &viot_pci_ranges, list) {
@@ -339,7 +340,7 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
 			epid = ((domain_nr - ep->segment_start) << 16) +
 				dev_id - ep->bdf_start + ep->endpoint_id;
 
-			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
+			return viot_dev_iommu_init(aliased_dev, ep->viommu,
 						   epid);
 		}
 	}
@@ -373,7 +374,7 @@ int viot_iommu_configure(struct device *dev)
 {
 	if (dev_is_pci(dev))
 		return pci_for_each_dma_alias(to_pci_dev(dev),
-					      viot_pci_dev_iommu_init, NULL);
+					      viot_pci_dev_iommu_init, dev);
 	else if (dev_is_platform(dev))
 		return viot_mmio_dev_iommu_init(to_platform_device(dev));
 	return -ENODEV;
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 55405ebf23ab..450dca235a2f 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -487,7 +487,8 @@ static const struct attribute_group *cpu_root_attr_groups[] = {
 bool cpu_is_hotpluggable(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
-	return dev && container_of(dev, struct cpu, dev)->hotpluggable;
+	return dev && container_of(dev, struct cpu, dev)->hotpluggable
+		&& tick_nohz_cpu_hotpluggable(cpu);
 }
 EXPORT_SYMBOL_GPL(cpu_is_hotpluggable);
 
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 652531f67135..ac5cf1a8d79a 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1427,7 +1427,9 @@ static void platform_remove(struct device *_dev)
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
 
-	if (drv->remove) {
+	if (drv->remove_new) {
+		drv->remove_new(dev);
+	} else if (drv->remove) {
 		int ret = drv->remove(dev);
 
 		if (ret)
diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 7050a16e7efe..199e8f7d426d 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -352,7 +352,6 @@ static void btsdio_remove(struct sdio_func *func)
 
 	BT_DBG("func %p", func);
 
-	cancel_work_sync(&data->work);
 	if (!data)
 		return;
 
diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
index 249b31197eea..8298a4dd0de6 100644
--- a/drivers/char/ipmi/Kconfig
+++ b/drivers/char/ipmi/Kconfig
@@ -153,7 +153,8 @@ config IPMI_KCS_BMC_SERIO
 
 config ASPEED_BT_IPMI_BMC
 	depends on ARCH_ASPEED || COMPILE_TEST
-	depends on REGMAP && REGMAP_MMIO && MFD_SYSCON
+	depends on MFD_SYSCON
+	select REGMAP_MMIO
 	tristate "BT IPMI bmc driver"
 	help
 	  Provides a driver for the BT (Block Transfer) IPMI interface
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 20dc2452815c..a3745fa643f3 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -564,8 +564,10 @@ static void retry_timeout(struct timer_list *t)
 
 	if (waiting)
 		start_get(ssif_info);
-	if (resend)
+	if (resend) {
 		start_resend(ssif_info);
+		ssif_inc_stat(ssif_info, send_retries);
+	}
 }
 
 static void watch_timeout(struct timer_list *t)
@@ -792,9 +794,9 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
 		} else if (data[0] != (IPMI_NETFN_APP_REQUEST | 1) << 2
 			   || data[1] != IPMI_GET_MSG_FLAGS_CMD) {
 			/*
-			 * Don't abort here, maybe it was a queued
-			 * response to a previous command.
+			 * Recv error response, give up.
 			 */
+			ssif_info->ssif_state = SSIF_IDLE;
 			ipmi_ssif_unlock_cond(ssif_info, flags);
 			dev_warn(&ssif_info->client->dev,
 				 "Invalid response getting flags: %x %x\n",
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index dc56b976d816..d65fff4e2ebe 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -136,16 +136,27 @@ static bool check_locality(struct tpm_chip *chip, int l)
 	return false;
 }
 
-static int release_locality(struct tpm_chip *chip, int l)
+static int __tpm_tis_relinquish_locality(struct tpm_tis_data *priv, int l)
+{
+	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
+
+	return 0;
+}
+
+static int tpm_tis_relinquish_locality(struct tpm_chip *chip, int l)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 
-	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
+	mutex_lock(&priv->locality_count_mutex);
+	priv->locality_count--;
+	if (priv->locality_count == 0)
+		__tpm_tis_relinquish_locality(priv, l);
+	mutex_unlock(&priv->locality_count_mutex);
 
 	return 0;
 }
 
-static int request_locality(struct tpm_chip *chip, int l)
+static int __tpm_tis_request_locality(struct tpm_chip *chip, int l)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	unsigned long stop, timeout;
@@ -186,6 +197,20 @@ static int request_locality(struct tpm_chip *chip, int l)
 	return -1;
 }
 
+static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
+{
+	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	int ret = 0;
+
+	mutex_lock(&priv->locality_count_mutex);
+	if (priv->locality_count == 0)
+		ret = __tpm_tis_request_locality(chip, l);
+	if (!ret)
+		priv->locality_count++;
+	mutex_unlock(&priv->locality_count_mutex);
+	return ret;
+}
+
 static u8 tpm_tis_status(struct tpm_chip *chip)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
@@ -638,7 +663,7 @@ static int probe_itpm(struct tpm_chip *chip)
 	if (vendor != TPM_VID_INTEL)
 		return 0;
 
-	if (request_locality(chip, 0) != 0)
+	if (tpm_tis_request_locality(chip, 0) != 0)
 		return -EBUSY;
 
 	rc = tpm_tis_send_data(chip, cmd_getticks, len);
@@ -659,7 +684,7 @@ static int probe_itpm(struct tpm_chip *chip)
 
 out:
 	tpm_tis_ready(chip);
-	release_locality(chip, priv->locality);
+	tpm_tis_relinquish_locality(chip, priv->locality);
 
 	return rc;
 }
@@ -714,25 +739,17 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
+static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
 {
 	const char *desc = "attempting to generate an interrupt";
 	u32 cap2;
 	cap_t cap;
 	int ret;
 
-	ret = request_locality(chip, 0);
-	if (ret < 0)
-		return ret;
-
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		ret = tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
 	else
 		ret = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc, 0);
-
-	release_locality(chip, 0);
-
-	return ret;
 }
 
 /* Register the IRQ and issue a command that will cause an interrupt. If an
@@ -755,52 +772,55 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
 	}
 	priv->irq = irq;
 
+	rc = tpm_tis_request_locality(chip, 0);
+	if (rc < 0)
+		return rc;
+
 	rc = tpm_tis_read8(priv, TPM_INT_VECTOR(priv->locality),
 			   &original_int_vec);
-	if (rc < 0)
+	if (rc < 0) {
+		tpm_tis_relinquish_locality(chip, priv->locality);
 		return rc;
+	}
 
 	rc = tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), irq);
 	if (rc < 0)
-		return rc;
+		goto restore_irqs;
 
 	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &int_status);
 	if (rc < 0)
-		return rc;
+		goto restore_irqs;
 
 	/* Clear all existing */
 	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), int_status);
 	if (rc < 0)
-		return rc;
-
+		goto restore_irqs;
 	/* Turn on */
 	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality),
 			     intmask | TPM_GLOBAL_INT_ENABLE);
 	if (rc < 0)
-		return rc;
+		goto restore_irqs;
 
 	priv->irq_tested = false;
 
 	/* Generate an interrupt by having the core call through to
 	 * tpm_tis_send
 	 */
-	rc = tpm_tis_gen_interrupt(chip);
-	if (rc < 0)
-		return rc;
+	tpm_tis_gen_interrupt(chip);
 
+restore_irqs:
 	/* tpm_tis_send will either confirm the interrupt is working or it
 	 * will call disable_irq which undoes all of the above.
 	 */
 	if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
-		rc = tpm_tis_write8(priv, original_int_vec,
-				TPM_INT_VECTOR(priv->locality));
-		if (rc < 0)
-			return rc;
-
-		return 1;
+		tpm_tis_write8(priv, original_int_vec,
+			       TPM_INT_VECTOR(priv->locality));
+		rc = -1;
 	}
 
-	return 0;
+	tpm_tis_relinquish_locality(chip, priv->locality);
+
+	return rc;
 }
 
 /* Try to find the IRQ the TPM is using. This is for legacy x86 systems that
@@ -914,8 +934,8 @@ static const struct tpm_class_ops tpm_tis = {
 	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
 	.req_canceled = tpm_tis_req_canceled,
-	.request_locality = request_locality,
-	.relinquish_locality = release_locality,
+	.request_locality = tpm_tis_request_locality,
+	.relinquish_locality = tpm_tis_relinquish_locality,
 	.clk_enable = tpm_tis_clkrun_enable,
 };
 
@@ -949,6 +969,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	priv->timeout_min = TPM_TIMEOUT_USECS_MIN;
 	priv->timeout_max = TPM_TIMEOUT_USECS_MAX;
 	priv->phy_ops = phy_ops;
+	priv->locality_count = 0;
+	mutex_init(&priv->locality_count_mutex);
 
 	dev_set_drvdata(&chip->dev, priv);
 
@@ -995,14 +1017,14 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		   TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
 	intmask &= ~TPM_GLOBAL_INT_ENABLE;
 
-	rc = request_locality(chip, 0);
+	rc = tpm_tis_request_locality(chip, 0);
 	if (rc < 0) {
 		rc = -ENODEV;
 		goto out_err;
 	}
 
 	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
-	release_locality(chip, 0);
+	tpm_tis_relinquish_locality(chip, 0);
 
 	rc = tpm_chip_start(chip);
 	if (rc)
@@ -1062,13 +1084,13 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		 * proper timeouts for the driver.
 		 */
 
-		rc = request_locality(chip, 0);
+		rc = tpm_tis_request_locality(chip, 0);
 		if (rc < 0)
 			goto out_err;
 
 		rc = tpm_get_timeouts(chip);
 
-		release_locality(chip, 0);
+		tpm_tis_relinquish_locality(chip, 0);
 
 		if (rc) {
 			dev_err(dev, "Could not get TPM timeouts and durations\n");
@@ -1076,17 +1098,21 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 			goto out_err;
 		}
 
-		if (irq) {
+		if (irq)
 			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
 						 irq);
-			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
-				dev_err(&chip->dev, FW_BUG
+		else
+			tpm_tis_probe_irq(chip, intmask);
+
+		if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
+			dev_err(&chip->dev, FW_BUG
 					"TPM interrupt not working, polling instead\n");
 
-				disable_interrupts(chip);
-			}
-		} else {
-			tpm_tis_probe_irq(chip, intmask);
+			rc = tpm_tis_request_locality(chip, 0);
+			if (rc < 0)
+				goto out_err;
+			disable_interrupts(chip);
+			tpm_tis_relinquish_locality(chip, 0);
 		}
 	}
 
@@ -1147,28 +1173,27 @@ int tpm_tis_resume(struct device *dev)
 	struct tpm_chip *chip = dev_get_drvdata(dev);
 	int ret;
 
+	ret = tpm_tis_request_locality(chip, 0);
+	if (ret < 0)
+		return ret;
+
 	if (chip->flags & TPM_CHIP_FLAG_IRQ)
 		tpm_tis_reenable_interrupts(chip);
 
 	ret = tpm_pm_resume(dev);
 	if (ret)
-		return ret;
+		goto out;
 
 	/*
 	 * TPM 1.2 requires self-test on resume. This function actually returns
 	 * an error code but for unknown reason it isn't handled.
 	 */
-	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
-		ret = request_locality(chip, 0);
-		if (ret < 0)
-			return ret;
-
+	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
 		tpm1_do_selftest(chip);
+out:
+	tpm_tis_relinquish_locality(chip, 0);
 
-		release_locality(chip, 0);
-	}
-
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(tpm_tis_resume);
 #endif
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 3be24f221e32..464ed352ab2e 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -90,6 +90,8 @@ enum tpm_tis_flags {
 
 struct tpm_tis_data {
 	u16 manufacturer_id;
+	struct mutex locality_count_mutex;
+	unsigned int locality_count;
 	int locality;
 	int irq;
 	bool irq_tested;
diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index 1f52409475e9..a6600afa2145 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -561,7 +561,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 
 		ret = sam9x60_frac_pll_compute_mul_frac(&frac->core, FCORE_MIN,
 							parent_rate, true);
-		if (ret <= 0) {
+		if (ret < 0) {
 			hw = ERR_PTR(ret);
 			goto free;
 		}
diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 2ef819606c41..1a4e6340f95c 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -33,9 +33,12 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 			else
 				return rc;
 		}
-		if (clkspec.np == node && !clk_supplier)
+		if (clkspec.np == node && !clk_supplier) {
+			of_node_put(clkspec.np);
 			return 0;
+		}
 		pclk = of_clk_get_from_provider(&clkspec);
+		of_node_put(clkspec.np);
 		if (IS_ERR(pclk)) {
 			if (PTR_ERR(pclk) != -EPROBE_DEFER)
 				pr_warn("clk: couldn't get parent clock %d for %pOF\n",
@@ -48,10 +51,12 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 		if (rc < 0)
 			goto err;
 		if (clkspec.np == node && !clk_supplier) {
+			of_node_put(clkspec.np);
 			rc = 0;
 			goto err;
 		}
 		clk = of_clk_get_from_provider(&clkspec);
+		of_node_put(clkspec.np);
 		if (IS_ERR(clk)) {
 			if (PTR_ERR(clk) != -EPROBE_DEFER)
 				pr_warn("clk: couldn't get assigned clock %d for %pOF\n",
@@ -93,10 +98,13 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 				else
 					return rc;
 			}
-			if (clkspec.np == node && !clk_supplier)
+			if (clkspec.np == node && !clk_supplier) {
+				of_node_put(clkspec.np);
 				return 0;
+			}
 
 			clk = of_clk_get_from_provider(&clkspec);
+			of_node_put(clkspec.np);
 			if (IS_ERR(clk)) {
 				if (PTR_ERR(clk) != -EPROBE_DEFER)
 					pr_warn("clk: couldn't get clock %d for %pOF\n",
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 9825ef843f4a..63c356ae32f2 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -11,6 +11,7 @@ clk-qcom-y += clk-branch.o
 clk-qcom-y += clk-regmap-divider.o
 clk-qcom-y += clk-regmap-mux.o
 clk-qcom-y += clk-regmap-mux-div.o
+clk-qcom-y += clk-regmap-phy-mux.o
 clk-qcom-$(CONFIG_KRAIT_CLOCKS) += clk-krait.o
 clk-qcom-y += clk-hfpll.o
 clk-qcom-y += reset.o
diff --git a/drivers/clk/qcom/clk-regmap-phy-mux.c b/drivers/clk/qcom/clk-regmap-phy-mux.c
new file mode 100644
index 000000000000..7b7243b7107d
--- /dev/null
+++ b/drivers/clk/qcom/clk-regmap-phy-mux.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Linaro Ltd.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/bitfield.h>
+#include <linux/regmap.h>
+#include <linux/export.h>
+
+#include "clk-regmap.h"
+#include "clk-regmap-phy-mux.h"
+
+#define PHY_MUX_MASK		GENMASK(1, 0)
+#define PHY_MUX_PHY_SRC		0
+#define PHY_MUX_REF_SRC		2
+
+static inline struct clk_regmap_phy_mux *to_clk_regmap_phy_mux(struct clk_regmap *clkr)
+{
+	return container_of(clkr, struct clk_regmap_phy_mux, clkr);
+}
+
+static int phy_mux_is_enabled(struct clk_hw *hw)
+{
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(clkr);
+	unsigned int val;
+
+	regmap_read(clkr->regmap, phy_mux->reg, &val);
+	val = FIELD_GET(PHY_MUX_MASK, val);
+
+	WARN_ON(val != PHY_MUX_PHY_SRC && val != PHY_MUX_REF_SRC);
+
+	return val == PHY_MUX_PHY_SRC;
+}
+
+static int phy_mux_enable(struct clk_hw *hw)
+{
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(clkr);
+
+	return regmap_update_bits(clkr->regmap, phy_mux->reg,
+				  PHY_MUX_MASK,
+				  FIELD_PREP(PHY_MUX_MASK, PHY_MUX_PHY_SRC));
+}
+
+static void phy_mux_disable(struct clk_hw *hw)
+{
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(clkr);
+
+	regmap_update_bits(clkr->regmap, phy_mux->reg,
+			   PHY_MUX_MASK,
+			   FIELD_PREP(PHY_MUX_MASK, PHY_MUX_REF_SRC));
+}
+
+const struct clk_ops clk_regmap_phy_mux_ops = {
+	.enable = phy_mux_enable,
+	.disable = phy_mux_disable,
+	.is_enabled = phy_mux_is_enabled,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_phy_mux_ops);
diff --git a/drivers/clk/qcom/clk-regmap-phy-mux.h b/drivers/clk/qcom/clk-regmap-phy-mux.h
new file mode 100644
index 000000000000..614dd384695c
--- /dev/null
+++ b/drivers/clk/qcom/clk-regmap-phy-mux.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022, Linaro Ltd.
+ */
+
+#ifndef __QCOM_CLK_REGMAP_PHY_MUX_H__
+#define __QCOM_CLK_REGMAP_PHY_MUX_H__
+
+#include "clk-regmap.h"
+
+/*
+ * A clock implementation for PHY pipe and symbols clock muxes.
+ *
+ * If the clock is running off the from-PHY source, report it as enabled.
+ * Report it as disabled otherwise (if it uses reference source).
+ *
+ * This way the PHY will disable the pipe clock before turning off the GDSC,
+ * which in turn would lead to disabling corresponding pipe_clk_src (and thus
+ * it being parked to a safe, reference clock source). And vice versa, after
+ * enabling the GDSC the PHY will enable the pipe clock, which would cause
+ * pipe_clk_src to be switched from a safe source to the working one.
+ *
+ * For some platforms this should be used for the UFS symbol_clk_src clocks
+ * too.
+ */
+struct clk_regmap_phy_mux {
+	u32			reg;
+	struct clk_regmap	clkr;
+};
+
+extern const struct clk_ops clk_regmap_phy_mux_ops;
+
+#endif
diff --git a/drivers/clk/qcom/gcc-sm6115.c b/drivers/clk/qcom/gcc-sm6115.c
index e24a977c2580..1c3be4e07d5b 100644
--- a/drivers/clk/qcom/gcc-sm6115.c
+++ b/drivers/clk/qcom/gcc-sm6115.c
@@ -720,7 +720,7 @@ static struct clk_rcg2 gcc_camss_axi_clk_src = {
 		.parent_data = gcc_parents_7,
 		.num_parents = ARRAY_SIZE(gcc_parents_7),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -741,7 +741,7 @@ static struct clk_rcg2 gcc_camss_cci_clk_src = {
 		.parent_data = gcc_parents_9,
 		.num_parents = ARRAY_SIZE(gcc_parents_9),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -764,7 +764,7 @@ static struct clk_rcg2 gcc_camss_csi0phytimer_clk_src = {
 		.parent_data = gcc_parents_4,
 		.num_parents = ARRAY_SIZE(gcc_parents_4),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -779,7 +779,7 @@ static struct clk_rcg2 gcc_camss_csi1phytimer_clk_src = {
 		.parent_data = gcc_parents_4,
 		.num_parents = ARRAY_SIZE(gcc_parents_4),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -794,7 +794,7 @@ static struct clk_rcg2 gcc_camss_csi2phytimer_clk_src = {
 		.parent_data = gcc_parents_4,
 		.num_parents = ARRAY_SIZE(gcc_parents_4),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -816,7 +816,7 @@ static struct clk_rcg2 gcc_camss_mclk0_clk_src = {
 		.parent_data = gcc_parents_3,
 		.num_parents = ARRAY_SIZE(gcc_parents_3),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -831,7 +831,7 @@ static struct clk_rcg2 gcc_camss_mclk1_clk_src = {
 		.parent_data = gcc_parents_3,
 		.num_parents = ARRAY_SIZE(gcc_parents_3),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -846,7 +846,7 @@ static struct clk_rcg2 gcc_camss_mclk2_clk_src = {
 		.parent_data = gcc_parents_3,
 		.num_parents = ARRAY_SIZE(gcc_parents_3),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -861,7 +861,7 @@ static struct clk_rcg2 gcc_camss_mclk3_clk_src = {
 		.parent_data = gcc_parents_3,
 		.num_parents = ARRAY_SIZE(gcc_parents_3),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -883,7 +883,7 @@ static struct clk_rcg2 gcc_camss_ope_ahb_clk_src = {
 		.parent_data = gcc_parents_8,
 		.num_parents = ARRAY_SIZE(gcc_parents_8),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -907,7 +907,7 @@ static struct clk_rcg2 gcc_camss_ope_clk_src = {
 		.parent_data = gcc_parents_8,
 		.num_parents = ARRAY_SIZE(gcc_parents_8),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -942,7 +942,7 @@ static struct clk_rcg2 gcc_camss_tfe_0_clk_src = {
 		.parent_data = gcc_parents_5,
 		.num_parents = ARRAY_SIZE(gcc_parents_5),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -967,7 +967,7 @@ static struct clk_rcg2 gcc_camss_tfe_0_csid_clk_src = {
 		.parent_data = gcc_parents_6,
 		.num_parents = ARRAY_SIZE(gcc_parents_6),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -982,7 +982,7 @@ static struct clk_rcg2 gcc_camss_tfe_1_clk_src = {
 		.parent_data = gcc_parents_5,
 		.num_parents = ARRAY_SIZE(gcc_parents_5),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -997,7 +997,7 @@ static struct clk_rcg2 gcc_camss_tfe_1_csid_clk_src = {
 		.parent_data = gcc_parents_6,
 		.num_parents = ARRAY_SIZE(gcc_parents_6),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1012,7 +1012,7 @@ static struct clk_rcg2 gcc_camss_tfe_2_clk_src = {
 		.parent_data = gcc_parents_5,
 		.num_parents = ARRAY_SIZE(gcc_parents_5),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1027,7 +1027,7 @@ static struct clk_rcg2 gcc_camss_tfe_2_csid_clk_src = {
 		.parent_data = gcc_parents_6,
 		.num_parents = ARRAY_SIZE(gcc_parents_6),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1050,7 +1050,7 @@ static struct clk_rcg2 gcc_camss_tfe_cphy_rx_clk_src = {
 		.parent_data = gcc_parents_10,
 		.num_parents = ARRAY_SIZE(gcc_parents_10),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1072,7 +1072,7 @@ static struct clk_rcg2 gcc_camss_top_ahb_clk_src = {
 		.parent_data = gcc_parents_7,
 		.num_parents = ARRAY_SIZE(gcc_parents_7),
 		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1142,7 +1142,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
 		.name = "gcc_pdm2_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1355,7 +1355,7 @@ static struct clk_rcg2 gcc_ufs_phy_axi_clk_src = {
 		.name = "gcc_ufs_phy_axi_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1377,7 +1377,7 @@ static struct clk_rcg2 gcc_ufs_phy_ice_core_clk_src = {
 		.name = "gcc_ufs_phy_ice_core_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1418,7 +1418,7 @@ static struct clk_rcg2 gcc_ufs_phy_unipro_core_clk_src = {
 		.name = "gcc_ufs_phy_unipro_core_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1440,7 +1440,7 @@ static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
 		.name = "gcc_usb30_prim_master_clk_src",
 		.parent_data = gcc_parents_0,
 		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -1509,7 +1509,7 @@ static struct clk_rcg2 gcc_video_venus_clk_src = {
 		.parent_data = gcc_parents_13,
 		.num_parents = ARRAY_SIZE(gcc_parents_13),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sm8350.c b/drivers/clk/qcom/gcc-sm8350.c
index 6d0a9e2d5104..87d03b1684ed 100644
--- a/drivers/clk/qcom/gcc-sm8350.c
+++ b/drivers/clk/qcom/gcc-sm8350.c
@@ -16,6 +16,7 @@
 #include "clk-regmap.h"
 #include "clk-regmap-divider.h"
 #include "clk-regmap-mux.h"
+#include "clk-regmap-phy-mux.h"
 #include "gdsc.h"
 #include "reset.h"
 
@@ -166,26 +167,6 @@ static const struct clk_parent_data gcc_parent_data_3[] = {
 	{ .fw_name = "core_bi_pll_test_se" },
 };
 
-static const struct parent_map gcc_parent_map_4[] = {
-	{ P_PCIE_0_PIPE_CLK, 0 },
-	{ P_BI_TCXO, 2 },
-};
-
-static const struct clk_parent_data gcc_parent_data_4[] = {
-	{ .fw_name = "pcie_0_pipe_clk", },
-	{ .fw_name = "bi_tcxo" },
-};
-
-static const struct parent_map gcc_parent_map_5[] = {
-	{ P_PCIE_1_PIPE_CLK, 0 },
-	{ P_BI_TCXO, 2 },
-};
-
-static const struct clk_parent_data gcc_parent_data_5[] = {
-	{ .fw_name = "pcie_1_pipe_clk" },
-	{ .fw_name = "bi_tcxo" },
-};
-
 static const struct parent_map gcc_parent_map_6[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_GCC_GPLL0_OUT_MAIN, 1 },
@@ -288,32 +269,30 @@ static const struct clk_parent_data gcc_parent_data_14[] = {
 	{ .fw_name = "bi_tcxo" },
 };
 
-static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
+static struct clk_regmap_phy_mux gcc_pcie_0_pipe_clk_src = {
 	.reg = 0x6b054,
-	.shift = 0,
-	.width = 2,
-	.parent_map = gcc_parent_map_4,
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_0_pipe_clk_src",
-			.parent_data = gcc_parent_data_4,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_4),
-			.ops = &clk_regmap_mux_closest_ops,
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "pcie_0_pipe_clk",
+			},
+			.num_parents = 1,
+			.ops = &clk_regmap_phy_mux_ops,
 		},
 	},
 };
 
-static struct clk_regmap_mux gcc_pcie_1_pipe_clk_src = {
+static struct clk_regmap_phy_mux gcc_pcie_1_pipe_clk_src = {
 	.reg = 0x8d054,
-	.shift = 0,
-	.width = 2,
-	.parent_map = gcc_parent_map_5,
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_1_pipe_clk_src",
-			.parent_data = gcc_parent_data_5,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_5),
-			.ops = &clk_regmap_mux_closest_ops,
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "pcie_1_pipe_clk",
+			},
+			.num_parents = 1,
+			.ops = &clk_regmap_phy_mux_ops,
 		},
 	},
 };
diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 62a4f2543960..6bcf631b4e4c 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1263,7 +1263,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKSEL_CON(56), 6, 2, MFLAGS,
 			RK3399_CLKGATE_CON(10), 7, GFLAGS),
 
-	COMPOSITE_NOGATE(SCLK_CIF_OUT, "clk_cifout", mux_clk_cif_p, 0,
+	COMPOSITE_NOGATE(SCLK_CIF_OUT, "clk_cifout", mux_clk_cif_p, CLK_SET_RATE_PARENT,
 			 RK3399_CLKSEL_CON(56), 5, 1, MFLAGS, 0, 5, DFLAGS),
 
 	/* gic */
diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index 9996c0542520..b1c248498be4 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -257,21 +257,25 @@ int __init davinci_timer_register(struct clk *clk,
 				resource_size(&timer_cfg->reg),
 				"davinci-timer")) {
 		pr_err("Unable to request memory region\n");
-		return -EBUSY;
+		rv = -EBUSY;
+		goto exit_clk_disable;
 	}
 
 	base = ioremap(timer_cfg->reg.start, resource_size(&timer_cfg->reg));
 	if (!base) {
 		pr_err("Unable to map the register range\n");
-		return -ENOMEM;
+		rv = -ENOMEM;
+		goto exit_mem_region;
 	}
 
 	davinci_timer_init(base);
 	tick_rate = clk_get_rate(clk);
 
 	clockevent = kzalloc(sizeof(*clockevent), GFP_KERNEL);
-	if (!clockevent)
-		return -ENOMEM;
+	if (!clockevent) {
+		rv = -ENOMEM;
+		goto exit_iounmap_base;
+	}
 
 	clockevent->dev.name = "tim12";
 	clockevent->dev.features = CLOCK_EVT_FEAT_ONESHOT;
@@ -296,7 +300,7 @@ int __init davinci_timer_register(struct clk *clk,
 			 "clockevent/tim12", clockevent);
 	if (rv) {
 		pr_err("Unable to request the clockevent interrupt\n");
-		return rv;
+		goto exit_free_clockevent;
 	}
 
 	davinci_clocksource.dev.rating = 300;
@@ -323,13 +327,27 @@ int __init davinci_timer_register(struct clk *clk,
 	rv = clocksource_register_hz(&davinci_clocksource.dev, tick_rate);
 	if (rv) {
 		pr_err("Unable to register clocksource\n");
-		return rv;
+		goto exit_free_irq;
 	}
 
 	sched_clock_register(davinci_timer_read_sched_clock,
 			     DAVINCI_TIMER_CLKSRC_BITS, tick_rate);
 
 	return 0;
+
+exit_free_irq:
+	free_irq(timer_cfg->irq[DAVINCI_TIMER_CLOCKEVENT_IRQ].start,
+			clockevent);
+exit_free_clockevent:
+	kfree(clockevent);
+exit_iounmap_base:
+	iounmap(base);
+exit_mem_region:
+	release_mem_region(timer_cfg->reg.start,
+			   resource_size(&timer_cfg->reg));
+exit_clk_disable:
+	clk_disable_unprepare(clk);
+	return rv;
 }
 
 static int __init of_davinci_timer_register(struct device_node *np)
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b998b5083953..ae7b95e15ac7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1709,7 +1709,7 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
 		 * MHz. In such cases it is better to avoid getting into
 		 * unnecessary frequency updates.
 		 */
-		if (abs(policy->cur - new_freq) < HZ_PER_MHZ)
+		if (abs(policy->cur - new_freq) < KHZ_PER_MHZ)
 			return policy->cur;
 
 		cpufreq_out_of_sync(policy, new_freq);
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index b46343b5c26b..a40883e11842 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -905,6 +905,7 @@ config CRYPTO_DEV_SA2UL
 	select CRYPTO_AES_ARM64
 	select CRYPTO_ALGAPI
 	select CRYPTO_AUTHENC
+	select CRYPTO_DES
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index f87aa2169e5f..f9a1ec3c8485 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -284,6 +284,10 @@ static int instantiate_rng(struct device *ctrldev, int state_handle_mask,
 		const u32 rdsta_if = RDSTA_IF0 << sh_idx;
 		const u32 rdsta_pr = RDSTA_PR0 << sh_idx;
 		const u32 rdsta_mask = rdsta_if | rdsta_pr;
+
+		/* Clear the contents before using the descriptor */
+		memset(desc, 0x00, CAAM_CMD_SZ * 7);
+
 		/*
 		 * If the corresponding bit is set, this state handle
 		 * was initialized by somebody else, so it's left alone.
@@ -327,8 +331,6 @@ static int instantiate_rng(struct device *ctrldev, int state_handle_mask,
 		}
 
 		dev_info(ctrldev, "Instantiated RNG4 SH%d\n", sh_idx);
-		/* Clear the contents before recreating the descriptor */
-		memset(desc, 0x00, CAAM_CMD_SZ * 7);
 	}
 
 	kfree(desc);
diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 389a7b51f1f3..7fa6c9144e49 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -1631,19 +1631,23 @@ static int safexcel_probe_generic(void *pdev,
 						     &priv->ring[i].rdr);
 		if (ret) {
 			dev_err(dev, "Failed to initialize rings\n");
-			return ret;
+			goto err_cleanup_rings;
 		}
 
 		priv->ring[i].rdr_req = devm_kcalloc(dev,
 			EIP197_DEFAULT_RING_SIZE,
 			sizeof(*priv->ring[i].rdr_req),
 			GFP_KERNEL);
-		if (!priv->ring[i].rdr_req)
-			return -ENOMEM;
+		if (!priv->ring[i].rdr_req) {
+			ret = -ENOMEM;
+			goto err_cleanup_rings;
+		}
 
 		ring_irq = devm_kzalloc(dev, sizeof(*ring_irq), GFP_KERNEL);
-		if (!ring_irq)
-			return -ENOMEM;
+		if (!ring_irq) {
+			ret = -ENOMEM;
+			goto err_cleanup_rings;
+		}
 
 		ring_irq->priv = priv;
 		ring_irq->ring = i;
@@ -1657,7 +1661,8 @@ static int safexcel_probe_generic(void *pdev,
 						ring_irq);
 		if (irq < 0) {
 			dev_err(dev, "Failed to get IRQ ID for ring %d\n", i);
-			return irq;
+			ret = irq;
+			goto err_cleanup_rings;
 		}
 
 		priv->ring[i].irq = irq;
@@ -1669,8 +1674,10 @@ static int safexcel_probe_generic(void *pdev,
 		snprintf(wq_name, 9, "wq_ring%d", i);
 		priv->ring[i].workqueue =
 			create_singlethread_workqueue(wq_name);
-		if (!priv->ring[i].workqueue)
-			return -ENOMEM;
+		if (!priv->ring[i].workqueue) {
+			ret = -ENOMEM;
+			goto err_cleanup_rings;
+		}
 
 		priv->ring[i].requests = 0;
 		priv->ring[i].busy = false;
@@ -1687,16 +1694,26 @@ static int safexcel_probe_generic(void *pdev,
 	ret = safexcel_hw_init(priv);
 	if (ret) {
 		dev_err(dev, "HW init failed (%d)\n", ret);
-		return ret;
+		goto err_cleanup_rings;
 	}
 
 	ret = safexcel_register_algorithms(priv);
 	if (ret) {
 		dev_err(dev, "Failed to register algorithms (%d)\n", ret);
-		return ret;
+		goto err_cleanup_rings;
 	}
 
 	return 0;
+
+err_cleanup_rings:
+	for (i = 0; i < priv->config.rings; i++) {
+		if (priv->ring[i].irq)
+			irq_set_affinity_hint(priv->ring[i].irq, NULL);
+		if (priv->ring[i].workqueue)
+			destroy_workqueue(priv->ring[i].workqueue);
+	}
+
+	return ret;
 }
 
 static void safexcel_hw_reset_rings(struct safexcel_crypto_priv *priv)
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index c5638afe9436..80c609aa2a91 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -243,6 +243,7 @@ struct at_xdmac {
 	int			irq;
 	struct clk		*clk;
 	u32			save_gim;
+	u32			save_gs;
 	struct dma_pool		*at_xdmac_desc_pool;
 	const struct at_xdmac_layout	*layout;
 	struct at_xdmac_chan	chan[];
@@ -1586,20 +1587,6 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	return ret;
 }
 
-/* Call must be protected by lock. */
-static void at_xdmac_remove_xfer(struct at_xdmac_chan *atchan,
-				    struct at_xdmac_desc *desc)
-{
-	dev_dbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
-
-	/*
-	 * Remove the transfer from the transfer list then move the transfer
-	 * descriptors into the free descriptors list.
-	 */
-	list_del(&desc->xfer_node);
-	list_splice_init(&desc->descs_list, &atchan->free_descs_list);
-}
-
 static void at_xdmac_advance_work(struct at_xdmac_chan *atchan)
 {
 	struct at_xdmac_desc	*desc;
@@ -1710,17 +1697,19 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 		}
 
 		txd = &desc->tx_dma_desc;
-
-		at_xdmac_remove_xfer(atchan, desc);
+		dma_cookie_complete(txd);
+		/* Remove the transfer from the transfer list. */
+		list_del(&desc->xfer_node);
 		spin_unlock_irq(&atchan->lock);
 
-		dma_cookie_complete(txd);
 		if (txd->flags & DMA_PREP_INTERRUPT)
 			dmaengine_desc_get_callback_invoke(txd, NULL);
 
 		dma_run_dependencies(txd);
 
 		spin_lock_irq(&atchan->lock);
+		/* Move the xfer descriptors into the free descriptors list. */
+		list_splice_init(&desc->descs_list, &atchan->free_descs_list);
 		at_xdmac_advance_work(atchan);
 		spin_unlock_irq(&atchan->lock);
 	}
@@ -1867,8 +1856,10 @@ static int at_xdmac_device_terminate_all(struct dma_chan *chan)
 		cpu_relax();
 
 	/* Cancel all pending transfers. */
-	list_for_each_entry_safe(desc, _desc, &atchan->xfers_list, xfer_node)
-		at_xdmac_remove_xfer(atchan, desc);
+	list_for_each_entry_safe(desc, _desc, &atchan->xfers_list, xfer_node) {
+		list_del(&desc->xfer_node);
+		list_splice_init(&desc->descs_list, &atchan->free_descs_list);
+	}
 
 	clear_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
 	clear_bit(AT_XDMAC_CHAN_IS_CYCLIC, &atchan->status);
@@ -1994,6 +1985,7 @@ static int atmel_xdmac_suspend(struct device *dev)
 		}
 	}
 	atxdmac->save_gim = at_xdmac_read(atxdmac, AT_XDMAC_GIM);
+	atxdmac->save_gs = at_xdmac_read(atxdmac, AT_XDMAC_GS);
 
 	at_xdmac_off(atxdmac);
 	clk_disable_unprepare(atxdmac->clk);
@@ -2033,7 +2025,8 @@ static int atmel_xdmac_resume(struct device *dev)
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDC, atchan->save_cndc);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CIE, atchan->save_cim);
 			wmb();
-			at_xdmac_write(atxdmac, AT_XDMAC_GE, atchan->mask);
+			if (atxdmac->save_gs & atchan->mask)
+				at_xdmac_write(atxdmac, AT_XDMAC_GE, atchan->mask);
 		}
 	}
 	return 0;
diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 97f5e4e93cfc..799ebbaf35be 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -171,7 +171,7 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
 }
 
-static void dw_edma_start_transfer(struct dw_edma_chan *chan)
+static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
 	struct dw_edma_chunk *child;
 	struct dw_edma_desc *desc;
@@ -179,16 +179,16 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
 
 	vd = vchan_next_desc(&chan->vc);
 	if (!vd)
-		return;
+		return 0;
 
 	desc = vd2dw_edma_desc(vd);
 	if (!desc)
-		return;
+		return 0;
 
 	child = list_first_entry_or_null(&desc->chunk->list,
 					 struct dw_edma_chunk, list);
 	if (!child)
-		return;
+		return 0;
 
 	dw_edma_v0_core_start(child, !desc->xfer_sz);
 	desc->xfer_sz += child->ll_region.sz;
@@ -196,6 +196,8 @@ static void dw_edma_start_transfer(struct dw_edma_chan *chan)
 	list_del(&child->list);
 	kfree(child);
 	desc->chunks_alloc--;
+
+	return 1;
 }
 
 static int dw_edma_device_config(struct dma_chan *dchan,
@@ -279,9 +281,12 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 	unsigned long flags;
 
+	if (!chan->configured)
+		return;
+
 	spin_lock_irqsave(&chan->vc.lock, flags);
-	if (chan->configured && chan->request == EDMA_REQ_NONE &&
-	    chan->status == EDMA_ST_IDLE && vchan_issue_pending(&chan->vc)) {
+	if (vchan_issue_pending(&chan->vc) && chan->request == EDMA_REQ_NONE &&
+	    chan->status == EDMA_ST_IDLE) {
 		chan->status = EDMA_ST_BUSY;
 		dw_edma_start_transfer(chan);
 	}
@@ -555,14 +560,14 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		switch (chan->request) {
 		case EDMA_REQ_NONE:
 			desc = vd2dw_edma_desc(vd);
-			if (desc->chunks_alloc) {
-				chan->status = EDMA_ST_BUSY;
-				dw_edma_start_transfer(chan);
-			} else {
+			if (!desc->chunks_alloc) {
 				list_del(&vd->node);
 				vchan_cookie_complete(vd);
-				chan->status = EDMA_ST_IDLE;
 			}
+
+			/* Continue transferring if there are remaining chunks or issued requests.
+			 */
+			chan->status = dw_edma_start_transfer(chan) ? EDMA_ST_BUSY : EDMA_ST_IDLE;
 			break;
 
 		case EDMA_REQ_STOP:
diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 4800c596433a..9f3e011fbd91 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -756,7 +756,7 @@ static int mv_xor_v2_probe(struct platform_device *pdev)
 
 	xor_dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (PTR_ERR(xor_dev->clk) == -EPROBE_DEFER) {
-		ret = EPROBE_DEFER;
+		ret = -EPROBE_DEFER;
 		goto disable_reg_clk;
 	}
 	if (!IS_ERR(xor_dev->clk)) {
diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 1a1b7d8458c9..1e87fe6c62af 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1961,7 +1961,6 @@ static int gpi_ch_init(struct gchan *gchan)
 error_config_int:
 	gpi_free_ring(&gpii->ev_ring, gpii);
 exit_gpi_init:
-	mutex_unlock(&gpii->ctrl_lock);
 	return ret;
 }
 
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 1abc020d49ab..984c93c8825f 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -510,7 +510,7 @@ static bool skx_rir_decode(struct decoded_addr *res)
 }
 
 static u8 skx_close_row[] = {
-	15, 16, 17, 18, 20, 21, 22, 28, 10, 11, 12, 13, 29, 30, 31, 32, 33
+	15, 16, 17, 18, 20, 21, 22, 28, 10, 11, 12, 13, 29, 30, 31, 32, 33, 34
 };
 
 static u8 skx_close_column[] = {
@@ -518,7 +518,7 @@ static u8 skx_close_column[] = {
 };
 
 static u8 skx_open_row[] = {
-	14, 15, 16, 20, 28, 21, 22, 23, 24, 25, 26, 27, 29, 30, 31, 32, 33
+	14, 15, 16, 20, 28, 21, 22, 23, 24, 25, 26, 27, 29, 30, 31, 32, 33, 34
 };
 
 static u8 skx_open_column[] = {
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 11842497b226..7ccda7d720a1 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1463,7 +1463,7 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
 		return ret;
 
 	ret = __scmi_xfer_info_init(sinfo, &sinfo->tx_minfo);
-	if (!ret && idr_find(&sinfo->rx_idr, SCMI_PROTOCOL_BASE))
+	if (!ret && !idr_is_empty(&sinfo->rx_idr))
 		ret = __scmi_xfer_info_init(sinfo, &sinfo->rx_minfo);
 
 	return ret;
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 2b5214d5c0da..18e1a4b80401 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1320,8 +1320,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
 static void qcom_scm_shutdown(struct platform_device *pdev)
 {
 	/* Clean shutdown, disable download mode to allow normal restart */
-	if (download_mode)
-		qcom_scm_set_download_mode(false);
+	qcom_scm_set_download_mode(false);
 }
 
 static const struct of_device_id qcom_scm_dt_match[] = {
diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 4fdd75f1e86e..2b50dc21fba1 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -989,8 +989,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 		return ret;
 
 	genpool = svc_create_memory_pool(pdev, sh_memory);
-	if (!genpool)
-		return -ENOMEM;
+	if (IS_ERR(genpool))
+		return PTR_ERR(genpool);
 
 	/* allocate service controller and supporting channel */
 	controller = devm_kzalloc(dev, sizeof(*controller), GFP_KERNEL);
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 798f55670646..75a24b045724 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -115,7 +115,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
 /**
  * fpga_bridge_get - get an exclusive reference to an fpga bridge
  * @dev:	parent device that fpga bridge was registered with
- * @info:	fpga manager info
+ * @info:	fpga image specific information
  *
  * Given a device, get an exclusive reference to an fpga bridge.
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 68c98e30fee7..1e0ddf7722cd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1707,7 +1707,8 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		dc_deinit_callbacks(adev->dm.dc);
 #endif
 
-	dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
+	if (adev->dm.dc)
+		dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
 
 	if (dc_enable_dmub_notifications(adev->dm.dc)) {
 		kfree(adev->dm.dmub_notify);
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/Makefile b/drivers/gpu/drm/amd/display/dc/dce60/Makefile
index dda596fa1cd7..fee331accc0e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce60/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'controller' sub-component of DAL.
 # It provides the control and status of HW CRTC block.
 
-CFLAGS_AMDDALPATH)/dc/dce60/dce60_resource.o = $(call cc-disable-warning, override-init)
+CFLAGS_$(AMDDALPATH)/dc/dce60/dce60_resource.o = $(call cc-disable-warning, override-init)
 
 DCE60 = dce60_timing_generator.o dce60_hw_sequencer.o \
 	dce60_resource.o
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm/bridge/adv7511/adv7533.c
index 7eda12f338a1..babc0be0bbb5 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
@@ -103,22 +103,19 @@ void adv7533_dsi_power_off(struct adv7511 *adv)
 enum drm_mode_status adv7533_mode_valid(struct adv7511 *adv,
 					const struct drm_display_mode *mode)
 {
-	int lanes;
+	unsigned long max_lane_freq;
 	struct mipi_dsi_device *dsi = adv->dsi;
+	u8 bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
 
-	if (mode->clock > 80000)
-		lanes = 4;
-	else
-		lanes = 3;
-
-	/*
-	 * TODO: add support for dynamic switching of lanes
-	 * by using the bridge pre_enable() op . Till then filter
-	 * out the modes which shall need different number of lanes
-	 * than what was configured in the device tree.
-	 */
-	if (lanes != dsi->lanes)
-		return MODE_BAD;
+	/* Check max clock for either 7533 or 7535 */
+	if (mode->clock > (adv->type == ADV7533 ? 80000 : 148500))
+		return MODE_CLOCK_HIGH;
+
+	/* Check max clock for each lane */
+	max_lane_freq = (adv->type == ADV7533 ? 800000 : 891000);
+
+	if (mode->clock * bpp > max_lane_freq * adv->num_dsi_lanes)
+		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
 }
diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 5606bca3caa8..f6b72e03688d 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -488,8 +488,9 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 		 */
 		dev->mode_config.delayed_event = true;
 		if (dev->mode_config.poll_enabled)
-			schedule_delayed_work(&dev->mode_config.output_poll_work,
-					      0);
+			mod_delayed_work(system_wq,
+					 &dev->mode_config.output_poll_work,
+					 0);
 	}
 
 	/* Re-enable polling in case the global poll config changed. */
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 566b34ba57e1..26811176846d 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -2303,7 +2303,7 @@ intel_get_crtc_new_encoder(const struct intel_atomic_state *state,
 		num_encoders++;
 	}
 
-	drm_WARN(encoder->base.dev, num_encoders != 1,
+	drm_WARN(state->base.dev, num_encoders != 1,
 		 "%d encoders for pipe %c\n",
 		 num_encoders, pipe_name(crtc->pipe));
 
diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index 7b8d7178d09a..39cab4a55f57 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -392,8 +392,10 @@ static int lima_pdev_probe(struct platform_device *pdev)
 
 	/* Allocate and initialize the DRM device. */
 	ddev = drm_dev_alloc(&lima_drm_driver, &pdev->dev);
-	if (IS_ERR(ddev))
-		return PTR_ERR(ddev);
+	if (IS_ERR(ddev)) {
+		err = PTR_ERR(ddev);
+		goto err_out0;
+	}
 
 	ddev->dev_private = ldev;
 	ldev->ddev = ddev;
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index b8c49ba65254..d92416d52628 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1749,6 +1749,7 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 	struct a5xx_gpu *a5xx_gpu = NULL;
 	struct adreno_gpu *adreno_gpu;
 	struct msm_gpu *gpu;
+	unsigned int nr_rings;
 	int ret;
 
 	if (!pdev) {
@@ -1769,7 +1770,12 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 
 	check_speed_bin(&pdev->dev);
 
-	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 4);
+	nr_rings = 4;
+
+	if (adreno_is_a510(adreno_gpu))
+		nr_rings = 1;
+
+	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, nr_rings);
 	if (ret) {
 		a5xx_destroy(&(a5xx_gpu->base.base));
 		return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 2a6ce76656aa..3eb914665344 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -398,8 +398,11 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 	if (ret)
 		return NULL;
 
-	/* Make sure pm runtime is active and reset any previous errors */
-	pm_runtime_set_active(&pdev->dev);
+	/*
+	 * Now that we have firmware loaded, and are ready to begin
+	 * booting the gpu, go ahead and enable runpm:
+	 */
+	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 3fa01938f4b2..47a260715a89 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -943,7 +943,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	pm_runtime_set_autosuspend_delay(dev,
 		adreno_gpu->info->inactive_period);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_enable(dev);
 
 	return msm_gpu_init(drm, pdev, &adreno_gpu->base, &funcs->base,
 			adreno_gpu->info->name, &adreno_gpu_config);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 5f236395677e..03bddd904d1a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -637,7 +637,7 @@ static int dpu_encoder_virt_atomic_check(
 		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
 			dpu_rm_release(global_state, drm_enc);
 
-			if (!crtc_state->active_changed || crtc_state->active)
+			if (!crtc_state->active_changed || crtc_state->enable)
 				ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
 						drm_enc, crtc_state, topology);
 		}
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index 4bf4e25d7f01..6bc0c4e6cd96 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -109,8 +109,8 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 	renc = drmm_encoder_alloc(&rcdu->ddev, struct rcar_du_encoder, base,
 				  &rcar_du_encoder_funcs, DRM_MODE_ENCODER_NONE,
 				  NULL);
-	if (!renc)
-		return -ENOMEM;
+	if (IS_ERR(renc))
+		return PTR_ERR(renc);
 
 	renc->output = output;
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 7971f57436dd..3b18b6a7acd3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -251,9 +251,6 @@ static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
 	else
 		ret = rockchip_drm_gem_object_mmap_dma(obj, vma);
 
-	if (ret)
-		drm_gem_vm_close(vma);
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 82cbb29a05aa..aa3512af051a 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -345,6 +345,65 @@ static unsigned int ttm_pool_page_order(struct ttm_pool *pool, struct page *p)
 	return p->private;
 }
 
+/* Called when we got a page, either from a pool or newly allocated */
+static int ttm_pool_page_allocated(struct ttm_pool *pool, unsigned int order,
+				   struct page *p, dma_addr_t **dma_addr,
+				   unsigned long *num_pages,
+				   struct page ***pages)
+{
+	unsigned int i;
+	int r;
+
+	if (*dma_addr) {
+		r = ttm_pool_map(pool, order, p, dma_addr);
+		if (r)
+			return r;
+	}
+
+	*num_pages -= 1 << order;
+	for (i = 1 << order; i; --i, ++(*pages), ++p)
+		**pages = p;
+
+	return 0;
+}
+
+/**
+ * ttm_pool_free_range() - Free a range of TTM pages
+ * @pool: The pool used for allocating.
+ * @tt: The struct ttm_tt holding the page pointers.
+ * @caching: The page caching mode used by the range.
+ * @start_page: index for first page to free.
+ * @end_page: index for last page to free + 1.
+ *
+ * During allocation the ttm_tt page-vector may be populated with ranges of
+ * pages with different attributes if allocation hit an error without being
+ * able to completely fulfill the allocation. This function can be used
+ * to free these individual ranges.
+ */
+static void ttm_pool_free_range(struct ttm_pool *pool, struct ttm_tt *tt,
+				enum ttm_caching caching,
+				pgoff_t start_page, pgoff_t end_page)
+{
+	struct page **pages = tt->pages;
+	unsigned int order;
+	pgoff_t i, nr;
+
+	for (i = start_page; i < end_page; i += nr, pages += nr) {
+		struct ttm_pool_type *pt = NULL;
+
+		order = ttm_pool_page_order(pool, *pages);
+		nr = (1UL << order);
+		if (tt->dma_address)
+			ttm_pool_unmap(pool, tt->dma_address[i], nr);
+
+		pt = ttm_pool_select_type(pool, caching, order);
+		if (pt)
+			ttm_pool_type_give(pt, *pages);
+		else
+			ttm_pool_free_page(pool, caching, order, *pages);
+	}
+}
+
 /**
  * ttm_pool_alloc - Fill a ttm_tt object
  *
@@ -360,12 +419,14 @@ static unsigned int ttm_pool_page_order(struct ttm_pool *pool, struct page *p)
 int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		   struct ttm_operation_ctx *ctx)
 {
-	unsigned long num_pages = tt->num_pages;
+	pgoff_t num_pages = tt->num_pages;
 	dma_addr_t *dma_addr = tt->dma_address;
 	struct page **caching = tt->pages;
 	struct page **pages = tt->pages;
+	enum ttm_caching page_caching;
 	gfp_t gfp_flags = GFP_USER;
-	unsigned int i, order;
+	pgoff_t caching_divide;
+	unsigned int order;
 	struct page *p;
 	int r;
 
@@ -386,45 +447,61 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	for (order = min_t(unsigned int, MAX_ORDER - 1, __fls(num_pages));
 	     num_pages;
 	     order = min_t(unsigned int, order, __fls(num_pages))) {
-		bool apply_caching = false;
 		struct ttm_pool_type *pt;
 
+		page_caching = tt->caching;
 		pt = ttm_pool_select_type(pool, tt->caching, order);
 		p = pt ? ttm_pool_type_take(pt) : NULL;
 		if (p) {
-			apply_caching = true;
-		} else {
-			p = ttm_pool_alloc_page(pool, gfp_flags, order);
-			if (p && PageHighMem(p))
-				apply_caching = true;
-		}
-
-		if (!p) {
-			if (order) {
-				--order;
-				continue;
-			}
-			r = -ENOMEM;
-			goto error_free_all;
-		}
-
-		if (apply_caching) {
 			r = ttm_pool_apply_caching(caching, pages,
 						   tt->caching);
 			if (r)
 				goto error_free_page;
-			caching = pages + (1 << order);
+
+			caching = pages;
+			do {
+				r = ttm_pool_page_allocated(pool, order, p,
+							    &dma_addr,
+							    &num_pages,
+							    &pages);
+				if (r)
+					goto error_free_page;
+
+				caching = pages;
+				if (num_pages < (1 << order))
+					break;
+
+				p = ttm_pool_type_take(pt);
+			} while (p);
 		}
 
-		if (dma_addr) {
-			r = ttm_pool_map(pool, order, p, &dma_addr);
+		page_caching = ttm_cached;
+		while (num_pages >= (1 << order) &&
+		       (p = ttm_pool_alloc_page(pool, gfp_flags, order))) {
+
+			if (PageHighMem(p)) {
+				r = ttm_pool_apply_caching(caching, pages,
+							   tt->caching);
+				if (r)
+					goto error_free_page;
+				caching = pages;
+			}
+			r = ttm_pool_page_allocated(pool, order, p, &dma_addr,
+						    &num_pages, &pages);
 			if (r)
 				goto error_free_page;
+			if (PageHighMem(p))
+				caching = pages;
 		}
 
-		num_pages -= 1 << order;
-		for (i = 1 << order; i; --i)
-			*(pages++) = p++;
+		if (!p) {
+			if (order) {
+				--order;
+				continue;
+			}
+			r = -ENOMEM;
+			goto error_free_all;
+		}
 	}
 
 	r = ttm_pool_apply_caching(caching, pages, tt->caching);
@@ -434,15 +511,13 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	return 0;
 
 error_free_page:
-	ttm_pool_free_page(pool, tt->caching, order, p);
+	ttm_pool_free_page(pool, page_caching, order, p);
 
 error_free_all:
 	num_pages = tt->num_pages - num_pages;
-	for (i = 0; i < num_pages; ) {
-		order = ttm_pool_page_order(pool, tt->pages[i]);
-		ttm_pool_free_page(pool, tt->caching, order, tt->pages[i]);
-		i += 1 << order;
-	}
+	caching_divide = caching - tt->pages;
+	ttm_pool_free_range(pool, tt, tt->caching, 0, caching_divide);
+	ttm_pool_free_range(pool, tt, ttm_cached, caching_divide, num_pages);
 
 	return r;
 }
@@ -458,27 +533,7 @@ EXPORT_SYMBOL(ttm_pool_alloc);
  */
 void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt)
 {
-	unsigned int i;
-
-	for (i = 0; i < tt->num_pages; ) {
-		struct page *p = tt->pages[i];
-		unsigned int order, num_pages;
-		struct ttm_pool_type *pt;
-
-		order = ttm_pool_page_order(pool, p);
-		num_pages = 1ULL << order;
-		if (tt->dma_address)
-			ttm_pool_unmap(pool, tt->dma_address[i], num_pages);
-
-		pt = ttm_pool_select_type(pool, tt->caching, order);
-		if (pt)
-			ttm_pool_type_give(pt, tt->pages[i]);
-		else
-			ttm_pool_free_page(pool, tt->caching, order,
-					   tt->pages[i]);
-
-		i += num_pages;
-	}
+	ttm_pool_free_range(pool, tt, tt->caching, 0, tt->num_pages);
 
 	while (atomic_long_read(&allocated_pages) > page_pool_size)
 		ttm_pool_shrink();
diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
index bd6f75285fd9..43fc56d0c4a0 100644
--- a/drivers/gpu/drm/vgem/vgem_fence.c
+++ b/drivers/gpu/drm/vgem/vgem_fence.c
@@ -248,4 +248,5 @@ void vgem_fence_close(struct vgem_file *vfile)
 {
 	idr_for_each(&vfile->fence_idr, __vgem_fence_idr_fini, vfile);
 	idr_destroy(&vfile->fence_idr);
+	mutex_destroy(&vfile->fence_mutex);
 }
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index f17f061aeb79..6ff8f254dc84 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -351,6 +351,14 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	return devm_add_action_or_reset(&pdev->dev, amd_mp2_pci_remove, privdata);
 }
 
+static void amd_sfh_shutdown(struct pci_dev *pdev)
+{
+	struct amd_mp2_dev *mp2 = pci_get_drvdata(pdev);
+
+	if (mp2 && mp2->mp2_ops)
+		mp2->mp2_ops->stop_all(mp2);
+}
+
 static int __maybe_unused amd_mp2_pci_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -420,6 +428,7 @@ static struct pci_driver amd_mp2_pci_driver = {
 	.id_table	= amd_mp2_pci_tbl,
 	.probe		= amd_mp2_pci_probe,
 	.driver.pm	= &amd_mp2_pm_ops,
+	.shutdown	= amd_sfh_shutdown,
 };
 module_pci_driver(amd_mp2_pci_driver);
 
diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 6b84822e7d93..22e314725def 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1515,9 +1515,9 @@ static int adt7475_set_pwm_polarity(struct i2c_client *client)
 	int ret, i;
 	u8 val;
 
-	ret = of_property_read_u32_array(client->dev.of_node,
-					 "adi,pwm-active-state", states,
-					 ARRAY_SIZE(states));
+	ret = device_property_read_u32_array(&client->dev,
+					     "adi,pwm-active-state", states,
+					     ARRAY_SIZE(states));
 	if (ret)
 		return ret;
 
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 3618a924e78e..e7ba05c50e61 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -75,6 +75,7 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 
 #define ZEN_CUR_TEMP_SHIFT			21
 #define ZEN_CUR_TEMP_RANGE_SEL_MASK		BIT(19)
+#define ZEN_CUR_TEMP_TJ_SEL_MASK		GENMASK(17, 16)
 
 #define ZEN_SVI_BASE				0x0005A000
 
@@ -175,7 +176,8 @@ static long get_raw_temp(struct k10temp_data *data)
 
 	data->read_tempreg(data->pdev, &regval);
 	temp = (regval >> ZEN_CUR_TEMP_SHIFT) * 125;
-	if (regval & data->temp_adjust_mask)
+	if ((regval & data->temp_adjust_mask) ||
+	    (regval & ZEN_CUR_TEMP_TJ_SEL_MASK) == ZEN_CUR_TEMP_TJ_SEL_MASK)
 		temp -= 49000;
 	return temp;
 }
diff --git a/drivers/hwmon/pmbus/fsp-3y.c b/drivers/hwmon/pmbus/fsp-3y.c
index aec294cc72d1..c7469d2cdedc 100644
--- a/drivers/hwmon/pmbus/fsp-3y.c
+++ b/drivers/hwmon/pmbus/fsp-3y.c
@@ -180,7 +180,6 @@ static struct pmbus_driver_info fsp3y_info[] = {
 			PMBUS_HAVE_FAN12,
 		.func[YM2151_PAGE_5VSB_LOG] =
 			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT,
-			PMBUS_HAVE_IIN,
 		.read_word_data = fsp3y_read_word_data,
 		.read_byte_data = fsp3y_read_byte_data,
 	},
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 8ebd728d3a80..1feb8f0e6556 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -830,6 +830,7 @@ int __init etm_perf_init(void)
 	etm_pmu.addr_filters_sync	= etm_addr_filters_sync;
 	etm_pmu.addr_filters_validate	= etm_addr_filters_validate;
 	etm_pmu.nr_addr_filters		= ETM_ADDR_CMP_MAX;
+	etm_pmu.module			= THIS_MODULE;
 
 	ret = perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
 	if (ret == 0)
diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 33f5588a50c0..5ea92dc97f0c 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -828,8 +828,10 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	/* Check i2c operating mode and switch if possible */
 	if (id->dev_mode == CDNS_I2C_MODE_SLAVE) {
-		if (id->slave_state != CDNS_I2C_SLAVE_STATE_IDLE)
-			return -EAGAIN;
+		if (id->slave_state != CDNS_I2C_SLAVE_STATE_IDLE) {
+			ret = -EAGAIN;
+			goto out;
+		}
 
 		/* Set mode to master */
 		cdns_i2c_set_mode(CDNS_I2C_MODE_MASTER, id);
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index d4f6c6d60683..8955f62b497e 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1058,7 +1058,7 @@ omap_i2c_isr(int irq, void *dev_id)
 	u16 stat;
 
 	stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
-	mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG);
+	mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG) & ~OMAP_I2C_STAT_NACK;
 
 	if (stat & mask)
 		ret = IRQ_WAKE_THREAD;
diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index f9c8385c72d3..496aab94570a 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -638,7 +638,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 
 static int palmas_gpadc_remove(struct platform_device *pdev)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(&pdev->dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(&pdev->dev);
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
 
 	if (adc->wakeup1_enable || adc->wakeup2_enable)
diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
index 801e5a0ad496..f3648f20ef2c 100644
--- a/drivers/iio/light/max44009.c
+++ b/drivers/iio/light/max44009.c
@@ -528,6 +528,12 @@ static int max44009_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
+static const struct of_device_id max44009_of_match[] = {
+	{ .compatible = "maxim,max44009" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max44009_of_match);
+
 static const struct i2c_device_id max44009_id[] = {
 	{ "max44009", 0 },
 	{ }
@@ -537,18 +543,13 @@ MODULE_DEVICE_TABLE(i2c, max44009_id);
 static struct i2c_driver max44009_driver = {
 	.driver = {
 		.name = MAX44009_DRV_NAME,
+		.of_match_table = max44009_of_match,
 	},
 	.probe = max44009_probe,
 	.id_table = max44009_id,
 };
 module_i2c_driver(max44009_driver);
 
-static const struct of_device_id max44009_of_match[] = {
-	{ .compatible = "maxim,max44009" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, max44009_of_match);
-
 MODULE_AUTHOR("Robert Eshleman <bobbyeshleman@gmail.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MAX44009 ambient light sensor driver");
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 5c910f5c01b3..680c3ac8cd4c 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2914,6 +2914,8 @@ static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
 	    (ari && ari_length > IB_CM_REJ_ARI_LENGTH))
 		return -EINVAL;
 
+	trace_icm_send_rej(&cm_id_priv->id, reason);
+
 	switch (state) {
 	case IB_CM_REQ_SENT:
 	case IB_CM_MRA_REQ_RCVD:
@@ -2944,7 +2946,6 @@ static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
 		return -EINVAL;
 	}
 
-	trace_icm_send_rej(&cm_id_priv->id, reason);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
 		cm_free_msg(msg);
diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index 15b0cb0f363f..33ffb00c6382 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -251,6 +251,7 @@ static int hfi1_ipoib_build_ulp_payload(struct ipoib_txreq *tx,
 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
 		ret = sdma_txadd_page(dd,
+				      NULL,
 				      txreq,
 				      skb_frag_page(frag),
 				      frag->bv_offset,
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index 7333646021bb..71b9ac018887 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -126,11 +126,11 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 	spin_lock_irqsave(&handler->lock, flags);
 	node = __mmu_rb_search(handler, mnode->addr, mnode->len);
 	if (node) {
-		ret = -EINVAL;
+		ret = -EEXIST;
 		goto unlock;
 	}
 	__mmu_int_rb_insert(mnode, &handler->root);
-	list_add(&mnode->list, &handler->lru_list);
+	list_add_tail(&mnode->list, &handler->lru_list);
 
 	ret = handler->ops->insert(handler->ops_arg, mnode);
 	if (ret) {
@@ -143,6 +143,19 @@ int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 	return ret;
 }
 
+/* Caller must hold handler lock */
+struct mmu_rb_node *hfi1_mmu_rb_get_first(struct mmu_rb_handler *handler,
+					  unsigned long addr, unsigned long len)
+{
+	struct mmu_rb_node *node;
+
+	trace_hfi1_mmu_rb_search(addr, len);
+	node = __mmu_int_rb_iter_first(&handler->root, addr, (addr + len) - 1);
+	if (node)
+		list_move_tail(&node->list, &handler->lru_list);
+	return node;
+}
+
 /* Caller must hold handler lock */
 static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *handler,
 					   unsigned long addr,
@@ -167,32 +180,6 @@ static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *handler,
 	return node;
 }
 
-bool hfi1_mmu_rb_remove_unless_exact(struct mmu_rb_handler *handler,
-				     unsigned long addr, unsigned long len,
-				     struct mmu_rb_node **rb_node)
-{
-	struct mmu_rb_node *node;
-	unsigned long flags;
-	bool ret = false;
-
-	if (current->mm != handler->mn.mm)
-		return ret;
-
-	spin_lock_irqsave(&handler->lock, flags);
-	node = __mmu_rb_search(handler, addr, len);
-	if (node) {
-		if (node->addr == addr && node->len == len)
-			goto unlock;
-		__mmu_int_rb_remove(node, &handler->root);
-		list_del(&node->list); /* remove from LRU list */
-		ret = true;
-	}
-unlock:
-	spin_unlock_irqrestore(&handler->lock, flags);
-	*rb_node = node;
-	return ret;
-}
-
 void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 {
 	struct mmu_rb_node *rbnode, *ptr;
@@ -206,8 +193,7 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 	INIT_LIST_HEAD(&del_list);
 
 	spin_lock_irqsave(&handler->lock, flags);
-	list_for_each_entry_safe_reverse(rbnode, ptr, &handler->lru_list,
-					 list) {
+	list_for_each_entry_safe(rbnode, ptr, &handler->lru_list, list) {
 		if (handler->ops->evict(handler->ops_arg, rbnode, evict_arg,
 					&stop)) {
 			__mmu_int_rb_remove(rbnode, &handler->root);
@@ -219,36 +205,11 @@ void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
 	}
 	spin_unlock_irqrestore(&handler->lock, flags);
 
-	while (!list_empty(&del_list)) {
-		rbnode = list_first_entry(&del_list, struct mmu_rb_node, list);
-		list_del(&rbnode->list);
+	list_for_each_entry_safe(rbnode, ptr, &del_list, list) {
 		handler->ops->remove(handler->ops_arg, rbnode);
 	}
 }
 
-/*
- * It is up to the caller to ensure that this function does not race with the
- * mmu invalidate notifier which may be calling the users remove callback on
- * 'node'.
- */
-void hfi1_mmu_rb_remove(struct mmu_rb_handler *handler,
-			struct mmu_rb_node *node)
-{
-	unsigned long flags;
-
-	if (current->mm != handler->mn.mm)
-		return;
-
-	/* Validity of handler and node pointers has been checked by caller. */
-	trace_hfi1_mmu_rb_remove(node->addr, node->len);
-	spin_lock_irqsave(&handler->lock, flags);
-	__mmu_int_rb_remove(node, &handler->root);
-	list_del(&node->list); /* remove from LRU list */
-	spin_unlock_irqrestore(&handler->lock, flags);
-
-	handler->ops->remove(handler->ops_arg, node);
-}
-
 static int mmu_notifier_range_start(struct mmu_notifier *mn,
 		const struct mmu_notifier_range *range)
 {
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.h b/drivers/infiniband/hw/hfi1/mmu_rb.h
index 7417be2b9dc8..ed75acdb7b83 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.h
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.h
@@ -52,10 +52,8 @@ void hfi1_mmu_rb_unregister(struct mmu_rb_handler *handler);
 int hfi1_mmu_rb_insert(struct mmu_rb_handler *handler,
 		       struct mmu_rb_node *mnode);
 void hfi1_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg);
-void hfi1_mmu_rb_remove(struct mmu_rb_handler *handler,
-			struct mmu_rb_node *mnode);
-bool hfi1_mmu_rb_remove_unless_exact(struct mmu_rb_handler *handler,
-				     unsigned long addr, unsigned long len,
-				     struct mmu_rb_node **rb_node);
+struct mmu_rb_node *hfi1_mmu_rb_get_first(struct mmu_rb_handler *handler,
+					  unsigned long addr,
+					  unsigned long len);
 
 #endif /* _HFI1_MMU_RB_H */
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 8ed20392e9f0..bb2552dd29c1 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1593,22 +1593,7 @@ static inline void sdma_unmap_desc(
 	struct hfi1_devdata *dd,
 	struct sdma_desc *descp)
 {
-	switch (sdma_mapping_type(descp)) {
-	case SDMA_MAP_SINGLE:
-		dma_unmap_single(
-			&dd->pcidev->dev,
-			sdma_mapping_addr(descp),
-			sdma_mapping_len(descp),
-			DMA_TO_DEVICE);
-		break;
-	case SDMA_MAP_PAGE:
-		dma_unmap_page(
-			&dd->pcidev->dev,
-			sdma_mapping_addr(descp),
-			sdma_mapping_len(descp),
-			DMA_TO_DEVICE);
-		break;
-	}
+	system_descriptor_complete(dd, descp);
 }
 
 /*
@@ -3128,7 +3113,7 @@ int ext_coal_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx,
 
 		/* Add descriptor for coalesce buffer */
 		tx->desc_limit = MAX_DESC;
-		return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, tx,
+		return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, NULL, tx,
 					 addr, tx->tlen);
 	}
 
@@ -3167,10 +3152,12 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 			return rval;
 		}
 	}
+
 	/* finish the one just added */
 	make_tx_sdma_desc(
 		tx,
 		SDMA_MAP_NONE,
+		NULL,
 		dd->sdma_pad_phys,
 		sizeof(u32) - (tx->packet_len & (sizeof(u32) - 1)));
 	tx->num_desc++;
diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
index b023fc461bd5..95aaec14c6c2 100644
--- a/drivers/infiniband/hw/hfi1/sdma.h
+++ b/drivers/infiniband/hw/hfi1/sdma.h
@@ -594,6 +594,7 @@ static inline dma_addr_t sdma_mapping_addr(struct sdma_desc *d)
 static inline void make_tx_sdma_desc(
 	struct sdma_txreq *tx,
 	int type,
+	void *pinning_ctx,
 	dma_addr_t addr,
 	size_t len)
 {
@@ -612,6 +613,7 @@ static inline void make_tx_sdma_desc(
 				<< SDMA_DESC0_PHY_ADDR_SHIFT) |
 			(((u64)len & SDMA_DESC0_BYTE_COUNT_MASK)
 				<< SDMA_DESC0_BYTE_COUNT_SHIFT);
+	desc->pinning_ctx = pinning_ctx;
 }
 
 /* helper to extend txreq */
@@ -643,6 +645,7 @@ static inline void _sdma_close_tx(struct hfi1_devdata *dd,
 static inline int _sdma_txadd_daddr(
 	struct hfi1_devdata *dd,
 	int type,
+	void *pinning_ctx,
 	struct sdma_txreq *tx,
 	dma_addr_t addr,
 	u16 len)
@@ -652,6 +655,7 @@ static inline int _sdma_txadd_daddr(
 	make_tx_sdma_desc(
 		tx,
 		type,
+		pinning_ctx,
 		addr, len);
 	WARN_ON(len > tx->tlen);
 	tx->num_desc++;
@@ -672,6 +676,7 @@ static inline int _sdma_txadd_daddr(
 /**
  * sdma_txadd_page() - add a page to the sdma_txreq
  * @dd: the device to use for mapping
+ * @pinning_ctx: context to be released at descriptor retirement
  * @tx: tx request to which the page is added
  * @page: page to map
  * @offset: offset within the page
@@ -687,6 +692,7 @@ static inline int _sdma_txadd_daddr(
  */
 static inline int sdma_txadd_page(
 	struct hfi1_devdata *dd,
+	void *pinning_ctx,
 	struct sdma_txreq *tx,
 	struct page *page,
 	unsigned long offset,
@@ -714,8 +720,7 @@ static inline int sdma_txadd_page(
 		return -ENOSPC;
 	}
 
-	return _sdma_txadd_daddr(
-			dd, SDMA_MAP_PAGE, tx, addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_PAGE, pinning_ctx, tx, addr, len);
 }
 
 /**
@@ -749,7 +754,8 @@ static inline int sdma_txadd_daddr(
 			return rval;
 	}
 
-	return _sdma_txadd_daddr(dd, SDMA_MAP_NONE, tx, addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_NONE, NULL, tx,
+				 addr, len);
 }
 
 /**
@@ -795,8 +801,7 @@ static inline int sdma_txadd_kvaddr(
 		return -ENOSPC;
 	}
 
-	return _sdma_txadd_daddr(
-			dd, SDMA_MAP_SINGLE, tx, addr, len);
+	return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, NULL, tx, addr, len);
 }
 
 struct iowait_work;
@@ -1030,4 +1035,5 @@ extern uint mod_num_sdma;
 
 void sdma_update_lmc(struct hfi1_devdata *dd, u64 mask, u32 lid);
 
+void system_descriptor_complete(struct hfi1_devdata *dd, struct sdma_desc *descp);
 #endif
diff --git a/drivers/infiniband/hw/hfi1/sdma_txreq.h b/drivers/infiniband/hw/hfi1/sdma_txreq.h
index e262fb5c5ec6..fad946cb5e0d 100644
--- a/drivers/infiniband/hw/hfi1/sdma_txreq.h
+++ b/drivers/infiniband/hw/hfi1/sdma_txreq.h
@@ -19,6 +19,7 @@
 struct sdma_desc {
 	/* private:  don't use directly */
 	u64 qw[2];
+	void *pinning_ctx;
 };
 
 /**
diff --git a/drivers/infiniband/hw/hfi1/trace_mmu.h b/drivers/infiniband/hw/hfi1/trace_mmu.h
index 187e9244fe5e..57900ebb7702 100644
--- a/drivers/infiniband/hw/hfi1/trace_mmu.h
+++ b/drivers/infiniband/hw/hfi1/trace_mmu.h
@@ -37,10 +37,6 @@ DEFINE_EVENT(hfi1_mmu_rb_template, hfi1_mmu_rb_search,
 	     TP_PROTO(unsigned long addr, unsigned long len),
 	     TP_ARGS(addr, len));
 
-DEFINE_EVENT(hfi1_mmu_rb_template, hfi1_mmu_rb_remove,
-	     TP_PROTO(unsigned long addr, unsigned long len),
-	     TP_ARGS(addr, len));
-
 DEFINE_EVENT(hfi1_mmu_rb_template, hfi1_mmu_mem_invalidate,
 	     TP_PROTO(unsigned long addr, unsigned long len),
 	     TP_ARGS(addr, len));
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index 5b11c8282744..a932ae1e03af 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -24,7 +24,6 @@
 
 #include "hfi.h"
 #include "sdma.h"
-#include "mmu_rb.h"
 #include "user_sdma.h"
 #include "verbs.h"  /* for the headers */
 #include "common.h" /* for struct hfi1_tid_info */
@@ -39,11 +38,7 @@ static unsigned initial_pkt_count = 8;
 static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts);
 static void user_sdma_txreq_cb(struct sdma_txreq *txreq, int status);
 static inline void pq_update(struct hfi1_user_sdma_pkt_q *pq);
-static void user_sdma_free_request(struct user_sdma_request *req, bool unpin);
-static int pin_vector_pages(struct user_sdma_request *req,
-			    struct user_sdma_iovec *iovec);
-static void unpin_vector_pages(struct mm_struct *mm, struct page **pages,
-			       unsigned start, unsigned npages);
+static void user_sdma_free_request(struct user_sdma_request *req);
 static int check_header_template(struct user_sdma_request *req,
 				 struct hfi1_pkt_header *hdr, u32 lrhlen,
 				 u32 datalen);
@@ -81,6 +76,11 @@ static struct mmu_rb_ops sdma_rb_ops = {
 	.invalidate = sdma_rb_invalidate
 };
 
+static int add_system_pages_to_sdma_packet(struct user_sdma_request *req,
+					   struct user_sdma_txreq *tx,
+					   struct user_sdma_iovec *iovec,
+					   u32 *pkt_remaining);
+
 static int defer_packet_queue(
 	struct sdma_engine *sde,
 	struct iowait_work *wait,
@@ -412,6 +412,7 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 		ret = -EINVAL;
 		goto free_req;
 	}
+
 	/* Copy the header from the user buffer */
 	ret = copy_from_user(&req->hdr, iovec[idx].iov_base + sizeof(info),
 			     sizeof(req->hdr));
@@ -486,9 +487,8 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 		memcpy(&req->iovs[i].iov,
 		       iovec + idx++,
 		       sizeof(req->iovs[i].iov));
-		ret = pin_vector_pages(req, &req->iovs[i]);
-		if (ret) {
-			req->data_iovs = i;
+		if (req->iovs[i].iov.iov_len == 0) {
+			ret = -EINVAL;
 			goto free_req;
 		}
 		req->data_len += req->iovs[i].iov.iov_len;
@@ -586,7 +586,7 @@ int hfi1_user_sdma_process_request(struct hfi1_filedata *fd,
 		if (req->seqsubmitted)
 			wait_event(pq->busy.wait_dma,
 				   (req->seqcomp == req->seqsubmitted - 1));
-		user_sdma_free_request(req, true);
+		user_sdma_free_request(req);
 		pq_update(pq);
 		set_comp_state(pq, cq, info.comp_idx, ERROR, ret);
 	}
@@ -698,48 +698,6 @@ static int user_sdma_txadd_ahg(struct user_sdma_request *req,
 	return ret;
 }
 
-static int user_sdma_txadd(struct user_sdma_request *req,
-			   struct user_sdma_txreq *tx,
-			   struct user_sdma_iovec *iovec, u32 datalen,
-			   u32 *queued_ptr, u32 *data_sent_ptr,
-			   u64 *iov_offset_ptr)
-{
-	int ret;
-	unsigned int pageidx, len;
-	unsigned long base, offset;
-	u64 iov_offset = *iov_offset_ptr;
-	u32 queued = *queued_ptr, data_sent = *data_sent_ptr;
-	struct hfi1_user_sdma_pkt_q *pq = req->pq;
-
-	base = (unsigned long)iovec->iov.iov_base;
-	offset = offset_in_page(base + iovec->offset + iov_offset);
-	pageidx = (((iovec->offset + iov_offset + base) - (base & PAGE_MASK)) >>
-		   PAGE_SHIFT);
-	len = offset + req->info.fragsize > PAGE_SIZE ?
-		PAGE_SIZE - offset : req->info.fragsize;
-	len = min((datalen - queued), len);
-	ret = sdma_txadd_page(pq->dd, &tx->txreq, iovec->pages[pageidx],
-			      offset, len);
-	if (ret) {
-		SDMA_DBG(req, "SDMA txreq add page failed %d\n", ret);
-		return ret;
-	}
-	iov_offset += len;
-	queued += len;
-	data_sent += len;
-	if (unlikely(queued < datalen && pageidx == iovec->npages &&
-		     req->iov_idx < req->data_iovs - 1)) {
-		iovec->offset += iov_offset;
-		iovec = &req->iovs[++req->iov_idx];
-		iov_offset = 0;
-	}
-
-	*queued_ptr = queued;
-	*data_sent_ptr = data_sent;
-	*iov_offset_ptr = iov_offset;
-	return ret;
-}
-
 static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
 {
 	int ret = 0;
@@ -771,8 +729,7 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
 		maxpkts = req->info.npkts - req->seqnum;
 
 	while (npkts < maxpkts) {
-		u32 datalen = 0, queued = 0, data_sent = 0;
-		u64 iov_offset = 0;
+		u32 datalen = 0;
 
 		/*
 		 * Check whether any of the completions have come back
@@ -865,27 +822,17 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
 				goto free_txreq;
 		}
 
-		/*
-		 * If the request contains any data vectors, add up to
-		 * fragsize bytes to the descriptor.
-		 */
-		while (queued < datalen &&
-		       (req->sent + data_sent) < req->data_len) {
-			ret = user_sdma_txadd(req, tx, iovec, datalen,
-					      &queued, &data_sent, &iov_offset);
-			if (ret)
-				goto free_txreq;
-		}
-		/*
-		 * The txreq was submitted successfully so we can update
-		 * the counters.
-		 */
 		req->koffset += datalen;
 		if (req_opcode(req->info.ctrl) == EXPECTED)
 			req->tidoffset += datalen;
-		req->sent += data_sent;
-		if (req->data_len)
-			iovec->offset += iov_offset;
+		req->sent += datalen;
+		while (datalen) {
+			ret = add_system_pages_to_sdma_packet(req, tx, iovec,
+							      &datalen);
+			if (ret)
+				goto free_txreq;
+			iovec = &req->iovs[req->iov_idx];
+		}
 		list_add_tail(&tx->txreq.list, &req->txps);
 		/*
 		 * It is important to increment this here as it is used to
@@ -922,133 +869,14 @@ static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
 static u32 sdma_cache_evict(struct hfi1_user_sdma_pkt_q *pq, u32 npages)
 {
 	struct evict_data evict_data;
+	struct mmu_rb_handler *handler = pq->handler;
 
 	evict_data.cleared = 0;
 	evict_data.target = npages;
-	hfi1_mmu_rb_evict(pq->handler, &evict_data);
+	hfi1_mmu_rb_evict(handler, &evict_data);
 	return evict_data.cleared;
 }
 
-static int pin_sdma_pages(struct user_sdma_request *req,
-			  struct user_sdma_iovec *iovec,
-			  struct sdma_mmu_node *node,
-			  int npages)
-{
-	int pinned, cleared;
-	struct page **pages;
-	struct hfi1_user_sdma_pkt_q *pq = req->pq;
-
-	pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
-	memcpy(pages, node->pages, node->npages * sizeof(*pages));
-
-	npages -= node->npages;
-retry:
-	if (!hfi1_can_pin_pages(pq->dd, current->mm,
-				atomic_read(&pq->n_locked), npages)) {
-		cleared = sdma_cache_evict(pq, npages);
-		if (cleared >= npages)
-			goto retry;
-	}
-	pinned = hfi1_acquire_user_pages(current->mm,
-					 ((unsigned long)iovec->iov.iov_base +
-					 (node->npages * PAGE_SIZE)), npages, 0,
-					 pages + node->npages);
-	if (pinned < 0) {
-		kfree(pages);
-		return pinned;
-	}
-	if (pinned != npages) {
-		unpin_vector_pages(current->mm, pages, node->npages, pinned);
-		return -EFAULT;
-	}
-	kfree(node->pages);
-	node->rb.len = iovec->iov.iov_len;
-	node->pages = pages;
-	atomic_add(pinned, &pq->n_locked);
-	return pinned;
-}
-
-static void unpin_sdma_pages(struct sdma_mmu_node *node)
-{
-	if (node->npages) {
-		unpin_vector_pages(mm_from_sdma_node(node), node->pages, 0,
-				   node->npages);
-		atomic_sub(node->npages, &node->pq->n_locked);
-	}
-}
-
-static int pin_vector_pages(struct user_sdma_request *req,
-			    struct user_sdma_iovec *iovec)
-{
-	int ret = 0, pinned, npages;
-	struct hfi1_user_sdma_pkt_q *pq = req->pq;
-	struct sdma_mmu_node *node = NULL;
-	struct mmu_rb_node *rb_node;
-	struct iovec *iov;
-	bool extracted;
-
-	extracted =
-		hfi1_mmu_rb_remove_unless_exact(pq->handler,
-						(unsigned long)
-						iovec->iov.iov_base,
-						iovec->iov.iov_len, &rb_node);
-	if (rb_node) {
-		node = container_of(rb_node, struct sdma_mmu_node, rb);
-		if (!extracted) {
-			atomic_inc(&node->refcount);
-			iovec->pages = node->pages;
-			iovec->npages = node->npages;
-			iovec->node = node;
-			return 0;
-		}
-	}
-
-	if (!node) {
-		node = kzalloc(sizeof(*node), GFP_KERNEL);
-		if (!node)
-			return -ENOMEM;
-
-		node->rb.addr = (unsigned long)iovec->iov.iov_base;
-		node->pq = pq;
-		atomic_set(&node->refcount, 0);
-	}
-
-	iov = &iovec->iov;
-	npages = num_user_pages((unsigned long)iov->iov_base, iov->iov_len);
-	if (node->npages < npages) {
-		pinned = pin_sdma_pages(req, iovec, node, npages);
-		if (pinned < 0) {
-			ret = pinned;
-			goto bail;
-		}
-		node->npages += pinned;
-		npages = node->npages;
-	}
-	iovec->pages = node->pages;
-	iovec->npages = npages;
-	iovec->node = node;
-
-	ret = hfi1_mmu_rb_insert(req->pq->handler, &node->rb);
-	if (ret) {
-		iovec->node = NULL;
-		goto bail;
-	}
-	return 0;
-bail:
-	unpin_sdma_pages(node);
-	kfree(node);
-	return ret;
-}
-
-static void unpin_vector_pages(struct mm_struct *mm, struct page **pages,
-			       unsigned start, unsigned npages)
-{
-	hfi1_release_user_pages(mm, pages + start, npages, false);
-	kfree(pages);
-}
-
 static int check_header_template(struct user_sdma_request *req,
 				 struct hfi1_pkt_header *hdr, u32 lrhlen,
 				 u32 datalen)
@@ -1390,7 +1218,7 @@ static void user_sdma_txreq_cb(struct sdma_txreq *txreq, int status)
 	if (req->seqcomp != req->info.npkts - 1)
 		return;
 
-	user_sdma_free_request(req, false);
+	user_sdma_free_request(req);
 	set_comp_state(pq, cq, req->info.comp_idx, state, status);
 	pq_update(pq);
 }
@@ -1401,10 +1229,8 @@ static inline void pq_update(struct hfi1_user_sdma_pkt_q *pq)
 		wake_up(&pq->wait);
 }
 
-static void user_sdma_free_request(struct user_sdma_request *req, bool unpin)
+static void user_sdma_free_request(struct user_sdma_request *req)
 {
-	int i;
-
 	if (!list_empty(&req->txps)) {
 		struct sdma_txreq *t, *p;
 
@@ -1417,21 +1243,6 @@ static void user_sdma_free_request(struct user_sdma_request *req, bool unpin)
 		}
 	}
 
-	for (i = 0; i < req->data_iovs; i++) {
-		struct sdma_mmu_node *node = req->iovs[i].node;
-
-		if (!node)
-			continue;
-
-		req->iovs[i].node = NULL;
-
-		if (unpin)
-			hfi1_mmu_rb_remove(req->pq->handler,
-					   &node->rb);
-		else
-			atomic_dec(&node->refcount);
-	}
-
 	kfree(req->tids);
 	clear_bit(req->info.comp_idx, req->pq->req_in_use);
 }
@@ -1449,6 +1260,368 @@ static inline void set_comp_state(struct hfi1_user_sdma_pkt_q *pq,
 					idx, state, ret);
 }
 
+static void unpin_vector_pages(struct mm_struct *mm, struct page **pages,
+			       unsigned int start, unsigned int npages)
+{
+	hfi1_release_user_pages(mm, pages + start, npages, false);
+	kfree(pages);
+}
+
+static void free_system_node(struct sdma_mmu_node *node)
+{
+	if (node->npages) {
+		unpin_vector_pages(mm_from_sdma_node(node), node->pages, 0,
+				   node->npages);
+		atomic_sub(node->npages, &node->pq->n_locked);
+	}
+	kfree(node);
+}
+
+static inline void acquire_node(struct sdma_mmu_node *node)
+{
+	atomic_inc(&node->refcount);
+	WARN_ON(atomic_read(&node->refcount) < 0);
+}
+
+static inline void release_node(struct mmu_rb_handler *handler,
+				struct sdma_mmu_node *node)
+{
+	atomic_dec(&node->refcount);
+	WARN_ON(atomic_read(&node->refcount) < 0);
+}
+
+static struct sdma_mmu_node *find_system_node(struct mmu_rb_handler *handler,
+					      unsigned long start,
+					      unsigned long end)
+{
+	struct mmu_rb_node *rb_node;
+	struct sdma_mmu_node *node;
+	unsigned long flags;
+
+	spin_lock_irqsave(&handler->lock, flags);
+	rb_node = hfi1_mmu_rb_get_first(handler, start, (end - start));
+	if (!rb_node) {
+		spin_unlock_irqrestore(&handler->lock, flags);
+		return NULL;
+	}
+	node = container_of(rb_node, struct sdma_mmu_node, rb);
+	acquire_node(node);
+	spin_unlock_irqrestore(&handler->lock, flags);
+
+	return node;
+}
+
+static int pin_system_pages(struct user_sdma_request *req,
+			    uintptr_t start_address, size_t length,
+			    struct sdma_mmu_node *node, int npages)
+{
+	struct hfi1_user_sdma_pkt_q *pq = req->pq;
+	int pinned, cleared;
+	struct page **pages;
+
+	pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+retry:
+	if (!hfi1_can_pin_pages(pq->dd, current->mm, atomic_read(&pq->n_locked),
+				npages)) {
+		SDMA_DBG(req, "Evicting: nlocked %u npages %u",
+			 atomic_read(&pq->n_locked), npages);
+		cleared = sdma_cache_evict(pq, npages);
+		if (cleared >= npages)
+			goto retry;
+	}
+
+	SDMA_DBG(req, "Acquire user pages start_address %lx node->npages %u npages %u",
+		 start_address, node->npages, npages);
+	pinned = hfi1_acquire_user_pages(current->mm, start_address, npages, 0,
+					 pages);
+
+	if (pinned < 0) {
+		kfree(pages);
+		SDMA_DBG(req, "pinned %d", pinned);
+		return pinned;
+	}
+	if (pinned != npages) {
+		unpin_vector_pages(current->mm, pages, node->npages, pinned);
+		SDMA_DBG(req, "npages %u pinned %d", npages, pinned);
+		return -EFAULT;
+	}
+	node->rb.addr = start_address;
+	node->rb.len = length;
+	node->pages = pages;
+	node->npages = npages;
+	atomic_add(pinned, &pq->n_locked);
+	SDMA_DBG(req, "done. pinned %d", pinned);
+	return 0;
+}
+
+static int add_system_pinning(struct user_sdma_request *req,
+			      struct sdma_mmu_node **node_p,
+			      unsigned long start, unsigned long len)
+
+{
+	struct hfi1_user_sdma_pkt_q *pq = req->pq;
+	struct sdma_mmu_node *node;
+	int ret;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	node->pq = pq;
+	ret = pin_system_pages(req, start, len, node, PFN_DOWN(len));
+	if (ret == 0) {
+		ret = hfi1_mmu_rb_insert(pq->handler, &node->rb);
+		if (ret)
+			free_system_node(node);
+		else
+			*node_p = node;
+
+		return ret;
+	}
+
+	kfree(node);
+	return ret;
+}
+
+static int get_system_cache_entry(struct user_sdma_request *req,
+				  struct sdma_mmu_node **node_p,
+				  size_t req_start, size_t req_len)
+{
+	struct hfi1_user_sdma_pkt_q *pq = req->pq;
+	u64 start = ALIGN_DOWN(req_start, PAGE_SIZE);
+	u64 end = PFN_ALIGN(req_start + req_len);
+	struct mmu_rb_handler *handler = pq->handler;
+	int ret;
+
+	if ((end - start) == 0) {
+		SDMA_DBG(req,
+			 "Request for empty cache entry req_start %lx req_len %lx start %llx end %llx",
+			 req_start, req_len, start, end);
+		return -EINVAL;
+	}
+
+	SDMA_DBG(req, "req_start %lx req_len %lu", req_start, req_len);
+
+	while (1) {
+		struct sdma_mmu_node *node =
+			find_system_node(handler, start, end);
+		u64 prepend_len = 0;
+
+		SDMA_DBG(req, "node %p start %llx end %llu", node, start, end);
+		if (!node) {
+			ret = add_system_pinning(req, node_p, start,
+						 end - start);
+			if (ret == -EEXIST) {
+				/*
+				 * Another execution context has inserted a
+				 * conficting entry first.
+				 */
+				continue;
+			}
+			return ret;
+		}
+
+		if (node->rb.addr <= start) {
+			/*
+			 * This entry covers at least part of the region. If it doesn't extend
+			 * to the end, then this will be called again for the next segment.
+			 */
+			*node_p = node;
+			return 0;
+		}
+
+		SDMA_DBG(req, "prepend: node->rb.addr %lx, node->refcount %d",
+			 node->rb.addr, atomic_read(&node->refcount));
+		prepend_len = node->rb.addr - start;
+
+		/*
+		 * This node will not be returned, instead a new node
+		 * will be. So release the reference.
+		 */
+		release_node(handler, node);
+
+		/* Prepend a node to cover the beginning of the allocation */
+		ret = add_system_pinning(req, node_p, start, prepend_len);
+		if (ret == -EEXIST) {
+			/* Another execution context has inserted a conficting entry first. */
+			continue;
+		}
+		return ret;
+	}
+}
+
+static int add_mapping_to_sdma_packet(struct user_sdma_request *req,
+				      struct user_sdma_txreq *tx,
+				      struct sdma_mmu_node *cache_entry,
+				      size_t start,
+				      size_t from_this_cache_entry)
+{
+	struct hfi1_user_sdma_pkt_q *pq = req->pq;
+	unsigned int page_offset;
+	unsigned int from_this_page;
+	size_t page_index;
+	void *ctx;
+	int ret;
+
+	/*
+	 * Because the cache may be more fragmented than the memory that is being accessed,
+	 * it's not strictly necessary to have a descriptor per cache entry.
+	 */
+
+	while (from_this_cache_entry) {
+		page_index = PFN_DOWN(start - cache_entry->rb.addr);
+
+		if (page_index >= cache_entry->npages) {
+			SDMA_DBG(req,
+				 "Request for page_index %zu >= cache_entry->npages %u",
+				 page_index, cache_entry->npages);
+			return -EINVAL;
+		}
+
+		page_offset = start - ALIGN_DOWN(start, PAGE_SIZE);
+		from_this_page = PAGE_SIZE - page_offset;
+
+		if (from_this_page < from_this_cache_entry) {
+			ctx = NULL;
+		} else {
+			/*
+			 * In the case they are equal the next line has no practical effect,
+			 * but it's better to do a register to register copy than a conditional
+			 * branch.
+			 */
+			from_this_page = from_this_cache_entry;
+			ctx = cache_entry;
+		}
+
+		ret = sdma_txadd_page(pq->dd, ctx, &tx->txreq,
+				      cache_entry->pages[page_index],
+				      page_offset, from_this_page);
+		if (ret) {
+			/*
+			 * When there's a failure, the entire request is freed by
+			 * user_sdma_send_pkts().
+			 */
+			SDMA_DBG(req,
+				 "sdma_txadd_page failed %d page_index %lu page_offset %u from_this_page %u",
+				 ret, page_index, page_offset, from_this_page);
+			return ret;
+		}
+		start += from_this_page;
+		from_this_cache_entry -= from_this_page;
+	}
+	return 0;
+}
+
+static int add_system_iovec_to_sdma_packet(struct user_sdma_request *req,
+					   struct user_sdma_txreq *tx,
+					   struct user_sdma_iovec *iovec,
+					   size_t from_this_iovec)
+{
+	struct mmu_rb_handler *handler = req->pq->handler;
+
+	while (from_this_iovec > 0) {
+		struct sdma_mmu_node *cache_entry;
+		size_t from_this_cache_entry;
+		size_t start;
+		int ret;
+
+		start = (uintptr_t)iovec->iov.iov_base + iovec->offset;
+		ret = get_system_cache_entry(req, &cache_entry, start,
+					     from_this_iovec);
+		if (ret) {
+			SDMA_DBG(req, "pin system segment failed %d", ret);
+			return ret;
+		}
+
+		from_this_cache_entry = cache_entry->rb.len - (start - cache_entry->rb.addr);
+		if (from_this_cache_entry > from_this_iovec)
+			from_this_cache_entry = from_this_iovec;
+
+		ret = add_mapping_to_sdma_packet(req, tx, cache_entry, start,
+						 from_this_cache_entry);
+		if (ret) {
+			/*
+			 * We're guaranteed that there will be no descriptor
+			 * completion callback that releases this node
+			 * because only the last descriptor referencing it
+			 * has a context attached, and a failure means the
+			 * last descriptor was never added.
+			 */
+			release_node(handler, cache_entry);
+			SDMA_DBG(req, "add system segment failed %d", ret);
+			return ret;
+		}
+
+		iovec->offset += from_this_cache_entry;
+		from_this_iovec -= from_this_cache_entry;
+	}
+
+	return 0;
+}
+
+static int add_system_pages_to_sdma_packet(struct user_sdma_request *req,
+					   struct user_sdma_txreq *tx,
+					   struct user_sdma_iovec *iovec,
+					   u32 *pkt_data_remaining)
+{
+	size_t remaining_to_add = *pkt_data_remaining;
+	/*
+	 * Walk through iovec entries, ensure the associated pages
+	 * are pinned and mapped, add data to the packet until no more
+	 * data remains to be added.
+	 */
+	while (remaining_to_add > 0) {
+		struct user_sdma_iovec *cur_iovec;
+		size_t from_this_iovec;
+		int ret;
+
+		cur_iovec = iovec;
+		from_this_iovec = iovec->iov.iov_len - iovec->offset;
+
+		if (from_this_iovec > remaining_to_add) {
+			from_this_iovec = remaining_to_add;
+		} else {
+			/* The current iovec entry will be consumed by this pass. */
+			req->iov_idx++;
+			iovec++;
+		}
+
+		ret = add_system_iovec_to_sdma_packet(req, tx, cur_iovec,
+						      from_this_iovec);
+		if (ret)
+			return ret;
+
+		remaining_to_add -= from_this_iovec;
+	}
+	*pkt_data_remaining = remaining_to_add;
+
+	return 0;
+}
+
+void system_descriptor_complete(struct hfi1_devdata *dd,
+				struct sdma_desc *descp)
+{
+	switch (sdma_mapping_type(descp)) {
+	case SDMA_MAP_SINGLE:
+		dma_unmap_single(&dd->pcidev->dev, sdma_mapping_addr(descp),
+				 sdma_mapping_len(descp), DMA_TO_DEVICE);
+		break;
+	case SDMA_MAP_PAGE:
+		dma_unmap_page(&dd->pcidev->dev, sdma_mapping_addr(descp),
+			       sdma_mapping_len(descp), DMA_TO_DEVICE);
+		break;
+	}
+
+	if (descp->pinning_ctx) {
+		struct sdma_mmu_node *node = descp->pinning_ctx;
+
+		release_node(node->rb.handler, node);
+	}
+}
+
 static bool sdma_rb_filter(struct mmu_rb_node *node, unsigned long addr,
 			   unsigned long len)
 {
@@ -1495,8 +1668,7 @@ static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode)
 	struct sdma_mmu_node *node =
 		container_of(mnode, struct sdma_mmu_node, rb);
 
-	unpin_sdma_pages(node);
-	kfree(node);
+	free_system_node(node);
 }
 
 static int sdma_rb_invalidate(void *arg, struct mmu_rb_node *mnode)
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.h b/drivers/infiniband/hw/hfi1/user_sdma.h
index ea56eb57e656..a241836371dc 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.h
+++ b/drivers/infiniband/hw/hfi1/user_sdma.h
@@ -112,16 +112,11 @@ struct sdma_mmu_node {
 struct user_sdma_iovec {
 	struct list_head list;
 	struct iovec iov;
-	/* number of pages in this vector */
-	unsigned int npages;
-	/* array of pinned pages for this vector */
-	struct page **pages;
 	/*
 	 * offset into the virtual address space of the vector at
 	 * which we last left off.
 	 */
 	u64 offset;
-	struct sdma_mmu_node *node;
 };
 
 /* evict operation argument */
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index ef8e0bdacb51..dcc167dcfc61 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -778,8 +778,8 @@ static int build_verbs_tx_desc(
 
 	/* add icrc, lt byte, and padding to flit */
 	if (extra_bytes)
-		ret = sdma_txadd_daddr(sde->dd, &tx->txreq,
-				       sde->dd->sdma_pad_phys, extra_bytes);
+		ret = sdma_txadd_daddr(sde->dd, &tx->txreq, sde->dd->sdma_pad_phys,
+				       extra_bytes);
 
 bail_txadd:
 	return ret;
diff --git a/drivers/infiniband/hw/hfi1/vnic_sdma.c b/drivers/infiniband/hw/hfi1/vnic_sdma.c
index c3f0f8d877c3..727eedfba332 100644
--- a/drivers/infiniband/hw/hfi1/vnic_sdma.c
+++ b/drivers/infiniband/hw/hfi1/vnic_sdma.c
@@ -64,6 +64,7 @@ static noinline int build_vnic_ulp_payload(struct sdma_engine *sde,
 
 		/* combine physically continuous fragments later? */
 		ret = sdma_txadd_page(sde->dd,
+				      NULL,
 				      &tx->txreq,
 				      skb_frag_page(frag),
 				      skb_frag_off(frag),
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 3a1a4ac9dd33..ec545b8858cc 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -412,9 +412,13 @@ static int set_user_sq_size(struct mlx4_ib_dev *dev,
 			    struct mlx4_ib_qp *qp,
 			    struct mlx4_ib_create_qp *ucmd)
 {
+	u32 cnt;
+
 	/* Sanity check SQ size before proceeding */
-	if ((1 << ucmd->log_sq_bb_count) > dev->dev->caps.max_wqes	 ||
-	    ucmd->log_sq_stride >
+	if (check_shl_overflow(1, ucmd->log_sq_bb_count, &cnt) ||
+	    cnt > dev->dev->caps.max_wqes)
+		return -EINVAL;
+	if (ucmd->log_sq_stride >
 		ilog2(roundup_pow_of_two(dev->dev->caps.max_sq_desc_sz)) ||
 	    ucmd->log_sq_stride < MLX4_IB_MIN_SQ_STRIDE)
 		return -EINVAL;
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 21beded40066..104e5cbba066 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -666,7 +666,21 @@ static bool devx_is_valid_obj_id(struct uverbs_attr_bundle *attrs,
 				      obj_id;
 
 	case MLX5_IB_OBJECT_DEVX_OBJ:
-		return ((struct devx_obj *)uobj->object)->obj_id == obj_id;
+	{
+		u16 opcode = MLX5_GET(general_obj_in_cmd_hdr, in, opcode);
+		struct devx_obj *devx_uobj = uobj->object;
+
+		if (opcode == MLX5_CMD_OP_QUERY_FLOW_COUNTER &&
+		    devx_uobj->flow_counter_bulk_size) {
+			u64 end;
+
+			end = devx_uobj->obj_id +
+				devx_uobj->flow_counter_bulk_size;
+			return devx_uobj->obj_id <= obj_id && end > obj_id;
+		}
+
+		return devx_uobj->obj_id == obj_id;
+	}
 
 	default:
 		return false;
@@ -1515,10 +1529,17 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_CREATE)(
 		goto obj_free;
 
 	if (opcode == MLX5_CMD_OP_ALLOC_FLOW_COUNTER) {
-		u8 bulk = MLX5_GET(alloc_flow_counter_in,
-				   cmd_in,
-				   flow_counter_bulk);
-		obj->flow_counter_bulk_size = 128UL * bulk;
+		u32 bulk = MLX5_GET(alloc_flow_counter_in,
+				    cmd_in,
+				    flow_counter_bulk_log_size);
+
+		if (bulk)
+			bulk = 1 << bulk;
+		else
+			bulk = 128UL * MLX5_GET(alloc_flow_counter_in,
+						cmd_in,
+						flow_counter_bulk);
+		obj->flow_counter_bulk_size = bulk;
 	}
 
 	uobj->object = obj;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 55b05a3e31b8..1080daf3a546 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4406,7 +4406,7 @@ static int mlx5_ib_modify_dct(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			return -EINVAL;
 
 		if (attr->port_num == 0 ||
-		    attr->port_num > MLX5_CAP_GEN(dev->mdev, num_ports)) {
+		    attr->port_num > dev->num_ports) {
 			mlx5_ib_dbg(dev, "invalid port number %d. number of ports is %d\n",
 				    attr->port_num, dev->num_ports);
 			return -EINVAL;
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 3acab569fbb9..2bdc4486c3da 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -464,8 +464,6 @@ void rvt_qp_exit(struct rvt_dev_info *rdi)
 	if (qps_inuse)
 		rvt_pr_err(rdi, "QP memory leak! %u still in use\n",
 			   qps_inuse);
-	if (!rdi->qp_dev)
-		return;
 
 	kfree(rdi->qp_dev->qp_table);
 	free_qpn_table(&rdi->qp_dev->qpn_table);
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 9093e6a80b26..f853f3c23540 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -437,9 +437,6 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
 
 	dev_dbg(&netdev->dev, "siw: event %lu\n", event);
 
-	if (dev_net(netdev) != &init_net)
-		return NOTIFY_OK;
-
 	base_dev = ib_device_get_by_netdev(netdev, RDMA_DRIVER_SIW);
 	if (!base_dev)
 		return NOTIFY_OK;
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 05052b49107f..6bb9e9e81ff4 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -558,7 +558,7 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 			data_len -= plen;
 			fp_off = 0;
 
-			if (++seg > (int)MAX_ARRAY) {
+			if (++seg >= (int)MAX_ARRAY) {
 				siw_dbg_qp(tx_qp(c_tx), "to many fragments\n");
 				siw_unmap_pages(iov, kmap_mask, seg-1);
 				wqe->processed -= c_tx->bytes_unsent;
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 7b69b0c9e48d..38494943bd74 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -549,6 +549,7 @@ static int srpt_format_guid(char *buf, unsigned int size, const __be64 *guid)
  */
 static int srpt_refresh_port(struct srpt_port *sport)
 {
+	struct ib_mad_agent *mad_agent;
 	struct ib_mad_reg_req reg_req;
 	struct ib_port_modify port_modify;
 	struct ib_port_attr port_attr;
@@ -593,24 +594,26 @@ static int srpt_refresh_port(struct srpt_port *sport)
 		set_bit(IB_MGMT_METHOD_GET, reg_req.method_mask);
 		set_bit(IB_MGMT_METHOD_SET, reg_req.method_mask);
 
-		sport->mad_agent = ib_register_mad_agent(sport->sdev->device,
-							 sport->port,
-							 IB_QPT_GSI,
-							 &reg_req, 0,
-							 srpt_mad_send_handler,
-							 srpt_mad_recv_handler,
-							 sport, 0);
-		if (IS_ERR(sport->mad_agent)) {
+		mad_agent = ib_register_mad_agent(sport->sdev->device,
+						  sport->port,
+						  IB_QPT_GSI,
+						  &reg_req, 0,
+						  srpt_mad_send_handler,
+						  srpt_mad_recv_handler,
+						  sport, 0);
+		if (IS_ERR(mad_agent)) {
 			pr_err("%s-%d: MAD agent registration failed (%ld). Note: this is expected if SR-IOV is enabled.\n",
 			       dev_name(&sport->sdev->device->dev), sport->port,
-			       PTR_ERR(sport->mad_agent));
+			       PTR_ERR(mad_agent));
 			sport->mad_agent = NULL;
 			memset(&port_modify, 0, sizeof(port_modify));
 			port_modify.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP;
 			ib_modify_port(sport->sdev->device, sport->port, 0,
 				       &port_modify);
-
+			return 0;
 		}
+
+		sport->mad_agent = mad_agent;
 	}
 
 	return 0;
diff --git a/drivers/input/touchscreen/raspberrypi-ts.c b/drivers/input/touchscreen/raspberrypi-ts.c
index 5000f5fd9ec3..45c575df994e 100644
--- a/drivers/input/touchscreen/raspberrypi-ts.c
+++ b/drivers/input/touchscreen/raspberrypi-ts.c
@@ -134,7 +134,7 @@ static int rpi_ts_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	fw = rpi_firmware_get(fw_node);
+	fw = devm_rpi_firmware_get(&pdev->dev, fw_node);
 	of_node_put(fw_node);
 	if (!fw)
 		return -EPROBE_DEFER;
@@ -160,7 +160,6 @@ static int rpi_ts_probe(struct platform_device *pdev)
 	touchbuf = (u32)ts->fw_regs_phys;
 	error = rpi_firmware_property(fw, RPI_FIRMWARE_FRAMEBUFFER_SET_TOUCHBUF,
 				      &touchbuf, sizeof(touchbuf));
-	rpi_firmware_put(fw);
 	if (error || touchbuf != 0) {
 		dev_warn(dev, "Failed to set touchbuf, %d\n", error);
 		return error;
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index b6e0bf186cf5..390f10060c82 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -918,8 +918,8 @@ struct amd_ir_data {
 	 */
 	struct irq_cfg *cfg;
 	int ga_vector;
-	int ga_root_ptr;
-	int ga_tag;
+	u64 ga_root_ptr;
+	u32 ga_tag;
 };
 
 struct amd_irte_ops {
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index ed800f5da7d8..8bf545100fb0 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -821,7 +821,7 @@ config LEDS_SPI_BYTE
 config LEDS_TI_LMU_COMMON
 	tristate "LED driver for TI LMU"
 	depends on LEDS_CLASS
-	depends on REGMAP
+	select REGMAP
 	help
 	  Say Y to enable the LED driver for TI LMU devices.
 	  This supports common features between the TI LM3532, LM3631, LM3632,
diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
index 225b765830bd..caad9d3e0eac 100644
--- a/drivers/leds/leds-tca6507.c
+++ b/drivers/leds/leds-tca6507.c
@@ -696,8 +696,9 @@ tca6507_led_dt_init(struct device *dev)
 		if (fwnode_property_read_string(child, "label", &led.name))
 			led.name = fwnode_get_name(child);
 
-		fwnode_property_read_string(child, "linux,default-trigger",
-					    &led.default_trigger);
+		if (fwnode_property_read_string(child, "linux,default-trigger",
+						&led.default_trigger))
+			led.default_trigger = NULL;
 
 		led.flags = 0;
 		if (fwnode_property_match_string(child, "compatible",
diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 539a2ed4e13d..a0e717a986dc 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -86,6 +86,7 @@ config ADB_PMU_LED
 
 config ADB_PMU_LED_DISK
 	bool "Use front LED as DISK LED by default"
+	depends on ATA
 	depends on ADB_PMU_LED
 	depends on LEDS_CLASS
 	select LEDS_TRIGGERS
diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index e46e1153a0b4..7d7d6213e32a 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -171,6 +171,7 @@ static void wf_sat_release(struct kref *ref)
 
 	if (sat->nr >= 0)
 		sats[sat->nr] = NULL;
+	of_node_put(sat->node);
 	kfree(sat);
 }
 
diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpfs.c
index 853901acaeec..08aa840cccac 100644
--- a/drivers/mailbox/mailbox-mpfs.c
+++ b/drivers/mailbox/mailbox-mpfs.c
@@ -79,6 +79,13 @@ static bool mpfs_mbox_busy(struct mpfs_mbox *mbox)
 	return status & SCB_STATUS_BUSY_MASK;
 }
 
+static bool mpfs_mbox_last_tx_done(struct mbox_chan *chan)
+{
+	struct mpfs_mbox *mbox = (struct mpfs_mbox *)chan->con_priv;
+
+	return !mpfs_mbox_busy(mbox);
+}
+
 static int mpfs_mbox_send_data(struct mbox_chan *chan, void *data)
 {
 	struct mpfs_mbox *mbox = (struct mpfs_mbox *)chan->con_priv;
@@ -182,7 +189,6 @@ static irqreturn_t mpfs_mbox_inbox_isr(int irq, void *data)
 
 	mpfs_mbox_rx_data(chan);
 
-	mbox_chan_txdone(chan, 0);
 	return IRQ_HANDLED;
 }
 
@@ -212,6 +218,7 @@ static const struct mbox_chan_ops mpfs_mbox_ops = {
 	.send_data = mpfs_mbox_send_data,
 	.startup = mpfs_mbox_startup,
 	.shutdown = mpfs_mbox_shutdown,
+	.last_tx_done = mpfs_mbox_last_tx_done,
 };
 
 static int mpfs_mbox_probe(struct platform_device *pdev)
@@ -247,7 +254,8 @@ static int mpfs_mbox_probe(struct platform_device *pdev)
 	mbox->controller.num_chans = 1;
 	mbox->controller.chans = mbox->chans;
 	mbox->controller.ops = &mpfs_mbox_ops;
-	mbox->controller.txdone_irq = true;
+	mbox->controller.txdone_poll = true;
+	mbox->controller.txpoll_period = 10u;
 
 	ret = devm_mbox_controller_register(&pdev->dev, &mbox->controller);
 	if (ret) {
diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 527204c6d5cd..05e36229622e 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -152,7 +152,7 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
 	struct zynqmp_ipi_message *msg;
 	u64 arg0, arg3;
 	struct arm_smccc_res res;
-	int ret, i;
+	int ret, i, status = IRQ_NONE;
 
 	(void)irq;
 	arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
@@ -170,11 +170,11 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
 				memcpy_fromio(msg->data, mchan->req_buf,
 					      msg->len);
 				mbox_chan_received_data(chan, (void *)msg);
-				return IRQ_HANDLED;
+				status = IRQ_HANDLED;
 			}
 		}
 	}
-	return IRQ_NONE;
+	return status;
 }
 
 /**
diff --git a/drivers/md/dm-clone-target.c b/drivers/md/dm-clone-target.c
index ec4f2487ef10..f49fdc9fb5c3 100644
--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -2214,6 +2214,7 @@ static int __init dm_clone_init(void)
 	r = dm_register_target(&clone_target);
 	if (r < 0) {
 		DMERR("Failed to register clone target");
+		kmem_cache_destroy(_hydration_cache);
 		return r;
 	}
 
diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index bf7f205354f0..6f3eb161ad2a 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -124,9 +124,9 @@ static int parse_features(struct dm_arg_set *as, struct flakey_c *fc,
 			 * Direction r or w?
 			 */
 			arg_name = dm_shift_arg(as);
-			if (!strcasecmp(arg_name, "w"))
+			if (arg_name && !strcasecmp(arg_name, "w"))
 				fc->corrupt_bio_rw = WRITE;
-			else if (!strcasecmp(arg_name, "r"))
+			else if (arg_name && !strcasecmp(arg_name, "r"))
 				fc->corrupt_bio_rw = READ;
 			else {
 				ti->error = "Invalid corrupt bio direction (r or w)";
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 508e81bfef2c..c09693daabd8 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4632,11 +4632,13 @@ static int __init dm_integrity_init(void)
 	}
 
 	r = dm_register_target(&integrity_target);
-
-	if (r < 0)
+	if (r < 0) {
 		DMERR("register failed %d", r);
+		kmem_cache_destroy(journal_io_cache);
+		return r;
+	}
 
-	return r;
+	return 0;
 }
 
 static void __exit dm_integrity_exit(void)
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index e277feb5ff93..438c0b77bb48 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1145,10 +1145,13 @@ static int do_resume(struct dm_ioctl *param)
 	/* Do we need to load a new map ? */
 	if (new_map) {
 		sector_t old_size, new_size;
+		int srcu_idx;
 
 		/* Suspend if it isn't already suspended */
-		if (param->flags & DM_SKIP_LOCKFS_FLAG)
+		old_map = dm_get_live_table(md, &srcu_idx);
+		if ((param->flags & DM_SKIP_LOCKFS_FLAG) || !old_map)
 			suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
+		dm_put_live_table(md, srcu_idx);
 		if (param->flags & DM_NOFLUSH_FLAG)
 			suspend_flags |= DM_SUSPEND_NOFLUSH_FLAG;
 		if (!dm_suspended_md(md))
@@ -1533,11 +1536,12 @@ static int table_clear(struct file *filp, struct dm_ioctl *param, size_t param_s
 		has_new_map = true;
 	}
 
-	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
-
-	__dev_status(hc->md, param);
 	md = hc->md;
 	up_write(&_hash_lock);
+
+	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
+	__dev_status(md, param);
+
 	if (old_map) {
 		dm_sync_table(md);
 		dm_table_destroy(old_map);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 2111daaacaba..46ec4590f62f 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1191,21 +1191,12 @@ struct dm_keyslot_manager {
 	struct mapped_device *md;
 };
 
-struct dm_keyslot_evict_args {
-	const struct blk_crypto_key *key;
-	int err;
-};
-
 static int dm_keyslot_evict_callback(struct dm_target *ti, struct dm_dev *dev,
 				     sector_t start, sector_t len, void *data)
 {
-	struct dm_keyslot_evict_args *args = data;
-	int err;
+	const struct blk_crypto_key *key = data;
 
-	err = blk_crypto_evict_key(bdev_get_queue(dev->bdev), args->key);
-	if (!args->err)
-		args->err = err;
-	/* Always try to evict the key from all devices. */
+	blk_crypto_evict_key(bdev_get_queue(dev->bdev), key);
 	return 0;
 }
 
@@ -1220,7 +1211,6 @@ static int dm_keyslot_evict(struct blk_keyslot_manager *ksm,
 						       struct dm_keyslot_manager,
 						       ksm);
 	struct mapped_device *md = dksm->md;
-	struct dm_keyslot_evict_args args = { key };
 	struct dm_table *t;
 	int srcu_idx;
 	int i;
@@ -1233,10 +1223,11 @@ static int dm_keyslot_evict(struct blk_keyslot_manager *ksm,
 		ti = dm_table_get_target(t, i);
 		if (!ti->type->iterate_devices)
 			continue;
-		ti->type->iterate_devices(ti, dm_keyslot_evict_callback, &args);
+		ti->type->iterate_devices(ti, dm_keyslot_evict_callback,
+					  (void *)key);
 	}
 	dm_put_live_table(md, srcu_idx);
-	return args.err;
+	return 0;
 }
 
 static const struct blk_ksm_ll_ops dm_ksm_ll_ops = {
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 426299ceb33d..1a2509623874 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -482,7 +482,7 @@ static int verity_verify_io(struct dm_verity_io *io)
 		sector_t cur_block = io->block + b;
 		struct ahash_request *req = verity_io_hash_req(v, io);
 
-		if (v->validated_blocks &&
+		if (v->validated_blocks && bio->bi_status == BLK_STS_OK &&
 		    likely(test_bit(cur_block, v->validated_blocks))) {
 			verity_bv_skip_block(v, io, &io->iter);
 			continue;
diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 54db34163968..83f9a4f3d82e 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -22,12 +22,6 @@
 
 #define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
 
-/* When there are this many requests queue to be written by
- * the raid thread, we become 'congested' to provide back-pressure
- * for writeback.
- */
-static int max_queued_requests = 1024;
-
 /* for managing resync I/O pages */
 struct resync_pages {
 	void		*raid_bio;
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 783763f6845f..47997a9a3ca1 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1358,12 +1358,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	r1_bio = alloc_r1bio(mddev, bio);
 	r1_bio->sectors = max_write_sectors;
 
-	if (conf->pending_count >= max_queued_requests) {
-		md_wakeup_thread(mddev->thread);
-		raid1_log(mddev, "wait queued");
-		wait_event(conf->wait_barrier,
-			   conf->pending_count < max_queued_requests);
-	}
 	/* first select target devices under rcu_lock and
 	 * inc refcount on their rdev.  Record them by setting
 	 * bios[x] to bio
@@ -3413,4 +3407,3 @@ MODULE_ALIAS("md-personality-3"); /* RAID1 */
 MODULE_ALIAS("md-raid1");
 MODULE_ALIAS("md-level-1");
 
-module_param(max_queued_requests, int, S_IRUGO|S_IWUSR);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index c4c1a3a7d7ab..1f5589c5294d 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -952,42 +952,62 @@ static void lower_barrier(struct r10conf *conf)
 	wake_up(&conf->wait_barrier);
 }
 
-static void wait_barrier(struct r10conf *conf)
+static bool stop_waiting_barrier(struct r10conf *conf)
 {
+	struct bio_list *bio_list = current->bio_list;
+
+	/* barrier is dropped */
+	if (!conf->barrier)
+		return true;
+
+	/*
+	 * If there are already pending requests (preventing the barrier from
+	 * rising completely), and the pre-process bio queue isn't empty, then
+	 * don't wait, as we need to empty that queue to get the nr_pending
+	 * count down.
+	 */
+	if (atomic_read(&conf->nr_pending) && bio_list &&
+	    (!bio_list_empty(&bio_list[0]) || !bio_list_empty(&bio_list[1])))
+		return true;
+
+	/*
+	 * move on if io is issued from raid10d(), nr_pending is not released
+	 * from original io(see handle_read_error()). All raise barrier is
+	 * blocked until this io is done.
+	 */
+	if (conf->mddev->thread->tsk == current) {
+		WARN_ON_ONCE(atomic_read(&conf->nr_pending) == 0);
+		return true;
+	}
+
+	return false;
+}
+
+static bool wait_barrier(struct r10conf *conf, bool nowait)
+{
+	bool ret = true;
+
 	spin_lock_irq(&conf->resync_lock);
 	if (conf->barrier) {
-		struct bio_list *bio_list = current->bio_list;
 		conf->nr_waiting++;
-		/* Wait for the barrier to drop.
-		 * However if there are already pending
-		 * requests (preventing the barrier from
-		 * rising completely), and the
-		 * pre-process bio queue isn't empty,
-		 * then don't wait, as we need to empty
-		 * that queue to get the nr_pending
-		 * count down.
-		 */
-		raid10_log(conf->mddev, "wait barrier");
-		wait_event_lock_irq(conf->wait_barrier,
-				    !conf->barrier ||
-				    (atomic_read(&conf->nr_pending) &&
-				     bio_list &&
-				     (!bio_list_empty(&bio_list[0]) ||
-				      !bio_list_empty(&bio_list[1]))) ||
-				     /* move on if recovery thread is
-				      * blocked by us
-				      */
-				     (conf->mddev->thread->tsk == current &&
-				      test_bit(MD_RECOVERY_RUNNING,
-					       &conf->mddev->recovery) &&
-				      conf->nr_queued > 0),
-				    conf->resync_lock);
+		/* Return false when nowait flag is set */
+		if (nowait) {
+			ret = false;
+		} else {
+			raid10_log(conf->mddev, "wait barrier");
+			wait_event_lock_irq(conf->wait_barrier,
+					    stop_waiting_barrier(conf),
+					    conf->resync_lock);
+		}
 		conf->nr_waiting--;
 		if (!conf->nr_waiting)
 			wake_up(&conf->wait_barrier);
 	}
-	atomic_inc(&conf->nr_pending);
+	/* Only increment nr_pending when we wait */
+	if (ret)
+		atomic_inc(&conf->nr_pending);
 	spin_unlock_irq(&conf->resync_lock);
+	return ret;
 }
 
 static void allow_barrier(struct r10conf *conf)
@@ -1098,21 +1118,30 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
  * currently.
  * 2. If IO spans the reshape position.  Need to wait for reshape to pass.
  */
-static void regular_request_wait(struct mddev *mddev, struct r10conf *conf,
+static bool regular_request_wait(struct mddev *mddev, struct r10conf *conf,
 				 struct bio *bio, sector_t sectors)
 {
-	wait_barrier(conf);
+	/* Bail out if REQ_NOWAIT is set for the bio */
+	if (!wait_barrier(conf, bio->bi_opf & REQ_NOWAIT)) {
+		bio_wouldblock_error(bio);
+		return false;
+	}
 	while (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
 	    bio->bi_iter.bi_sector < conf->reshape_progress &&
 	    bio->bi_iter.bi_sector + sectors > conf->reshape_progress) {
-		raid10_log(conf->mddev, "wait reshape");
 		allow_barrier(conf);
+		if (bio->bi_opf & REQ_NOWAIT) {
+			bio_wouldblock_error(bio);
+			return false;
+		}
+		raid10_log(conf->mddev, "wait reshape");
 		wait_event(conf->wait_barrier,
 			   conf->reshape_progress <= bio->bi_iter.bi_sector ||
 			   conf->reshape_progress >= bio->bi_iter.bi_sector +
 			   sectors);
-		wait_barrier(conf);
+		wait_barrier(conf, false);
 	}
+	return true;
 }
 
 static void raid10_read_request(struct mddev *mddev, struct bio *bio,
@@ -1157,7 +1186,8 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 		rcu_read_unlock();
 	}
 
-	regular_request_wait(mddev, conf, bio, r10_bio->sectors);
+	if (!regular_request_wait(mddev, conf, bio, r10_bio->sectors))
+		return;
 	rdev = read_balance(conf, r10_bio, &max_sectors);
 	if (!rdev) {
 		if (err_rdev) {
@@ -1179,14 +1209,15 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 		bio_chain(split, bio);
 		allow_barrier(conf);
 		submit_bio_noacct(bio);
-		wait_barrier(conf);
+		wait_barrier(conf, false);
 		bio = split;
 		r10_bio->master_bio = bio;
 		r10_bio->sectors = max_sectors;
 	}
 	slot = r10_bio->read_slot;
 
-	if (blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
+	if (!r10_bio->start_time &&
+	    blk_queue_io_stat(bio->bi_bdev->bd_disk->queue))
 		r10_bio->start_time = bio_start_io_acct(bio);
 	read_bio = bio_clone_fast(bio, gfp, &mddev->bio_set);
 
@@ -1338,7 +1369,7 @@ static void wait_blocked_dev(struct mddev *mddev, struct r10bio *r10_bio)
 		raid10_log(conf->mddev, "%s wait rdev %d blocked",
 				__func__, blocked_rdev->raid_disk);
 		md_wait_for_blocked_rdev(blocked_rdev, mddev);
-		wait_barrier(conf);
+		wait_barrier(conf, false);
 		goto retry_wait;
 	}
 }
@@ -1356,6 +1387,11 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 					    bio->bi_iter.bi_sector,
 					    bio_end_sector(bio)))) {
 		DEFINE_WAIT(w);
+		/* Bail out if REQ_NOWAIT is set for the bio */
+		if (bio->bi_opf & REQ_NOWAIT) {
+			bio_wouldblock_error(bio);
+			return;
+		}
 		for (;;) {
 			prepare_to_wait(&conf->wait_barrier,
 					&w, TASK_IDLE);
@@ -1368,7 +1404,8 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 	}
 
 	sectors = r10_bio->sectors;
-	regular_request_wait(mddev, conf, bio, sectors);
+	if (!regular_request_wait(mddev, conf, bio, sectors))
+		return;
 	if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
 	    (mddev->reshape_backwards
 	     ? (bio->bi_iter.bi_sector < conf->reshape_safe &&
@@ -1380,6 +1417,11 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 		set_mask_bits(&mddev->sb_flags, 0,
 			      BIT(MD_SB_CHANGE_DEVS) | BIT(MD_SB_CHANGE_PENDING));
 		md_wakeup_thread(mddev->thread);
+		if (bio->bi_opf & REQ_NOWAIT) {
+			allow_barrier(conf);
+			bio_wouldblock_error(bio);
+			return;
+		}
 		raid10_log(conf->mddev, "wait reshape metadata");
 		wait_event(mddev->sb_wait,
 			   !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
@@ -1387,12 +1429,6 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 		conf->reshape_safe = mddev->reshape_position;
 	}
 
-	if (conf->pending_count >= max_queued_requests) {
-		md_wakeup_thread(mddev->thread);
-		raid10_log(mddev, "wait queued");
-		wait_event(conf->wait_barrier,
-			   conf->pending_count < max_queued_requests);
-	}
 	/* first select target devices under rcu_lock and
 	 * inc refcount on their rdev.  Record them by setting
 	 * bios[x] to bio
@@ -1482,7 +1518,7 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 		bio_chain(split, bio);
 		allow_barrier(conf);
 		submit_bio_noacct(bio);
-		wait_barrier(conf);
+		wait_barrier(conf, false);
 		bio = split;
 		r10_bio->master_bio = bio;
 	}
@@ -1515,6 +1551,7 @@ static void __make_request(struct mddev *mddev, struct bio *bio, int sectors)
 	r10_bio->sector = bio->bi_iter.bi_sector;
 	r10_bio->state = 0;
 	r10_bio->read_slot = -1;
+	r10_bio->start_time = 0;
 	memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) *
 			conf->geo.raid_disks);
 
@@ -1607,7 +1644,11 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 	if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery))
 		return -EAGAIN;
 
-	wait_barrier(conf);
+	if (WARN_ON_ONCE(bio->bi_opf & REQ_NOWAIT)) {
+		bio_wouldblock_error(bio);
+		return 0;
+	}
+	wait_barrier(conf, false);
 
 	/*
 	 * Check reshape again to avoid reshape happens after checking
@@ -1649,7 +1690,7 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 		allow_barrier(conf);
 		/* Resend the fist split part */
 		submit_bio_noacct(split);
-		wait_barrier(conf);
+		wait_barrier(conf, false);
 	}
 	div_u64_rem(bio_end, stripe_size, &remainder);
 	if (remainder) {
@@ -1660,7 +1701,7 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 		/* Resend the second split part */
 		submit_bio_noacct(bio);
 		bio = split;
-		wait_barrier(conf);
+		wait_barrier(conf, false);
 	}
 
 	bio_start = bio->bi_iter.bi_sector;
@@ -1816,7 +1857,7 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 		end_disk_offset += geo->stride;
 		atomic_inc(&first_r10bio->remaining);
 		raid_end_discard_bio(r10_bio);
-		wait_barrier(conf);
+		wait_barrier(conf, false);
 		goto retry_discard;
 	}
 
@@ -2011,7 +2052,7 @@ static void print_conf(struct r10conf *conf)
 
 static void close_sync(struct r10conf *conf)
 {
-	wait_barrier(conf);
+	wait_barrier(conf, false);
 	allow_barrier(conf);
 
 	mempool_exit(&conf->r10buf_pool);
@@ -2542,11 +2583,22 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 {
 	struct r10conf *conf = mddev->private;
 	int d;
-	struct bio *wbio, *wbio2;
+	struct bio *wbio = r10_bio->devs[1].bio;
+	struct bio *wbio2 = r10_bio->devs[1].repl_bio;
+
+	/* Need to test wbio2->bi_end_io before we call
+	 * submit_bio_noacct as if the former is NULL,
+	 * the latter is free to free wbio2.
+	 */
+	if (wbio2 && !wbio2->bi_end_io)
+		wbio2 = NULL;
 
 	if (!test_bit(R10BIO_Uptodate, &r10_bio->state)) {
 		fix_recovery_read_error(r10_bio);
-		end_sync_request(r10_bio);
+		if (wbio->bi_end_io)
+			end_sync_request(r10_bio);
+		if (wbio2)
+			end_sync_request(r10_bio);
 		return;
 	}
 
@@ -2555,14 +2607,6 @@ static void recovery_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 	 * and submit the write request
 	 */
 	d = r10_bio->devs[1].devnum;
-	wbio = r10_bio->devs[1].bio;
-	wbio2 = r10_bio->devs[1].repl_bio;
-	/* Need to test wbio2->bi_end_io before we call
-	 * submit_bio_noacct as if the former is NULL,
-	 * the latter is free to free wbio2.
-	 */
-	if (wbio2 && !wbio2->bi_end_io)
-		wbio2 = NULL;
 	if (wbio->bi_end_io) {
 		atomic_inc(&conf->mirrors[d].rdev->nr_pending);
 		md_sync_acct(conf->mirrors[d].rdev->bdev, bio_sectors(wbio));
@@ -2919,9 +2963,13 @@ static void handle_read_error(struct mddev *mddev, struct r10bio *r10_bio)
 		md_error(mddev, rdev);
 
 	rdev_dec_pending(rdev, mddev);
-	allow_barrier(conf);
 	r10_bio->state = 0;
 	raid10_read_request(mddev, r10_bio->master_bio, r10_bio);
+	/*
+	 * allow_barrier after re-submit to ensure no sync io
+	 * can be issued while regular io pending.
+	 */
+	allow_barrier(conf);
 }
 
 static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
@@ -3230,10 +3278,6 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 	sector_t chunk_mask = conf->geo.chunk_mask;
 	int page_idx = 0;
 
-	if (!mempool_initialized(&conf->r10buf_pool))
-		if (init_resync(conf))
-			return 0;
-
 	/*
 	 * Allow skipping a full rebuild for incremental assembly
 	 * of a clean array, like RAID1 does.
@@ -3249,6 +3293,10 @@ static sector_t raid10_sync_request(struct mddev *mddev, sector_t sector_nr,
 		return mddev->dev_sectors - sector_nr;
 	}
 
+	if (!mempool_initialized(&conf->r10buf_pool))
+		if (init_resync(conf))
+			return 0;
+
  skipped:
 	max_sector = mddev->dev_sectors;
 	if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery) ||
@@ -3945,6 +3993,20 @@ static int setup_geo(struct geom *geo, struct mddev *mddev, enum geo_type new)
 	return nc*fc;
 }
 
+static void raid10_free_conf(struct r10conf *conf)
+{
+	if (!conf)
+		return;
+
+	mempool_exit(&conf->r10bio_pool);
+	kfree(conf->mirrors);
+	kfree(conf->mirrors_old);
+	kfree(conf->mirrors_new);
+	safe_put_page(conf->tmppage);
+	bioset_exit(&conf->bio_split);
+	kfree(conf);
+}
+
 static struct r10conf *setup_conf(struct mddev *mddev)
 {
 	struct r10conf *conf = NULL;
@@ -4027,13 +4089,7 @@ static struct r10conf *setup_conf(struct mddev *mddev)
 	return conf;
 
  out:
-	if (conf) {
-		mempool_exit(&conf->r10bio_pool);
-		kfree(conf->mirrors);
-		safe_put_page(conf->tmppage);
-		bioset_exit(&conf->bio_split);
-		kfree(conf);
-	}
+	raid10_free_conf(conf);
 	return ERR_PTR(err);
 }
 
@@ -4071,6 +4127,9 @@ static int raid10_run(struct mddev *mddev)
 	if (!conf)
 		goto out;
 
+	mddev->thread = conf->thread;
+	conf->thread = NULL;
+
 	if (mddev_is_clustered(conf->mddev)) {
 		int fc, fo;
 
@@ -4083,9 +4142,6 @@ static int raid10_run(struct mddev *mddev)
 		}
 	}
 
-	mddev->thread = conf->thread;
-	conf->thread = NULL;
-
 	if (mddev->queue) {
 		blk_queue_max_discard_sectors(mddev->queue,
 					      UINT_MAX);
@@ -4239,10 +4295,7 @@ static int raid10_run(struct mddev *mddev)
 
 out_free_conf:
 	md_unregister_thread(&mddev->thread);
-	mempool_exit(&conf->r10bio_pool);
-	safe_put_page(conf->tmppage);
-	kfree(conf->mirrors);
-	kfree(conf);
+	raid10_free_conf(conf);
 	mddev->private = NULL;
 out:
 	return -EIO;
@@ -4250,15 +4303,7 @@ static int raid10_run(struct mddev *mddev)
 
 static void raid10_free(struct mddev *mddev, void *priv)
 {
-	struct r10conf *conf = priv;
-
-	mempool_exit(&conf->r10bio_pool);
-	safe_put_page(conf->tmppage);
-	kfree(conf->mirrors);
-	kfree(conf->mirrors_old);
-	kfree(conf->mirrors_new);
-	bioset_exit(&conf->bio_split);
-	kfree(conf);
+	raid10_free_conf(priv);
 }
 
 static void raid10_quiesce(struct mddev *mddev, int quiesce)
@@ -4822,7 +4867,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 	if (need_flush ||
 	    time_after(jiffies, conf->reshape_checkpoint + 10*HZ)) {
 		/* Need to update reshape_position in metadata */
-		wait_barrier(conf);
+		wait_barrier(conf, false);
 		mddev->reshape_position = conf->reshape_progress;
 		if (mddev->reshape_backwards)
 			mddev->curr_resync_completed = raid10_size(mddev, 0, 0)
@@ -5245,5 +5290,3 @@ MODULE_DESCRIPTION("RAID10 (striped mirror) personality for MD");
 MODULE_ALIAS("md-personality-9"); /* RAID10 */
 MODULE_ALIAS("md-raid10");
 MODULE_ALIAS("md-level-10");
-
-module_param(max_queued_requests, int, S_IRUGO|S_IWUSR);
diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
index b9513e93ac61..404a03f48b97 100644
--- a/drivers/media/i2c/max9286.c
+++ b/drivers/media/i2c/max9286.c
@@ -937,6 +937,7 @@ static int max9286_v4l2_register(struct max9286_priv *priv)
 static void max9286_v4l2_unregister(struct max9286_priv *priv)
 {
 	fwnode_handle_put(priv->sd.fwnode);
+	v4l2_ctrl_handler_free(&priv->ctrls);
 	v4l2_async_unregister_subdev(&priv->sd);
 	max9286_v4l2_notifier_unregister(priv);
 }
diff --git a/drivers/media/pci/dm1105/dm1105.c b/drivers/media/pci/dm1105/dm1105.c
index 4ac645a56c14..9e9c7c071acc 100644
--- a/drivers/media/pci/dm1105/dm1105.c
+++ b/drivers/media/pci/dm1105/dm1105.c
@@ -1176,6 +1176,7 @@ static void dm1105_remove(struct pci_dev *pdev)
 	struct dvb_demux *dvbdemux = &dev->demux;
 	struct dmx_demux *dmx = &dvbdemux->dmx;
 
+	cancel_work_sync(&dev->ir.work);
 	dm1105_ir_exit(dev);
 	dmx->close(dmx);
 	dvb_net_release(&dev->dvbnet);
diff --git a/drivers/media/pci/saa7134/saa7134-ts.c b/drivers/media/pci/saa7134/saa7134-ts.c
index 6a5053126237..437dbe5e75e2 100644
--- a/drivers/media/pci/saa7134/saa7134-ts.c
+++ b/drivers/media/pci/saa7134/saa7134-ts.c
@@ -300,6 +300,7 @@ int saa7134_ts_start(struct saa7134_dev *dev)
 
 int saa7134_ts_fini(struct saa7134_dev *dev)
 {
+	del_timer_sync(&dev->ts_q.timeout);
 	saa7134_pgtable_free(dev->pci, &dev->ts_q.pt);
 	return 0;
 }
diff --git a/drivers/media/pci/saa7134/saa7134-vbi.c b/drivers/media/pci/saa7134/saa7134-vbi.c
index 3f0b0933eed6..3e773690468b 100644
--- a/drivers/media/pci/saa7134/saa7134-vbi.c
+++ b/drivers/media/pci/saa7134/saa7134-vbi.c
@@ -185,6 +185,7 @@ int saa7134_vbi_init1(struct saa7134_dev *dev)
 int saa7134_vbi_fini(struct saa7134_dev *dev)
 {
 	/* nothing */
+	del_timer_sync(&dev->vbi_q.timeout);
 	return 0;
 }
 
diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
index 374c8e1087de..81bb9a367195 100644
--- a/drivers/media/pci/saa7134/saa7134-video.c
+++ b/drivers/media/pci/saa7134/saa7134-video.c
@@ -2153,6 +2153,7 @@ int saa7134_video_init1(struct saa7134_dev *dev)
 
 void saa7134_video_fini(struct saa7134_dev *dev)
 {
+	del_timer_sync(&dev->video_q.timeout);
 	/* free stuff */
 	saa7134_pgtable_free(dev->pci, &dev->video_q.pt);
 	saa7134_pgtable_free(dev->pci, &dev->vbi_q.pt);
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 9a4443a390b1..6e0466772339 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -498,6 +498,7 @@ static int
 vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
 {
 	struct venus_inst *inst = to_inst(file);
+	struct vb2_queue *dst_vq;
 	struct hfi_frame_data fdata = {0};
 	int ret;
 
@@ -528,6 +529,13 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
 			inst->codec_state = VENUS_DEC_STATE_DRAIN;
 			inst->drain_active = true;
 		}
+	} else if (cmd->cmd == V4L2_DEC_CMD_START &&
+		   inst->codec_state == VENUS_DEC_STATE_STOPPED) {
+		dst_vq = v4l2_m2m_get_vq(inst->fh.m2m_ctx,
+					 V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
+		vb2_clear_last_buffer_dequeued(dst_vq);
+
+		inst->codec_state = VENUS_DEC_STATE_DECODING;
 	}
 
 unlock:
diff --git a/drivers/media/platform/rcar_fdp1.c b/drivers/media/platform/rcar_fdp1.c
index 89aac60066d9..c548cb01957b 100644
--- a/drivers/media/platform/rcar_fdp1.c
+++ b/drivers/media/platform/rcar_fdp1.c
@@ -2256,7 +2256,6 @@ static int fdp1_probe(struct platform_device *pdev)
 	struct fdp1_dev *fdp1;
 	struct video_device *vfd;
 	struct device_node *fcp_node;
-	struct resource *res;
 	struct clk *clk;
 	unsigned int i;
 
@@ -2283,17 +2282,15 @@ static int fdp1_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, fdp1);
 
 	/* Memory-mapped registers */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	fdp1->regs = devm_ioremap_resource(&pdev->dev, res);
+	fdp1->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fdp1->regs))
 		return PTR_ERR(fdp1->regs);
 
 	/* Interrupt service routine registration */
-	fdp1->irq = ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "cannot find IRQ\n");
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
 		return ret;
-	}
+	fdp1->irq = ret;
 
 	ret = devm_request_irq(&pdev->dev, fdp1->irq, fdp1_irq_handler, 0,
 			       dev_name(&pdev->dev), fdp1);
@@ -2316,8 +2313,10 @@ static int fdp1_probe(struct platform_device *pdev)
 
 	/* Determine our clock rate */
 	clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto put_dev;
+	}
 
 	fdp1->clk_rate = clk_get_rate(clk);
 	clk_put(clk);
@@ -2326,7 +2325,7 @@ static int fdp1_probe(struct platform_device *pdev)
 	ret = v4l2_device_register(&pdev->dev, &fdp1->v4l2_dev);
 	if (ret) {
 		v4l2_err(&fdp1->v4l2_dev, "Failed to register video device\n");
-		return ret;
+		goto put_dev;
 	}
 
 	/* M2M registration */
@@ -2396,10 +2395,12 @@ static int fdp1_probe(struct platform_device *pdev)
 unreg_dev:
 	v4l2_device_unregister(&fdp1->v4l2_dev);
 
+put_dev:
+	rcar_fcp_put(fdp1->fcp);
 	return ret;
 }
 
-static int fdp1_remove(struct platform_device *pdev)
+static void fdp1_remove(struct platform_device *pdev)
 {
 	struct fdp1_dev *fdp1 = platform_get_drvdata(pdev);
 
@@ -2407,8 +2408,7 @@ static int fdp1_remove(struct platform_device *pdev)
 	video_unregister_device(&fdp1->vfd);
 	v4l2_device_unregister(&fdp1->v4l2_dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
+	rcar_fcp_put(fdp1->fcp);
 }
 
 static int __maybe_unused fdp1_pm_runtime_suspend(struct device *dev)
@@ -2444,7 +2444,7 @@ MODULE_DEVICE_TABLE(of, fdp1_dt_ids);
 
 static struct platform_driver fdp1_pdrv = {
 	.probe		= fdp1_probe,
-	.remove		= fdp1_remove,
+	.remove_new	= fdp1_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.of_match_table = fdp1_dt_ids,
diff --git a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
index 6413cd279125..19a0f12483db 100644
--- a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
+++ b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
@@ -1310,6 +1310,8 @@ static int bdisp_probe(struct platform_device *pdev)
 	init_waitqueue_head(&bdisp->irq_queue);
 	INIT_DELAYED_WORK(&bdisp->timeout_work, bdisp_irq_timeout);
 	bdisp->work_queue = create_workqueue(BDISP_NAME);
+	if (!bdisp->work_queue)
+		return -ENOMEM;
 
 	spin_lock_init(&bdisp->slock);
 	mutex_init(&bdisp->lock);
diff --git a/drivers/media/rc/gpio-ir-recv.c b/drivers/media/rc/gpio-ir-recv.c
index a56c844d7f81..16795e07dc10 100644
--- a/drivers/media/rc/gpio-ir-recv.c
+++ b/drivers/media/rc/gpio-ir-recv.c
@@ -107,6 +107,8 @@ static int gpio_ir_recv_probe(struct platform_device *pdev)
 		rcdev->map_name = RC_MAP_EMPTY;
 
 	gpio_dev->rcdev = rcdev;
+	if (of_property_read_bool(np, "wakeup-source"))
+		device_init_wakeup(dev, true);
 
 	rc = devm_rc_register_device(dev, rcdev);
 	if (rc < 0) {
diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 7ae906ff8e35..fac02875fe7d 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -16,8 +16,8 @@
 #include <linux/platform_data/i2c-ocores.h>
 #include <linux/platform_device.h>
 
-#define TQMX86_IOBASE	0x160
-#define TQMX86_IOSIZE	0x3f
+#define TQMX86_IOBASE	0x180
+#define TQMX86_IOSIZE	0x20
 #define TQMX86_IOBASE_I2C	0x1a0
 #define TQMX86_IOSIZE_I2C	0xa
 #define TQMX86_IOBASE_WATCHDOG	0x18b
@@ -25,14 +25,14 @@
 #define TQMX86_IOBASE_GPIO	0x18d
 #define TQMX86_IOSIZE_GPIO	0x4
 
-#define TQMX86_REG_BOARD_ID	0x20
+#define TQMX86_REG_BOARD_ID	0x00
 #define TQMX86_REG_BOARD_ID_E38M	1
 #define TQMX86_REG_BOARD_ID_50UC	2
 #define TQMX86_REG_BOARD_ID_E38C	3
 #define TQMX86_REG_BOARD_ID_60EB	4
-#define TQMX86_REG_BOARD_ID_E39M	5
-#define TQMX86_REG_BOARD_ID_E39C	6
-#define TQMX86_REG_BOARD_ID_E39x	7
+#define TQMX86_REG_BOARD_ID_E39MS	5
+#define TQMX86_REG_BOARD_ID_E39C1	6
+#define TQMX86_REG_BOARD_ID_E39C2	7
 #define TQMX86_REG_BOARD_ID_70EB	8
 #define TQMX86_REG_BOARD_ID_80UC	9
 #define TQMX86_REG_BOARD_ID_110EB	11
@@ -40,18 +40,18 @@
 #define TQMX86_REG_BOARD_ID_E40S	13
 #define TQMX86_REG_BOARD_ID_E40C1	14
 #define TQMX86_REG_BOARD_ID_E40C2	15
-#define TQMX86_REG_BOARD_REV	0x21
-#define TQMX86_REG_IO_EXT_INT	0x26
+#define TQMX86_REG_BOARD_REV	0x01
+#define TQMX86_REG_IO_EXT_INT	0x06
 #define TQMX86_REG_IO_EXT_INT_NONE		0
 #define TQMX86_REG_IO_EXT_INT_7			1
 #define TQMX86_REG_IO_EXT_INT_9			2
 #define TQMX86_REG_IO_EXT_INT_12		3
 #define TQMX86_REG_IO_EXT_INT_MASK		0x3
 #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
+#define TQMX86_REG_SAUC		0x17
 
-#define TQMX86_REG_I2C_DETECT	0x47
+#define TQMX86_REG_I2C_DETECT	0x1a7
 #define TQMX86_REG_I2C_DETECT_SOFT		0xa5
-#define TQMX86_REG_I2C_INT_EN	0x49
 
 static uint gpio_irq;
 module_param(gpio_irq, uint, 0);
@@ -111,7 +111,7 @@ static const struct mfd_cell tqmx86_devs[] = {
 	},
 };
 
-static const char *tqmx86_board_id_to_name(u8 board_id)
+static const char *tqmx86_board_id_to_name(u8 board_id, u8 sauc)
 {
 	switch (board_id) {
 	case TQMX86_REG_BOARD_ID_E38M:
@@ -122,12 +122,12 @@ static const char *tqmx86_board_id_to_name(u8 board_id)
 		return "TQMxE38C";
 	case TQMX86_REG_BOARD_ID_60EB:
 		return "TQMx60EB";
-	case TQMX86_REG_BOARD_ID_E39M:
-		return "TQMxE39M";
-	case TQMX86_REG_BOARD_ID_E39C:
-		return "TQMxE39C";
-	case TQMX86_REG_BOARD_ID_E39x:
-		return "TQMxE39x";
+	case TQMX86_REG_BOARD_ID_E39MS:
+		return (sauc == 0xff) ? "TQMxE39M" : "TQMxE39S";
+	case TQMX86_REG_BOARD_ID_E39C1:
+		return "TQMxE39C1";
+	case TQMX86_REG_BOARD_ID_E39C2:
+		return "TQMxE39C2";
 	case TQMX86_REG_BOARD_ID_70EB:
 		return "TQMx70EB";
 	case TQMX86_REG_BOARD_ID_80UC:
@@ -160,9 +160,9 @@ static int tqmx86_board_id_to_clk_rate(struct device *dev, u8 board_id)
 	case TQMX86_REG_BOARD_ID_E40C1:
 	case TQMX86_REG_BOARD_ID_E40C2:
 		return 24000;
-	case TQMX86_REG_BOARD_ID_E39M:
-	case TQMX86_REG_BOARD_ID_E39C:
-	case TQMX86_REG_BOARD_ID_E39x:
+	case TQMX86_REG_BOARD_ID_E39MS:
+	case TQMX86_REG_BOARD_ID_E39C1:
+	case TQMX86_REG_BOARD_ID_E39C2:
 		return 25000;
 	case TQMX86_REG_BOARD_ID_E38M:
 	case TQMX86_REG_BOARD_ID_E38C:
@@ -176,7 +176,7 @@ static int tqmx86_board_id_to_clk_rate(struct device *dev, u8 board_id)
 
 static int tqmx86_probe(struct platform_device *pdev)
 {
-	u8 board_id, rev, i2c_det, io_ext_int_val;
+	u8 board_id, sauc, rev, i2c_det, io_ext_int_val;
 	struct device *dev = &pdev->dev;
 	u8 gpio_irq_cfg, readback;
 	const char *board_name;
@@ -206,14 +206,20 @@ static int tqmx86_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	board_id = ioread8(io_base + TQMX86_REG_BOARD_ID);
-	board_name = tqmx86_board_id_to_name(board_id);
+	sauc = ioread8(io_base + TQMX86_REG_SAUC);
+	board_name = tqmx86_board_id_to_name(board_id, sauc);
 	rev = ioread8(io_base + TQMX86_REG_BOARD_REV);
 
 	dev_info(dev,
 		 "Found %s - Board ID %d, PCB Revision %d, PLD Revision %d\n",
 		 board_name, board_id, rev >> 4, rev & 0xf);
 
-	i2c_det = ioread8(io_base + TQMX86_REG_I2C_DETECT);
+	/*
+	 * The I2C_DETECT register is in the range assigned to the I2C driver
+	 * later, so we don't extend TQMX86_IOSIZE. Use inb() for this one-off
+	 * access instead of ioport_map + unmap.
+	 */
+	i2c_det = inb(TQMX86_REG_I2C_DETECT);
 
 	if (gpio_irq_cfg) {
 		io_ext_int_val =
diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index 857b9851402a..abe79f6fd2a7 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -165,10 +165,16 @@ static int vmci_host_close(struct inode *inode, struct file *filp)
 static __poll_t vmci_host_poll(struct file *filp, poll_table *wait)
 {
 	struct vmci_host_dev *vmci_host_dev = filp->private_data;
-	struct vmci_ctx *context = vmci_host_dev->context;
+	struct vmci_ctx *context;
 	__poll_t mask = 0;
 
 	if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
+		/*
+		 * Read context only if ct_type == VMCIOBJ_CONTEXT to make
+		 * sure that context is initialized
+		 */
+		context = vmci_host_dev->context;
+
 		/* Check for VMCI calls to this VM context. */
 		if (wait)
 			poll_wait(filp, &context->host_context.wait_queue,
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 04a37fd137ee..ea9bb545b1a2 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -126,6 +126,7 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
 			return ret;
 		}
 	}
+
 	/*
 	 * The DAT[3:0] line signal levels and the CMD line signal level are
 	 * not compatible with standard SDHC register. The line signal levels
@@ -137,6 +138,16 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
 		ret = value & 0x000fffff;
 		ret |= (value >> 4) & SDHCI_DATA_LVL_MASK;
 		ret |= (value << 1) & SDHCI_CMD_LVL;
+
+		/*
+		 * Some controllers have unreliable Data Line Active
+		 * bit for commands with busy signal. This affects
+		 * Command Inhibit (data) bit. Just ignore it since
+		 * MMC core driver has already polled card status
+		 * with CMD13 after any command with busy siganl.
+		 */
+		if (esdhc->quirk_ignore_data_inhibit)
+			ret &= ~SDHCI_DATA_INHIBIT;
 		return ret;
 	}
 
@@ -151,19 +162,6 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
 		return ret;
 	}
 
-	/*
-	 * Some controllers have unreliable Data Line Active
-	 * bit for commands with busy signal. This affects
-	 * Command Inhibit (data) bit. Just ignore it since
-	 * MMC core driver has already polled card status
-	 * with CMD13 after any command with busy siganl.
-	 */
-	if ((spec_reg == SDHCI_PRESENT_STATE) &&
-	(esdhc->quirk_ignore_data_inhibit == true)) {
-		ret = value & ~SDHCI_DATA_INHIBIT;
-		return ret;
-	}
-
 	ret = value;
 	return ret;
 }
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 3abaac109e75..2a228ee32641 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -828,8 +828,8 @@ static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
 
 	/* OTP nvmem will be registered on the physical device */
 	config.dev = mtd->dev.parent;
-	config.name = kasprintf(GFP_KERNEL, "%s-%s", dev_name(&mtd->dev), compatible);
-	config.id = NVMEM_DEVID_NONE;
+	config.name = compatible;
+	config.id = NVMEM_DEVID_AUTO;
 	config.owner = THIS_MODULE;
 	config.type = NVMEM_TYPE_OTP;
 	config.root_only = true;
@@ -845,7 +845,6 @@ static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
 		nvmem = NULL;
 
 	of_node_put(np);
-	kfree(config.name);
 
 	return nvmem;
 }
@@ -880,6 +879,7 @@ static int mtd_nvmem_fact_otp_reg_read(void *priv, unsigned int offset,
 
 static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 {
+	struct device *dev = mtd->dev.parent;
 	struct nvmem_device *nvmem;
 	ssize_t size;
 	int err;
@@ -893,7 +893,7 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 			nvmem = mtd_otp_nvmem_register(mtd, "user-otp", size,
 						       mtd_nvmem_user_otp_reg_read);
 			if (IS_ERR(nvmem)) {
-				dev_err(&mtd->dev, "Failed to register OTP NVMEM device\n");
+				dev_err(dev, "Failed to register OTP NVMEM device\n");
 				return PTR_ERR(nvmem);
 			}
 			mtd->otp_user_nvmem = nvmem;
@@ -911,7 +911,7 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 			nvmem = mtd_otp_nvmem_register(mtd, "factory-otp", size,
 						       mtd_nvmem_fact_otp_reg_read);
 			if (IS_ERR(nvmem)) {
-				dev_err(&mtd->dev, "Failed to register OTP NVMEM device\n");
+				dev_err(dev, "Failed to register OTP NVMEM device\n");
 				err = PTR_ERR(nvmem);
 				goto err;
 			}
@@ -964,10 +964,14 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 
 	mtd_set_dev_defaults(mtd);
 
+	ret = mtd_otp_nvmem_add(mtd);
+	if (ret)
+		goto out;
+
 	if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER)) {
 		ret = add_mtd_device(mtd);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	/* Prefer parsed partitions over driver-provided fallback */
@@ -1002,9 +1006,12 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 		register_reboot_notifier(&mtd->reboot_notifier);
 	}
 
-	ret = mtd_otp_nvmem_add(mtd);
-
 out:
+	if (ret) {
+		nvmem_unregister(mtd->otp_user_nvmem);
+		nvmem_unregister(mtd->otp_factory_nvmem);
+	}
+
 	if (ret && device_is_registered(&mtd->dev))
 		del_mtd_device(mtd);
 
diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index ccc5979642b7..4d05b8d32083 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -946,7 +946,7 @@ static int try_write_vid_and_data(struct ubi_volume *vol, int lnum,
 				  int offset, int len)
 {
 	struct ubi_device *ubi = vol->ubi;
-	int pnum, opnum, err, vol_id = vol->vol_id;
+	int pnum, opnum, err, err2, vol_id = vol->vol_id;
 
 	pnum = ubi_wl_get_peb(ubi);
 	if (pnum < 0) {
@@ -981,10 +981,19 @@ static int try_write_vid_and_data(struct ubi_volume *vol, int lnum,
 out_put:
 	up_read(&ubi->fm_eba_sem);
 
-	if (err && pnum >= 0)
-		err = ubi_wl_put_peb(ubi, vol_id, lnum, pnum, 1);
-	else if (!err && opnum >= 0)
-		err = ubi_wl_put_peb(ubi, vol_id, lnum, opnum, 0);
+	if (err && pnum >= 0) {
+		err2 = ubi_wl_put_peb(ubi, vol_id, lnum, pnum, 1);
+		if (err2) {
+			ubi_warn(ubi, "failed to return physical eraseblock %d, error %d",
+				 pnum, err2);
+		}
+	} else if (!err && opnum >= 0) {
+		err2 = ubi_wl_put_peb(ubi, vol_id, lnum, opnum, 0);
+		if (err2) {
+			ubi_warn(ubi, "failed to return physical eraseblock %d, error %d",
+				 opnum, err2);
+		}
+	}
 
 	return err;
 }
diff --git a/drivers/net/ethernet/amd/nmclan_cs.c b/drivers/net/ethernet/amd/nmclan_cs.c
index 4019cab87505..8bd063e54ac3 100644
--- a/drivers/net/ethernet/amd/nmclan_cs.c
+++ b/drivers/net/ethernet/amd/nmclan_cs.c
@@ -650,7 +650,7 @@ static int nmclan_config(struct pcmcia_device *link)
     } else {
       pr_notice("mace id not found: %x %x should be 0x40 0x?9\n",
 		sig[0], sig[1]);
-      return -ENODEV;
+      goto failed;
     }
   }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index beda8e0ef7d4..c829cb65171c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2633,6 +2633,14 @@ static int ixgbe_get_rss_hash_opts(struct ixgbe_adapter *adapter,
 	return 0;
 }
 
+static int ixgbe_rss_indir_tbl_max(struct ixgbe_adapter *adapter)
+{
+	if (adapter->hw.mac.type < ixgbe_mac_X550)
+		return 16;
+	else
+		return 64;
+}
+
 static int ixgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 			   u32 *rule_locs)
 {
@@ -2641,7 +2649,8 @@ static int ixgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 
 	switch (cmd->cmd) {
 	case ETHTOOL_GRXRINGS:
-		cmd->data = adapter->num_rx_queues;
+		cmd->data = min_t(int, adapter->num_rx_queues,
+				  ixgbe_rss_indir_tbl_max(adapter));
 		ret = 0;
 		break;
 	case ETHTOOL_GRXCLSRLCNT:
@@ -3043,14 +3052,6 @@ static int ixgbe_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	return ret;
 }
 
-static int ixgbe_rss_indir_tbl_max(struct ixgbe_adapter *adapter)
-{
-	if (adapter->hw.mac.type < ixgbe_mac_X550)
-		return 16;
-	else
-		return 64;
-}
-
 static u32 ixgbe_get_rxfh_key_size(struct net_device *netdev)
 {
 	return IXGBE_RSS_KEY_SIZE;
@@ -3099,8 +3100,8 @@ static int ixgbe_set_rxfh(struct net_device *netdev, const u32 *indir,
 	int i;
 	u32 reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
 
-	if (hfunc)
-		return -EINVAL;
+	if (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP)
+		return -EOPNOTSUPP;
 
 	/* Fill out the redirection table */
 	if (indir) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 002567792e91..829f703233a9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -656,7 +656,6 @@ mlx5_eswitch_add_fwd_rule(struct mlx5_eswitch *esw,
 
 	return rule;
 err_chain_src_rewrite:
-	esw_put_dest_tables_loop(esw, attr, 0, i);
 	mlx5_esw_vporttbl_put(esw, &fwd_attr);
 err_get_fwd:
 	mlx5_chains_put_table(chains, attr->chain, attr->prio, 0);
@@ -698,7 +697,6 @@ __mlx5_eswitch_del_rule(struct mlx5_eswitch *esw,
 	if (fwd_rule)  {
 		mlx5_esw_vporttbl_put(esw, &fwd_attr);
 		mlx5_chains_put_table(chains, attr->chain, attr->prio, 0);
-		esw_put_dest_tables_loop(esw, attr, 0, esw_attr->split_count);
 	} else {
 		if (split)
 			mlx5_esw_vporttbl_put(esw, &fwd_attr);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index c469abc91fa1..8394a215725d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1347,9 +1347,6 @@ static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
 	int ret;
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (!ldo)
-		return 0;
-
 	if (enable) {
 		ret = regulator_enable(ldo);
 		if (ret)
@@ -1397,14 +1394,11 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 		}
 	}
 
-	bsp_priv->regulator = devm_regulator_get_optional(dev, "phy");
+	bsp_priv->regulator = devm_regulator_get(dev, "phy");
 	if (IS_ERR(bsp_priv->regulator)) {
-		if (PTR_ERR(bsp_priv->regulator) == -EPROBE_DEFER) {
-			dev_err(dev, "phy regulator is not available yet, deferred probing\n");
-			return ERR_PTR(-EPROBE_DEFER);
-		}
-		dev_err(dev, "no regulator found\n");
-		bsp_priv->regulator = NULL;
+		ret = PTR_ERR(bsp_priv->regulator);
+		dev_err_probe(dev, ret, "failed to get phy regulator\n");
+		return ERR_PTR(ret);
 	}
 
 	ret = of_property_read_string(dev->of_node, "clock_in_out", &strings);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a3bd5396c2f8..179f8d196c89 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6283,6 +6283,10 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 	bool is_double = false;
 	int ret;
 
+	ret = pm_runtime_resume_and_get(priv->device);
+	if (ret < 0)
+		return ret;
+
 	if (be16_to_cpu(proto) == ETH_P_8021AD)
 		is_double = true;
 
@@ -6290,16 +6294,18 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 	ret = stmmac_vlan_update(priv, is_double);
 	if (ret) {
 		clear_bit(vid, priv->active_vlans);
-		return ret;
+		goto err_pm_put;
 	}
 
 	if (priv->hw->num_vlan) {
 		ret = stmmac_add_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto, vid);
 		if (ret)
-			return ret;
+			goto err_pm_put;
 	}
+err_pm_put:
+	pm_runtime_put(priv->device);
 
-	return 0;
+	return ret;
 }
 
 static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vid)
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index fd4cbf8a55ad..556ca9884356 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -309,7 +309,7 @@ static int xpcs_read_fault_c73(struct dw_xpcs *xpcs,
 	return 0;
 }
 
-static int xpcs_read_link_c73(struct dw_xpcs *xpcs, bool an)
+static int xpcs_read_link_c73(struct dw_xpcs *xpcs)
 {
 	bool link = true;
 	int ret;
@@ -321,15 +321,6 @@ static int xpcs_read_link_c73(struct dw_xpcs *xpcs, bool an)
 	if (!(ret & MDIO_STAT1_LSTATUS))
 		link = false;
 
-	if (an) {
-		ret = xpcs_read(xpcs, MDIO_MMD_AN, MDIO_STAT1);
-		if (ret < 0)
-			return ret;
-
-		if (!(ret & MDIO_STAT1_LSTATUS))
-			link = false;
-	}
-
 	return link;
 }
 
@@ -847,7 +838,7 @@ static int xpcs_get_state_c73(struct dw_xpcs *xpcs,
 	int ret;
 
 	/* Link needs to be read first ... */
-	state->link = xpcs_read_link_c73(xpcs, state->an_enabled) > 0 ? 1 : 0;
+	state->link = xpcs_read_link_c73(xpcs) > 0 ? 1 : 0;
 
 	/* ... and then we check the faults. */
 	ret = xpcs_read_fault_c73(xpcs, state);
diff --git a/drivers/net/wireguard/timers.c b/drivers/net/wireguard/timers.c
index d54d32ac9bc4..91f5d6d2d4e2 100644
--- a/drivers/net/wireguard/timers.c
+++ b/drivers/net/wireguard/timers.c
@@ -46,7 +46,7 @@ static void wg_expired_retransmit_handshake(struct timer_list *timer)
 	if (peer->timer_handshake_attempts > MAX_TIMER_HANDSHAKES) {
 		pr_debug("%s: Handshake for peer %llu (%pISpfsc) did not complete after %d attempts, giving up\n",
 			 peer->device->dev->name, peer->internal_id,
-			 &peer->endpoint.addr, MAX_TIMER_HANDSHAKES + 2);
+			 &peer->endpoint.addr, (int)MAX_TIMER_HANDSHAKES + 2);
 
 		del_timer(&peer->timer_send_keepalive);
 		/* We drop all packets without a keypair and don't try again,
@@ -64,7 +64,7 @@ static void wg_expired_retransmit_handshake(struct timer_list *timer)
 		++peer->timer_handshake_attempts;
 		pr_debug("%s: Handshake for peer %llu (%pISpfsc) did not complete after %d seconds, retrying (try %d)\n",
 			 peer->device->dev->name, peer->internal_id,
-			 &peer->endpoint.addr, REKEY_TIMEOUT,
+			 &peer->endpoint.addr, (int)REKEY_TIMEOUT,
 			 peer->timer_handshake_attempts + 1);
 
 		/* We clear the endpoint address src address, in case this is
@@ -94,7 +94,7 @@ static void wg_expired_new_handshake(struct timer_list *timer)
 
 	pr_debug("%s: Retrying handshake with peer %llu (%pISpfsc) because we stopped hearing back after %d seconds\n",
 		 peer->device->dev->name, peer->internal_id,
-		 &peer->endpoint.addr, KEEPALIVE_TIMEOUT + REKEY_TIMEOUT);
+		 &peer->endpoint.addr, (int)(KEEPALIVE_TIMEOUT + REKEY_TIMEOUT));
 	/* We clear the endpoint address src address, in case this is the cause
 	 * of trouble.
 	 */
@@ -126,7 +126,7 @@ static void wg_queued_expired_zero_key_material(struct work_struct *work)
 
 	pr_debug("%s: Zeroing out all keys for peer %llu (%pISpfsc), since we haven't received a new one in %d seconds\n",
 		 peer->device->dev->name, peer->internal_id,
-		 &peer->endpoint.addr, REJECT_AFTER_TIME * 3);
+		 &peer->endpoint.addr, (int)REJECT_AFTER_TIME * 3);
 	wg_noise_handshake_clear(&peer->handshake);
 	wg_noise_keypairs_clear(&peer->keypairs);
 	wg_peer_put(peer);
diff --git a/drivers/net/wireless/ath/ath5k/eeprom.c b/drivers/net/wireless/ath/ath5k/eeprom.c
index d444b3d70ba2..58d3e86f6256 100644
--- a/drivers/net/wireless/ath/ath5k/eeprom.c
+++ b/drivers/net/wireless/ath/ath5k/eeprom.c
@@ -529,7 +529,7 @@ ath5k_eeprom_read_freq_list(struct ath5k_hw *ah, int *offset, int max,
 		ee->ee_n_piers[mode]++;
 
 		freq2 = (val >> 8) & 0xff;
-		if (!freq2)
+		if (!freq2 || i >= max)
 			break;
 
 		pc[i++].freq = ath5k_eeprom_bin2freq(ee,
diff --git a/drivers/net/wireless/ath/ath6kl/bmi.c b/drivers/net/wireless/ath/ath6kl/bmi.c
index bde5a10d470c..af98e871199d 100644
--- a/drivers/net/wireless/ath/ath6kl/bmi.c
+++ b/drivers/net/wireless/ath/ath6kl/bmi.c
@@ -246,7 +246,7 @@ int ath6kl_bmi_execute(struct ath6kl *ar, u32 addr, u32 *param)
 		return -EACCES;
 	}
 
-	size = sizeof(cid) + sizeof(addr) + sizeof(param);
+	size = sizeof(cid) + sizeof(addr) + sizeof(*param);
 	if (size > ar->bmi.max_cmd_size) {
 		WARN_ON(1);
 		return -EINVAL;
diff --git a/drivers/net/wireless/ath/ath6kl/htc_pipe.c b/drivers/net/wireless/ath/ath6kl/htc_pipe.c
index c68848819a52..9b88d96bfe96 100644
--- a/drivers/net/wireless/ath/ath6kl/htc_pipe.c
+++ b/drivers/net/wireless/ath/ath6kl/htc_pipe.c
@@ -960,8 +960,8 @@ static int ath6kl_htc_pipe_rx_complete(struct ath6kl *ar, struct sk_buff *skb,
 	 * Thus the possibility of ar->htc_target being NULL
 	 * via ath6kl_recv_complete -> ath6kl_usb_io_comp_work.
 	 */
-	if (WARN_ON_ONCE(!target)) {
-		ath6kl_err("Target not yet initialized\n");
+	if (!target) {
+		ath6kl_dbg(ATH6KL_DBG_HTC, "Target not yet initialized\n");
 		status = -EINVAL;
 		goto free_skb;
 	}
diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index f521dfa2f194..e0130beb304d 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -534,6 +534,24 @@ static struct ath9k_htc_hif hif_usb = {
 	.send = hif_usb_send,
 };
 
+/* Need to free remain_skb allocated in ath9k_hif_usb_rx_stream
+ * in case ath9k_hif_usb_rx_stream wasn't called next time to
+ * process the buffer and subsequently free it.
+ */
+static void ath9k_hif_usb_free_rx_remain_skb(struct hif_device_usb *hif_dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hif_dev->rx_lock, flags);
+	if (hif_dev->remain_skb) {
+		dev_kfree_skb_any(hif_dev->remain_skb);
+		hif_dev->remain_skb = NULL;
+		hif_dev->rx_remain_len = 0;
+		RX_STAT_INC(hif_dev, skb_dropped);
+	}
+	spin_unlock_irqrestore(&hif_dev->rx_lock, flags);
+}
+
 static void ath9k_hif_usb_rx_stream(struct hif_device_usb *hif_dev,
 				    struct sk_buff *skb)
 {
@@ -868,6 +886,7 @@ static int ath9k_hif_usb_alloc_tx_urbs(struct hif_device_usb *hif_dev)
 static void ath9k_hif_usb_dealloc_rx_urbs(struct hif_device_usb *hif_dev)
 {
 	usb_kill_anchored_urbs(&hif_dev->rx_submitted);
+	ath9k_hif_usb_free_rx_remain_skb(hif_dev);
 }
 
 static int ath9k_hif_usb_alloc_rx_urbs(struct hif_device_usb *hif_dev)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index cba909c5bc6b..5a1b01db02e6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6212,18 +6212,20 @@ static s32 brcmf_notify_rssi(struct brcmf_if *ifp,
 {
 	struct brcmf_cfg80211_vif *vif = ifp->vif;
 	struct brcmf_rssi_be *info = data;
-	s32 rssi, snr, noise;
+	s32 rssi, snr = 0, noise = 0;
 	s32 low, high, last;
 
-	if (e->datalen < sizeof(*info)) {
+	if (e->datalen >= sizeof(*info)) {
+		rssi = be32_to_cpu(info->rssi);
+		snr = be32_to_cpu(info->snr);
+		noise = be32_to_cpu(info->noise);
+	} else if (e->datalen >= sizeof(rssi)) {
+		rssi = be32_to_cpu(*(__be32 *)data);
+	} else {
 		brcmf_err("insufficient RSSI event data\n");
 		return 0;
 	}
 
-	rssi = be32_to_cpu(info->rssi);
-	snr = be32_to_cpu(info->snr);
-	noise = be32_to_cpu(info->noise);
-
 	low = vif->cqm_rssi_low;
 	high = vif->cqm_rssi_high;
 	last = vif->cqm_rssi_last;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index b00cf92c8965..c69f3fb83332 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1022,7 +1022,7 @@ iwl_dump_ini_prph_mac_iter(struct iwl_fw_runtime *fwrt,
 	range->range_data_size = reg->dev_addr.size;
 	for (i = 0; i < le32_to_cpu(reg->dev_addr.size); i += 4) {
 		prph_val = iwl_read_prph(fwrt->trans, addr + i);
-		if (prph_val == 0x5a5a5a5a)
+		if ((prph_val & ~0xf) == 0xa5a5a5a0)
 			return -EBUSY;
 		*val++ = cpu_to_le32(prph_val);
 	}
@@ -1362,13 +1362,13 @@ static void iwl_ini_get_rxf_data(struct iwl_fw_runtime *fwrt,
 	if (!data)
 		return;
 
+	memset(data, 0, sizeof(*data));
+
 	/* make sure only one bit is set in only one fid */
 	if (WARN_ONCE(hweight_long(fid1) + hweight_long(fid2) != 1,
 		      "fid1=%x, fid2=%x\n", fid1, fid2))
 		return;
 
-	memset(data, 0, sizeof(*data));
-
 	if (fid1) {
 		fifo_idx = ffs(fid1) - 1;
 		if (WARN_ONCE(fifo_idx >= MAX_NUM_LMAC, "fifo_idx=%d\n",
@@ -1536,7 +1536,7 @@ iwl_dump_ini_dbgi_sram_iter(struct iwl_fw_runtime *fwrt,
 		prph_data = iwl_read_prph(fwrt->trans, (i % 2) ?
 					  DBGI_SRAM_TARGET_ACCESS_RDATA_MSB :
 					  DBGI_SRAM_TARGET_ACCESS_RDATA_LSB);
-		if (prph_data == 0x5a5a5a5a) {
+		if ((prph_data & ~0xf) == 0xa5a5a5a0) {
 			iwl_trans_release_nic_access(fwrt->trans);
 			return -EBUSY;
 		}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index a152ce306475..e372f935f698 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -317,8 +317,10 @@ static void *iwl_dbgfs_fw_info_seq_next(struct seq_file *seq,
 	const struct iwl_fw *fw = priv->fwrt->fw;
 
 	*pos = ++state->pos;
-	if (*pos >= fw->ucode_capa.n_cmd_versions)
+	if (*pos >= fw->ucode_capa.n_cmd_versions) {
+		kfree(state);
 		return NULL;
+	}
 
 	return state;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index fc4197bf2478..f9bd081dd9e0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -134,6 +134,12 @@ static int iwl_dbg_tlv_alloc_buf_alloc(struct iwl_trans *trans,
 	    alloc_id != IWL_FW_INI_ALLOCATION_ID_DBGC1)
 		goto err;
 
+	if (buf_location == IWL_FW_INI_LOCATION_DRAM_PATH &&
+	    alloc->req_size == 0) {
+		IWL_ERR(trans, "WRT: Invalid DRAM buffer allocation requested size (0)\n");
+		return -EINVAL;
+	}
+
 	trans->dbg.fw_mon_cfg[alloc_id] = *alloc;
 
 	return 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 00ca17f3b263..6dde3bd8f441 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -564,6 +564,7 @@ static void iwl_mvm_wowlan_get_tkip_data(struct ieee80211_hw *hw,
 		}
 
 		for (i = 0; i < IWL_NUM_RSC; i++) {
+			ieee80211_get_key_rx_seq(key, i, &seq);
 			/* wrapping isn't allowed, AP must rekey */
 			if (seq.tkip.iv32 > cur_rx_iv32)
 				cur_rx_iv32 = seq.tkip.iv32;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index d398a06b2656..0f5c4c2510ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1931,6 +1931,11 @@ static ssize_t iwl_dbgfs_mem_read(struct file *file, char __user *user_buf,
 	if (ret < 0)
 		return ret;
 
+	if (iwl_rx_packet_payload_len(hcmd.resp_pkt) < sizeof(*rsp)) {
+		ret = -EIO;
+		goto out;
+	}
+
 	rsp = (void *)hcmd.resp_pkt->data;
 	if (le32_to_cpu(rsp->status) != DEBUG_MEM_STATUS_SUCCESS) {
 		ret = -ENXIO;
@@ -2008,6 +2013,11 @@ static ssize_t iwl_dbgfs_mem_write(struct file *file,
 	if (ret < 0)
 		return ret;
 
+	if (iwl_rx_packet_payload_len(hcmd.resp_pkt) < sizeof(*rsp)) {
+		ret = -EIO;
+		goto out;
+	}
+
 	rsp = (void *)hcmd.resp_pkt->data;
 	if (rsp->status != DEBUG_MEM_STATUS_SUCCESS) {
 		ret = -ENXIO;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 02da9cc8646c..ee325950de9d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -581,7 +581,6 @@ static int iwl_pcie_set_hw_ready(struct iwl_trans *trans)
 int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
 {
 	int ret;
-	int t = 0;
 	int iter;
 
 	IWL_DEBUG_INFO(trans, "iwl_trans_prepare_card_hw enter\n");
@@ -596,6 +595,8 @@ int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
 	usleep_range(1000, 2000);
 
 	for (iter = 0; iter < 10; iter++) {
+		int t = 0;
+
 		/* If HW is not ready, prepare the conditions to check again */
 		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
 			    CSR_HW_IF_CONFIG_REG_PREPARE);
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 1aa0479c5fa4..69e0e68757f5 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -434,7 +434,9 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 free_skb:
 	status.skb = tx_info.skb;
 	hw = mt76_tx_status_get_hw(dev, tx_info.skb);
+	spin_lock_bh(&dev->rx_lock);
 	ieee80211_tx_status_ext(hw, &status);
+	spin_unlock_bh(&dev->rx_lock);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4e4af6e17b50..eb1fb955b777 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -820,10 +820,11 @@ bool __mt76_poll(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 
 #define mt76_poll(dev, ...) __mt76_poll(&((dev)->mt76), __VA_ARGS__)
 
-bool __mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
-		      int timeout);
-
-#define mt76_poll_msec(dev, ...) __mt76_poll_msec(&((dev)->mt76), __VA_ARGS__)
+bool ____mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
+			int timeout, int kick);
+#define __mt76_poll_msec(...)         ____mt76_poll_msec(__VA_ARGS__, 10)
+#define mt76_poll_msec(dev, ...)      ____mt76_poll_msec(&((dev)->mt76), __VA_ARGS__, 10)
+#define mt76_poll_msec_tick(dev, ...) ____mt76_poll_msec(&((dev)->mt76), __VA_ARGS__)
 
 void mt76_mmio_init(struct mt76_dev *dev, void __iomem *regs);
 void mt76_pci_disable_aspm(struct pci_dev *pdev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 65f1f2bb8083..3745512b1eb3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1284,8 +1284,11 @@ void mt7603_mac_add_txs(struct mt7603_dev *dev, void *data)
 	if (wcidx >= MT7603_WTBL_STA || !sta)
 		goto out;
 
-	if (mt7603_fill_txs(dev, msta, &info, txs_data))
+	if (mt7603_fill_txs(dev, msta, &info, txs_data)) {
+		spin_lock_bh(&dev->mt76.rx_lock);
 		ieee80211_tx_status_noskb(mt76_hw(dev), sta, &info);
+		spin_unlock_bh(&dev->mt76.rx_lock);
+	}
 
 out:
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 9ba7963a89f6..37bc307c1971 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1496,8 +1496,11 @@ static void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 	if (wcid->ext_phy && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
 
-	if (mt7615_fill_txs(dev, msta, &info, txs_data))
+	if (mt7615_fill_txs(dev, msta, &info, txs_data)) {
+		spin_lock_bh(&dev->mt76.rx_lock);
 		ieee80211_tx_status_noskb(mphy->hw, sta, &info);
+		spin_unlock_bh(&dev->mt76.rx_lock);
+	}
 
 out:
 	rcu_read_unlock();
@@ -2270,7 +2273,7 @@ void mt7615_coredump_work(struct work_struct *work)
 			break;
 
 		skb_pull(skb, sizeof(struct mt7615_mcu_rxd));
-		if (data + skb->len - dump > MT76_CONNAC_COREDUMP_SZ) {
+		if (!dump || data + skb->len - dump > MT76_CONNAC_COREDUMP_SZ) {
 			dev_kfree_skb(skb);
 			continue;
 		}
@@ -2280,6 +2283,8 @@ void mt7615_coredump_work(struct work_struct *work)
 
 		dev_kfree_skb(skb);
 	}
-	dev_coredumpv(dev->mt76.dev, dump, MT76_CONNAC_COREDUMP_SZ,
-		      GFP_KERNEL);
+
+	if (dump)
+		dev_coredumpv(dev->mt76.dev, dump, MT76_CONNAC_COREDUMP_SZ,
+			      GFP_KERNEL);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 017bd59c4ea8..98f651fec3bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1446,8 +1446,16 @@ int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	req->channel_min_dwell_time = cpu_to_le16(duration);
 	req->channel_dwell_time = cpu_to_le16(duration);
 
-	req->channels_num = min_t(u8, sreq->n_channels, 32);
-	req->ext_channels_num = min_t(u8, ext_channels_num, 32);
+	if (sreq->n_channels == 0 || sreq->n_channels > 64) {
+		req->channel_type = 0;
+		req->channels_num = 0;
+		req->ext_channels_num = 0;
+	} else {
+		req->channel_type = 4;
+		req->channels_num = min_t(u8, sreq->n_channels, 32);
+		req->ext_channels_num = min_t(u8, ext_channels_num, 32);
+	}
+
 	for (i = 0; i < req->channels_num + req->ext_channels_num; i++) {
 		if (i >= 32)
 			chan = &req->ext_channels[i - 32];
@@ -1457,7 +1465,6 @@ int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		chan->band = scan_list[i]->band == NL80211_BAND_2GHZ ? 1 : 2;
 		chan->channel_num = scan_list[i]->hw_value;
 	}
-	req->channel_type = sreq->n_channels ? 4 : 0;
 
 	if (sreq->ie_len > 0) {
 		memcpy(req->ies, sreq->ie, sreq->ie_len);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 07b21b208582..eacc5d39d583 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -631,8 +631,11 @@ void mt76x02_send_tx_status(struct mt76x02_dev *dev,
 
 	mt76_tx_status_unlock(mdev, &list);
 
-	if (!status.skb)
+	if (!status.skb) {
+		spin_lock_bh(&dev->mt76.rx_lock);
 		ieee80211_tx_status_ext(mt76_hw(dev), &status);
+		spin_unlock_bh(&dev->mt76.rx_lock);
+	}
 
 	if (!len)
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 93d0cc1827d2..983861edc683 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -120,6 +120,24 @@ static void mt7921_dma_prefetch(struct mt7921_dev *dev)
 
 static int mt7921_dma_disable(struct mt7921_dev *dev, bool force)
 {
+	/* disable WFDMA0 */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
+		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
+		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
+
+	if (!mt76_poll_msec_tick(dev, MT_WFDMA0_GLO_CFG,
+				 MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
+				 MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 100, 1))
+		return -ETIMEDOUT;
+
+	/* disable dmashdl */
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG_EXT0,
+		   MT_WFDMA0_CSR_TX_DMASHDL_ENABLE);
+	mt76_set(dev, MT_DMASHDL_SW_CONTROL, MT_DMASHDL_DMASHDL_BYPASS);
+
 	if (force) {
 		/* reset */
 		mt76_clear(dev, MT_WFDMA0_RST,
@@ -131,24 +149,6 @@ static int mt7921_dma_disable(struct mt7921_dev *dev, bool force)
 			 MT_WFDMA0_RST_LOGIC_RST);
 	}
 
-	/* disable dmashdl */
-	mt76_clear(dev, MT_WFDMA0_GLO_CFG_EXT0,
-		   MT_WFDMA0_CSR_TX_DMASHDL_ENABLE);
-	mt76_set(dev, MT_DMASHDL_SW_CONTROL, MT_DMASHDL_DMASHDL_BYPASS);
-
-	/* disable WFDMA0 */
-	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
-		   MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN |
-		   MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN |
-		   MT_WFDMA0_GLO_CFG_OMIT_TX_INFO |
-		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
-		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
-
-	if (!mt76_poll(dev, MT_WFDMA0_GLO_CFG,
-		       MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
-		       MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 1000))
-		return -ETIMEDOUT;
-
 	return 0;
 }
 
@@ -354,6 +354,10 @@ void mt7921_dma_cleanup(struct mt7921_dev *dev)
 		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
 		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
 
+	mt76_poll_msec_tick(dev, MT_WFDMA0_GLO_CFG,
+			    MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
+			    MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 100, 1);
+
 	/* reset */
 	mt76_clear(dev, MT_WFDMA0_RST,
 		   MT_WFDMA0_RST_DMASHDL_ALL_RST |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 36e6495ae658..7effee4978e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -218,6 +218,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	struct mt7921_dev *dev;
 	struct mt76_dev *mdev;
 	int ret;
+	u16 cmd;
 
 	ret = pcim_enable_device(pdev);
 	if (ret)
@@ -227,6 +228,11 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if (!(cmd & PCI_COMMAND_MEMORY)) {
+		cmd |= PCI_COMMAND_MEMORY;
+		pci_write_config_word(pdev, PCI_COMMAND, cmd);
+	}
 	pci_set_master(pdev);
 
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index dce6f6b5f071..7d126634547f 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -68,7 +68,9 @@ mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
 			status.sta = wcid_to_sta(wcid);
 
 		hw = mt76_tx_status_get_hw(dev, skb);
+		spin_lock_bh(&dev->rx_lock);
 		ieee80211_tx_status_ext(hw, &status);
+		spin_unlock_bh(&dev->rx_lock);
 	}
 	rcu_read_unlock();
 }
@@ -229,7 +231,9 @@ void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *
 	if (!skb->prev) {
 		hw = mt76_tx_status_get_hw(dev, skb);
 		status.sta = wcid_to_sta(wcid);
+		spin_lock_bh(&dev->rx_lock);
 		ieee80211_tx_status_ext(hw, &status);
+		spin_unlock_bh(&dev->rx_lock);
 		goto out;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wireless/mediatek/mt76/util.c
index 581964425468..fc76c66ff1a5 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -24,23 +24,23 @@ bool __mt76_poll(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 }
 EXPORT_SYMBOL_GPL(__mt76_poll);
 
-bool __mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
-		      int timeout)
+bool ____mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
+			int timeout, int tick)
 {
 	u32 cur;
 
-	timeout /= 10;
+	timeout /= tick;
 	do {
 		cur = __mt76_rr(dev, offset) & mask;
 		if (cur == val)
 			return true;
 
-		usleep_range(10000, 20000);
+		usleep_range(1000 * tick, 2000 * tick);
 	} while (timeout-- > 0);
 
 	return false;
 }
-EXPORT_SYMBOL_GPL(__mt76_poll_msec);
+EXPORT_SYMBOL_GPL(____mt76_poll_msec);
 
 int mt76_wcid_alloc(u32 *mask, int size)
 {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index e95c101c2711..388675d073ce 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -1091,6 +1091,7 @@ static void rt2x00lib_remove_hw(struct rt2x00_dev *rt2x00dev)
 	}
 
 	kfree(rt2x00dev->spec.channels_info);
+	kfree(rt2x00dev->chan_survey);
 }
 
 static int rt2x00lib_probe_hw(struct rt2x00_dev *rt2x00dev)
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index 46767dc6d649..761aeec07cdd 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -1700,6 +1700,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc24),
 	.has_s0s1 = 0,
 	.gen2_thermal_meter = 1,
+	.needs_full_init = 1,
 	.adda_1t_init = 0x0fc01616,
 	.adda_1t_path_on = 0x0fc01616,
 	.adda_2t_path_on_a = 0x0fc01616,
diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.c b/drivers/net/wireless/realtek/rtlwifi/debug.c
index 0b1bc04cb6ad..9eb26dfe4ca9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.c
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.c
@@ -278,8 +278,8 @@ static ssize_t rtl_debugfs_set_write_reg(struct file *filp,
 
 	tmp_len = (count > sizeof(tmp) - 1 ? sizeof(tmp) - 1 : count);
 
-	if (!buffer || copy_from_user(tmp, buffer, tmp_len))
-		return count;
+	if (copy_from_user(tmp, buffer, tmp_len))
+		return -EFAULT;
 
 	tmp[tmp_len] = '\0';
 
@@ -287,7 +287,7 @@ static ssize_t rtl_debugfs_set_write_reg(struct file *filp,
 	num = sscanf(tmp, "%x %x %x", &addr, &val, &len);
 
 	if (num !=  3)
-		return count;
+		return -EINVAL;
 
 	switch (len) {
 	case 1:
@@ -375,8 +375,8 @@ static ssize_t rtl_debugfs_set_write_rfreg(struct file *filp,
 
 	tmp_len = (count > sizeof(tmp) - 1 ? sizeof(tmp) - 1 : count);
 
-	if (!buffer || copy_from_user(tmp, buffer, tmp_len))
-		return count;
+	if (copy_from_user(tmp, buffer, tmp_len))
+		return -EFAULT;
 
 	tmp[tmp_len] = '\0';
 
@@ -386,7 +386,7 @@ static ssize_t rtl_debugfs_set_write_rfreg(struct file *filp,
 	if (num != 4) {
 		rtl_dbg(rtlpriv, COMP_ERR, DBG_DMESG,
 			"Format is <path> <addr> <mask> <data>\n");
-		return count;
+		return -EINVAL;
 	}
 
 	rtl_set_rfreg(hw, path, addr, bitmask, data);
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index d1678aed9d9c..a0576cc0c845 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -233,7 +233,7 @@ static int rtw_pwr_seq_parser(struct rtw_dev *rtwdev,
 
 		ret = rtw_sub_pwr_seq_parser(rtwdev, intf_mask, cut_mask, cmd);
 		if (ret)
-			return -EBUSY;
+			return ret;
 
 		idx++;
 	} while (1);
@@ -247,6 +247,7 @@ static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 	const struct rtw_pwr_seq_cmd **pwr_seq;
 	u8 rpwm;
 	bool cur_pwr;
+	int ret;
 
 	if (rtw_chip_wcpu_11ac(rtwdev)) {
 		rpwm = rtw_read8(rtwdev, rtwdev->hci.rpwm_addr);
@@ -270,8 +271,9 @@ static int rtw_mac_power_switch(struct rtw_dev *rtwdev, bool pwr_on)
 		return -EALREADY;
 
 	pwr_seq = pwr_on ? chip->pwr_on_seq : chip->pwr_off_seq;
-	if (rtw_pwr_seq_parser(rtwdev, pwr_seq))
-		return -EINVAL;
+	ret = rtw_pwr_seq_parser(rtwdev, pwr_seq);
+	if (ret)
+		return ret;
 
 	return 0;
 }
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ef9d7a795b00..e5318b38c662 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4360,11 +4360,19 @@ static void nvme_fw_act_work(struct work_struct *work)
 	nvme_get_fw_slot_info(ctrl);
 }
 
-static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
+static u32 nvme_aer_type(u32 result)
 {
-	u32 aer_notice_type = (result & 0xff00) >> 8;
+	return result & 0x7;
+}
 
-	trace_nvme_async_event(ctrl, aer_notice_type);
+static u32 nvme_aer_subtype(u32 result)
+{
+	return (result & 0xff00) >> 8;
+}
+
+static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
+{
+	u32 aer_notice_type = nvme_aer_subtype(result);
 
 	switch (aer_notice_type) {
 	case NVME_AER_NOTICE_NS_CHANGED:
@@ -4395,24 +4403,40 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	}
 }
 
+static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
+{
+	dev_warn(ctrl->device, "resetting controller due to AER\n");
+	nvme_reset_ctrl(ctrl);
+}
+
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		volatile union nvme_result *res)
 {
 	u32 result = le32_to_cpu(res->u32);
-	u32 aer_type = result & 0x07;
+	u32 aer_type = nvme_aer_type(result);
+	u32 aer_subtype = nvme_aer_subtype(result);
 
 	if (le16_to_cpu(status) >> 1 != NVME_SC_SUCCESS)
 		return;
 
+	trace_nvme_async_event(ctrl, result);
 	switch (aer_type) {
 	case NVME_AER_NOTICE:
 		nvme_handle_aen_notice(ctrl, result);
 		break;
 	case NVME_AER_ERROR:
+		/*
+		 * For a persistent internal error, don't run async_event_work
+		 * to submit a new AER. The controller reset will do it.
+		 */
+		if (aer_subtype == NVME_AER_ERROR_PERSIST_INT_ERR) {
+			nvme_handle_aer_persistent_error(ctrl);
+			return;
+		}
+		fallthrough;
 	case NVME_AER_SMART:
 	case NVME_AER_CSS:
 	case NVME_AER_VS:
-		trace_nvme_async_event(ctrl, aer_type);
 		ctrl->aen_result = result;
 		break;
 	default:
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index aa8b0f86b2be..b258f7b8788e 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -127,15 +127,12 @@ TRACE_EVENT(nvme_async_event,
 	),
 	TP_printk("nvme%d: NVME_AEN=%#08x [%s]",
 		__entry->ctrl_id, __entry->result,
-		__print_symbolic(__entry->result,
-		aer_name(NVME_AER_NOTICE_NS_CHANGED),
-		aer_name(NVME_AER_NOTICE_ANA),
-		aer_name(NVME_AER_NOTICE_FW_ACT_STARTING),
-		aer_name(NVME_AER_NOTICE_DISC_CHANGED),
-		aer_name(NVME_AER_ERROR),
-		aer_name(NVME_AER_SMART),
-		aer_name(NVME_AER_CSS),
-		aer_name(NVME_AER_VS))
+		__print_symbolic(__entry->result & 0x7,
+			aer_name(NVME_AER_ERROR),
+			aer_name(NVME_AER_SMART),
+			aer_name(NVME_AER_NOTICE),
+			aer_name(NVME_AER_CSS),
+			aer_name(NVME_AER_VS))
 	)
 );
 
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index bf78c58ed41d..ec13f568785e 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -508,7 +508,11 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		goto done;
 	}
 
-	nvmet_ns_revalidate(req->ns);
+	if (nvmet_ns_revalidate(req->ns)) {
+		mutex_lock(&req->ns->subsys->lock);
+		nvmet_ns_changed(req->ns->subsys, req->ns->nsid);
+		mutex_unlock(&req->ns->subsys->lock);
+	}
 
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
@@ -676,6 +680,13 @@ static bool nvmet_handle_identify_desclist(struct nvmet_req *req)
 	}
 }
 
+static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
+{
+	/* Not supported: return zeroes */
+	nvmet_req_complete(req,
+		   nvmet_zero_sgl(req, 0, sizeof(struct nvme_id_ctrl_nvm)));
+}
+
 static void nvmet_execute_identify(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
@@ -683,13 +694,8 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 
 	switch (req->cmd->identify.cns) {
 	case NVME_ID_CNS_NS:
-		switch (req->cmd->identify.csi) {
-		case NVME_CSI_NVM:
-			return nvmet_execute_identify_ns(req);
-		default:
-			break;
-		}
-		break;
+		nvmet_execute_identify_ns(req);
+		return;
 	case NVME_ID_CNS_CS_NS:
 		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
 			switch (req->cmd->identify.csi) {
@@ -701,29 +707,24 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		}
 		break;
 	case NVME_ID_CNS_CTRL:
-		switch (req->cmd->identify.csi) {
-		case NVME_CSI_NVM:
-			return nvmet_execute_identify_ctrl(req);
-		}
-		break;
+		nvmet_execute_identify_ctrl(req);
+		return;
 	case NVME_ID_CNS_CS_CTRL:
-		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
-			switch (req->cmd->identify.csi) {
-			case NVME_CSI_ZNS:
-				return nvmet_execute_identify_cns_cs_ctrl(req);
-			default:
-				break;
-			}
-		}
-		break;
-	case NVME_ID_CNS_NS_ACTIVE_LIST:
 		switch (req->cmd->identify.csi) {
 		case NVME_CSI_NVM:
-			return nvmet_execute_identify_nslist(req);
-		default:
+			nvmet_execute_identify_ctrl_nvm(req);
+			return;
+		case NVME_CSI_ZNS:
+			if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+				nvmet_execute_identify_ctrl_zns(req);
+				return;
+			}
 			break;
 		}
 		break;
+	case NVME_ID_CNS_NS_ACTIVE_LIST:
+		nvmet_execute_identify_nslist(req);
+		return;
 	case NVME_ID_CNS_NS_DESC_LIST:
 		if (nvmet_handle_identify_desclist(req) == true)
 			return;
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 625038057a76..5bdc3ba51f7e 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -586,7 +586,8 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
 		mutex_unlock(&ns->subsys->lock);
 		return -EINVAL;
 	}
-	nvmet_ns_revalidate(ns);
+	if (nvmet_ns_revalidate(ns))
+		nvmet_ns_changed(ns->subsys, ns->nsid);
 	mutex_unlock(&ns->subsys->lock);
 	return count;
 }
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4c6d56dd29ad..2c44d5a95c8d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -535,7 +535,7 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
 		ns->nsid);
 }
 
-void nvmet_ns_revalidate(struct nvmet_ns *ns)
+bool nvmet_ns_revalidate(struct nvmet_ns *ns)
 {
 	loff_t oldsize = ns->size;
 
@@ -544,8 +544,7 @@ void nvmet_ns_revalidate(struct nvmet_ns *ns)
 	else
 		nvmet_file_ns_revalidate(ns);
 
-	if (oldsize != ns->size)
-		nvmet_ns_changed(ns->subsys, ns->nsid);
+	return oldsize != ns->size;
 }
 
 int nvmet_ns_enable(struct nvmet_ns *ns)
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 5c16372f3b53..c780af36c1d4 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -614,10 +614,11 @@ fcloop_fcp_recv_work(struct work_struct *work)
 	struct fcloop_fcpreq *tfcp_req =
 		container_of(work, struct fcloop_fcpreq, fcp_rcv_work);
 	struct nvmefc_fcp_req *fcpreq = tfcp_req->fcpreq;
+	unsigned long flags;
 	int ret = 0;
 	bool aborted = false;
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	switch (tfcp_req->inistate) {
 	case INI_IO_START:
 		tfcp_req->inistate = INI_IO_ACTIVE;
@@ -626,11 +627,11 @@ fcloop_fcp_recv_work(struct work_struct *work)
 		aborted = true;
 		break;
 	default:
-		spin_unlock_irq(&tfcp_req->reqlock);
+		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 		WARN_ON(1);
 		return;
 	}
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	if (unlikely(aborted))
 		ret = -ECANCELED;
@@ -655,8 +656,9 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		container_of(work, struct fcloop_fcpreq, abort_rcv_work);
 	struct nvmefc_fcp_req *fcpreq;
 	bool completed = false;
+	unsigned long flags;
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	fcpreq = tfcp_req->fcpreq;
 	switch (tfcp_req->inistate) {
 	case INI_IO_ABORTED:
@@ -665,11 +667,11 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		completed = true;
 		break;
 	default:
-		spin_unlock_irq(&tfcp_req->reqlock);
+		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 		WARN_ON(1);
 		return;
 	}
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	if (unlikely(completed)) {
 		/* remove reference taken in original abort downcall */
@@ -681,9 +683,9 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		nvmet_fc_rcv_fcp_abort(tfcp_req->tport->targetport,
 					&tfcp_req->tgt_fcp_req);
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	tfcp_req->fcpreq = NULL;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
 	/* call_host_done releases reference for abort downcall */
@@ -699,11 +701,12 @@ fcloop_tgt_fcprqst_done_work(struct work_struct *work)
 	struct fcloop_fcpreq *tfcp_req =
 		container_of(work, struct fcloop_fcpreq, tio_done_work);
 	struct nvmefc_fcp_req *fcpreq;
+	unsigned long flags;
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	fcpreq = tfcp_req->fcpreq;
 	tfcp_req->inistate = INI_IO_COMPLETED;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	fcloop_call_host_done(fcpreq, tfcp_req, tfcp_req->status);
 }
@@ -807,13 +810,14 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
 	u32 rsplen = 0, xfrlen = 0;
 	int fcp_err = 0, active, aborted;
 	u8 op = tgt_fcpreq->op;
+	unsigned long flags;
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	fcpreq = tfcp_req->fcpreq;
 	active = tfcp_req->active;
 	aborted = tfcp_req->aborted;
 	tfcp_req->active = true;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	if (unlikely(active))
 		/* illegal - call while i/o active */
@@ -821,9 +825,9 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
 
 	if (unlikely(aborted)) {
 		/* target transport has aborted i/o prior */
-		spin_lock_irq(&tfcp_req->reqlock);
+		spin_lock_irqsave(&tfcp_req->reqlock, flags);
 		tfcp_req->active = false;
-		spin_unlock_irq(&tfcp_req->reqlock);
+		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 		tgt_fcpreq->transferred_length = 0;
 		tgt_fcpreq->fcp_error = -ECANCELED;
 		tgt_fcpreq->done(tgt_fcpreq);
@@ -880,9 +884,9 @@ fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
 		break;
 	}
 
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	tfcp_req->active = false;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	tgt_fcpreq->transferred_length = xfrlen;
 	tgt_fcpreq->fcp_error = fcp_err;
@@ -896,15 +900,16 @@ fcloop_tgt_fcp_abort(struct nvmet_fc_target_port *tgtport,
 			struct nvmefc_tgt_fcp_req *tgt_fcpreq)
 {
 	struct fcloop_fcpreq *tfcp_req = tgt_fcp_req_to_fcpreq(tgt_fcpreq);
+	unsigned long flags;
 
 	/*
 	 * mark aborted only in case there were 2 threads in transport
 	 * (one doing io, other doing abort) and only kills ops posted
 	 * after the abort request
 	 */
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	tfcp_req->aborted = true;
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	tfcp_req->status = NVME_SC_INTERNAL;
 
@@ -946,6 +951,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 	struct fcloop_ini_fcpreq *inireq = fcpreq->private;
 	struct fcloop_fcpreq *tfcp_req;
 	bool abortio = true;
+	unsigned long flags;
 
 	spin_lock(&inireq->inilock);
 	tfcp_req = inireq->tfcp_req;
@@ -958,7 +964,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 		return;
 
 	/* break initiator/target relationship for io */
-	spin_lock_irq(&tfcp_req->reqlock);
+	spin_lock_irqsave(&tfcp_req->reqlock, flags);
 	switch (tfcp_req->inistate) {
 	case INI_IO_START:
 	case INI_IO_ACTIVE:
@@ -968,11 +974,11 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 		abortio = false;
 		break;
 	default:
-		spin_unlock_irq(&tfcp_req->reqlock);
+		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 		WARN_ON(1);
 		return;
 	}
-	spin_unlock_irq(&tfcp_req->reqlock);
+	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
 	if (abortio)
 		/* leave the reference while the work item is scheduled */
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index eadba13b276d..098b6bf12cd0 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -13,16 +13,9 @@
 
 #define NVMET_MIN_MPOOL_OBJ		16
 
-int nvmet_file_ns_revalidate(struct nvmet_ns *ns)
+void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
 {
-	struct kstat stat;
-	int ret;
-
-	ret = vfs_getattr(&ns->file->f_path, &stat, STATX_SIZE,
-			  AT_STATX_FORCE_SYNC);
-	if (!ret)
-		ns->size = stat.size;
-	return ret;
+	ns->size = i_size_read(ns->file->f_mapping->host);
 }
 
 void nvmet_file_ns_disable(struct nvmet_ns *ns)
@@ -40,7 +33,7 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
 int nvmet_file_ns_enable(struct nvmet_ns *ns)
 {
 	int flags = O_RDWR | O_LARGEFILE;
-	int ret;
+	int ret = 0;
 
 	if (!ns->buffered_io)
 		flags |= O_DIRECT;
@@ -54,9 +47,7 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 		return ret;
 	}
 
-	ret = nvmet_file_ns_revalidate(ns);
-	if (ret)
-		goto err;
+	nvmet_file_ns_revalidate(ns);
 
 	/*
 	 * i_blkbits can be greater than the universally accepted upper bound,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index fdb06a9d430d..17dd84551458 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -542,12 +542,12 @@ u16 nvmet_bdev_flush(struct nvmet_req *req);
 u16 nvmet_file_flush(struct nvmet_req *req);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
 void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
-int nvmet_file_ns_revalidate(struct nvmet_ns *ns);
-void nvmet_ns_revalidate(struct nvmet_ns *ns);
+void nvmet_file_ns_revalidate(struct nvmet_ns *ns);
+bool nvmet_ns_revalidate(struct nvmet_ns *ns);
 u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
 
 bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
-void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
+void nvmet_execute_identify_ctrl_zns(struct nvmet_req *req);
 void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 1466698751c5..ae617d66b137 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -70,7 +70,7 @@ bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
 	return true;
 }
 
-void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
+void nvmet_execute_identify_ctrl_zns(struct nvmet_req *req)
 {
 	u8 zasl = req->sq->ctrl->subsys->zasl;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -97,7 +97,7 @@ void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
 
 void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 {
-	struct nvme_id_ns_zns *id_zns;
+	struct nvme_id_ns_zns *id_zns = NULL;
 	u64 zsze;
 	u16 status;
 	u32 mar, mor;
@@ -118,12 +118,18 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 	if (status)
 		goto done;
 
+	if (nvmet_ns_revalidate(req->ns)) {
+		mutex_lock(&req->ns->subsys->lock);
+		nvmet_ns_changed(req->ns->subsys, req->ns->nsid);
+		mutex_unlock(&req->ns->subsys->lock);
+	}
+
 	if (!bdev_is_zoned(req->ns->bdev)) {
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		req->error_loc = offsetof(struct nvme_identify, nsid);
-		goto done;
+		goto out;
 	}
 
-	nvmet_ns_revalidate(req->ns);
 	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
 					req->ns->blksize_shift;
 	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
@@ -144,8 +150,8 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 
 done:
 	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
-	kfree(id_zns);
 out:
+	kfree(id_zns);
 	nvmet_req_complete(req, status);
 }
 
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 45335fe523f7..19c42a9dcba9 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -290,12 +290,15 @@ int of_device_request_module(struct device *dev)
 	if (size < 0)
 		return size;
 
-	str = kmalloc(size + 1, GFP_KERNEL);
+	/* Reserve an additional byte for the trailing '\0' */
+	size++;
+
+	str = kmalloc(size, GFP_KERNEL);
 	if (!str)
 		return -ENOMEM;
 
 	of_device_get_modalias(dev, str, size);
-	str[size] = '\0';
+	str[size - 1] = '\0';
 	ret = request_module(str);
 	kfree(str);
 
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 67dbf9d88d22..6a3336f2105b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1258,6 +1258,13 @@ DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd,
 static int __init imx6_pcie_init(void)
 {
 #ifdef CONFIG_ARM
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, imx6_pcie_of_match);
+	if (!np)
+		return -ENODEV;
+	of_node_put(np);
+
 	/*
 	 * Since probe() can be deferred we need to make sure that
 	 * hook_fault_code is not called after __init memory is freed
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 4c599699e3c8..5960cbbea818 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1228,11 +1228,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 	val |= BIT(4);
 	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
 
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
-		val |= BIT(31);
-		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
-	}
+	val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+	val |= BIT(31);
+	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
 	return 0;
 err_disable_clocks:
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index d17f3bf36f70..ad12515a4a12 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -63,7 +63,14 @@ int pciehp_configure_device(struct controller *ctrl)
 
 	pci_assign_unassigned_bridge_resources(bridge);
 	pcie_bus_configure_settings(parent);
+
+	/*
+	 * Release reset_lock during driver binding
+	 * to avoid AB-BA deadlock with device_lock.
+	 */
+	up_read(&ctrl->reset_lock);
 	pci_bus_add_devices(parent);
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 
  out:
 	pci_unlock_rescan_remove();
@@ -104,7 +111,15 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
 					 bus_list) {
 		pci_dev_get(dev);
+
+		/*
+		 * Release reset_lock during driver unbinding
+		 * to avoid AB-BA deadlock with device_lock.
+		 */
+		up_read(&ctrl->reset_lock);
 		pci_stop_and_remove_bus_device(dev);
+		down_read_nested(&ctrl->reset_lock, ctrl->depth);
+
 		/*
 		 * Ensure that no new Requests will be generated from
 		 * the device.
diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index a6b9b479b97a..87734e4c3c20 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -193,6 +193,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 	 */
 	if (estate == PCI_ERS_RESULT_RECOVERED) {
 		pci_dbg(edev, "DPC port successfully recovered\n");
+		pcie_clear_device_status(edev);
 		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);
 	} else {
 		pci_dbg(edev, "DPC port recovery failed\n");
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 963de5913e50..71271af39ad6 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -781,6 +781,7 @@ static int tegra_xusb_add_usb2_port(struct tegra_xusb_padctl *padctl,
 	usb2->base.lane = usb2->base.ops->map(&usb2->base);
 	if (IS_ERR(usb2->base.lane)) {
 		err = PTR_ERR(usb2->base.lane);
+		tegra_xusb_port_unregister(&usb2->base);
 		goto out;
 	}
 
@@ -847,6 +848,7 @@ static int tegra_xusb_add_ulpi_port(struct tegra_xusb_padctl *padctl,
 	ulpi->base.lane = ulpi->base.ops->map(&ulpi->base);
 	if (IS_ERR(ulpi->base.lane)) {
 		err = PTR_ERR(ulpi->base.lane);
+		tegra_xusb_port_unregister(&ulpi->base);
 		goto out;
 	}
 
diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index 2f19ab4db720..dd1c9fd733c8 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -452,6 +452,15 @@ static int lpi_config_set(struct pinctrl_dev *pctldev, unsigned int group,
 		}
 	}
 
+	/*
+	 * As per Hardware Programming Guide, when configuring pin as output,
+	 * set the pin value before setting output-enable (OE).
+	 */
+	if (output_enabled) {
+		val = u32_encode_bits(value ? 1 : 0, LPI_GPIO_VALUE_OUT_MASK);
+		lpi_gpio_write(pctrl, group, LPI_GPIO_VALUE_REG, val);
+	}
+
 	val = lpi_gpio_read(pctrl, group, LPI_GPIO_CFG_REG);
 
 	u32p_replace_bits(&val, pullup, LPI_GPIO_PULL_MASK);
@@ -461,11 +470,6 @@ static int lpi_config_set(struct pinctrl_dev *pctldev, unsigned int group,
 
 	lpi_gpio_write(pctrl, group, LPI_GPIO_CFG_REG, val);
 
-	if (output_enabled) {
-		val = u32_encode_bits(value ? 1 : 0, LPI_GPIO_VALUE_OUT_MASK);
-		lpi_gpio_write(pctrl, group, LPI_GPIO_VALUE_REG, val);
-	}
-
 	return 0;
 }
 
diff --git a/drivers/pinctrl/renesas/pfc-r8a779a0.c b/drivers/pinctrl/renesas/pfc-r8a779a0.c
index a480677dd03d..aa4fd56e0250 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779a0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779a0.c
@@ -710,16 +710,8 @@ static const u16 pinmux_data[] = {
 	PINMUX_SINGLE(PCIE0_CLKREQ_N),
 
 	PINMUX_SINGLE(AVB0_PHY_INT),
-	PINMUX_SINGLE(AVB0_MAGIC),
-	PINMUX_SINGLE(AVB0_MDC),
-	PINMUX_SINGLE(AVB0_MDIO),
-	PINMUX_SINGLE(AVB0_TXCREFCLK),
 
 	PINMUX_SINGLE(AVB1_PHY_INT),
-	PINMUX_SINGLE(AVB1_MAGIC),
-	PINMUX_SINGLE(AVB1_MDC),
-	PINMUX_SINGLE(AVB1_MDIO),
-	PINMUX_SINGLE(AVB1_TXCREFCLK),
 
 	PINMUX_SINGLE(AVB2_AVTP_PPS),
 	PINMUX_SINGLE(AVB2_AVTP_CAPTURE),
diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 66039c665dd1..0af536f4932f 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -135,6 +135,9 @@ static int read_channel(struct gab *adc_bat, enum power_supply_property psp,
 			result);
 	if (ret < 0)
 		pr_err("read channel error\n");
+	else
+		*result *= 1000;
+
 	return ret;
 }
 
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index b2e6d00066d7..76f702c43cbc 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -424,7 +424,7 @@ static const struct meson_pwm_data pwm_axg_ee_data = {
 };
 
 static const char * const pwm_axg_ao_parent_names[] = {
-	"aoclk81", "xtal", "fclk_div4", "fclk_div5"
+	"xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5"
 };
 
 static const struct meson_pwm_data pwm_axg_ao_data = {
@@ -433,7 +433,7 @@ static const struct meson_pwm_data pwm_axg_ao_data = {
 };
 
 static const char * const pwm_g12a_ao_ab_parent_names[] = {
-	"xtal", "aoclk81", "fclk_div4", "fclk_div5"
+	"xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5"
 };
 
 static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
@@ -442,7 +442,7 @@ static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
 };
 
 static const char * const pwm_g12a_ao_cd_parent_names[] = {
-	"xtal", "aoclk81",
+	"xtal", "g12a_ao_clk81",
 };
 
 static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 3fbb4bae93a4..92ba02cfec92 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -138,6 +138,19 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	high_width = mul_u64_u64_div_u64(state->duty_cycle, rate, div);
 	value = period | (high_width << PWM_HIGH_WIDTH_SHIFT);
 
+	if (mdp->data->bls_debug && !mdp->data->has_commit) {
+		/*
+		 * For MT2701, disable double buffer before writing register
+		 * and select manual mode and use PWM_PERIOD/PWM_HIGH_WIDTH.
+		 */
+		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
+					 mdp->data->bls_debug_mask,
+					 mdp->data->bls_debug_mask);
+		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
+					 mdp->data->con0_sel,
+					 mdp->data->con0_sel);
+	}
+
 	mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
 				 PWM_CLKDIV_MASK,
 				 clk_div << PWM_CLKDIV_SHIFT);
@@ -152,17 +165,6 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		mtk_disp_pwm_update_bits(mdp, mdp->data->commit,
 					 mdp->data->commit_mask,
 					 0x0);
-	} else {
-		/*
-		 * For MT2701, disable double buffer before writing register
-		 * and select manual mode and use PWM_PERIOD/PWM_HIGH_WIDTH.
-		 */
-		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
-					 mdp->data->bls_debug_mask,
-					 mdp->data->bls_debug_mask);
-		mtk_disp_pwm_update_bits(mdp, mdp->data->con0,
-					 mdp->data->con0_sel,
-					 mdp->data->con0_sel);
 	}
 
 	mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
@@ -194,6 +196,16 @@ static void mtk_disp_pwm_get_state(struct pwm_chip *chip,
 		return;
 	}
 
+	/*
+	 * Apply DISP_PWM_DEBUG settings to choose whether to enable or disable
+	 * registers double buffer and manual commit to working register before
+	 * performing any read/write operation
+	 */
+	if (mdp->data->bls_debug)
+		mtk_disp_pwm_update_bits(mdp, mdp->data->bls_debug,
+					 mdp->data->bls_debug_mask,
+					 mdp->data->bls_debug_mask);
+
 	rate = clk_get_rate(mdp->clk_main);
 	con0 = readl(mdp->base + mdp->data->con0);
 	con1 = readl(mdp->base + mdp->data->con1);
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index cd10880378a6..9ddb80d10dee 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -206,6 +206,78 @@ static void regulator_unlock(struct regulator_dev *rdev)
 	mutex_unlock(&regulator_nesting_mutex);
 }
 
+/**
+ * regulator_lock_two - lock two regulators
+ * @rdev1:		first regulator
+ * @rdev2:		second regulator
+ * @ww_ctx:		w/w mutex acquire context
+ *
+ * Locks both rdevs using the regulator_ww_class.
+ */
+static void regulator_lock_two(struct regulator_dev *rdev1,
+			       struct regulator_dev *rdev2,
+			       struct ww_acquire_ctx *ww_ctx)
+{
+	struct regulator_dev *tmp;
+	int ret;
+
+	ww_acquire_init(ww_ctx, &regulator_ww_class);
+
+	/* Try to just grab both of them */
+	ret = regulator_lock_nested(rdev1, ww_ctx);
+	WARN_ON(ret);
+	ret = regulator_lock_nested(rdev2, ww_ctx);
+	if (ret != -EDEADLOCK) {
+		WARN_ON(ret);
+		goto exit;
+	}
+
+	while (true) {
+		/*
+		 * Start of loop: rdev1 was locked and rdev2 was contended.
+		 * Need to unlock rdev1, slowly lock rdev2, then try rdev1
+		 * again.
+		 */
+		regulator_unlock(rdev1);
+
+		ww_mutex_lock_slow(&rdev2->mutex, ww_ctx);
+		rdev2->ref_cnt++;
+		rdev2->mutex_owner = current;
+		ret = regulator_lock_nested(rdev1, ww_ctx);
+
+		if (ret == -EDEADLOCK) {
+			/* More contention; swap which needs to be slow */
+			tmp = rdev1;
+			rdev1 = rdev2;
+			rdev2 = tmp;
+		} else {
+			WARN_ON(ret);
+			break;
+		}
+	}
+
+exit:
+	ww_acquire_done(ww_ctx);
+}
+
+/**
+ * regulator_unlock_two - unlock two regulators
+ * @rdev1:		first regulator
+ * @rdev2:		second regulator
+ * @ww_ctx:		w/w mutex acquire context
+ *
+ * The inverse of regulator_lock_two().
+ */
+
+static void regulator_unlock_two(struct regulator_dev *rdev1,
+				 struct regulator_dev *rdev2,
+				 struct ww_acquire_ctx *ww_ctx)
+{
+	regulator_unlock(rdev2);
+	regulator_unlock(rdev1);
+	ww_acquire_fini(ww_ctx);
+}
+
 static bool regulator_supply_is_couple(struct regulator_dev *rdev)
 {
 	struct regulator_dev *c_rdev;
@@ -333,6 +405,7 @@ static void regulator_lock_dependent(struct regulator_dev *rdev,
 			ww_mutex_lock_slow(&new_contended_rdev->mutex, ww_ctx);
 			old_contended_rdev = new_contended_rdev;
 			old_contended_rdev->ref_cnt++;
+			old_contended_rdev->mutex_owner = current;
 		}
 
 		err = regulator_lock_recursive(rdev,
@@ -1539,9 +1612,6 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 			rdev->constraints->always_on = true;
 	}
 
-	if (rdev->desc->off_on_delay)
-		rdev->last_off = ktime_get_boottime();
-
 	/* If the constraints say the regulator should be on at this point
 	 * and we have control then make sure it is enabled.
 	 */
@@ -1575,6 +1645,8 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 
 		if (rdev->constraints->always_on)
 			rdev->use_count++;
+	} else if (rdev->desc->off_on_delay) {
+		rdev->last_off = ktime_get();
 	}
 
 	print_constraints(rdev);
@@ -1583,8 +1655,8 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 
 /**
  * set_supply - set regulator supply regulator
- * @rdev: regulator name
- * @supply_rdev: supply regulator name
+ * @rdev: regulator (locked)
+ * @supply_rdev: supply regulator (locked))
  *
  * Called by platform initialisation code to set the supply regulator for this
  * regulator. This ensures that a regulators supply will also be enabled by the
@@ -1756,6 +1828,8 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	struct regulator *regulator;
 	int err = 0;
 
+	lockdep_assert_held_once(&rdev->mutex.base);
+
 	if (dev) {
 		char buf[REG_STR_SIZE];
 		int size;
@@ -1783,9 +1857,7 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	regulator->rdev = rdev;
 	regulator->supply_name = supply_name;
 
-	regulator_lock(rdev);
 	list_add(&regulator->list, &rdev->consumer_list);
-	regulator_unlock(rdev);
 
 	if (dev) {
 		regulator->dev = dev;
@@ -1951,6 +2023,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 {
 	struct regulator_dev *r;
 	struct device *dev = rdev->dev.parent;
+	struct ww_acquire_ctx ww_ctx;
 	int ret = 0;
 
 	/* No supply to resolve? */
@@ -2017,23 +2090,23 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	 * between rdev->supply null check and setting rdev->supply in
 	 * set_supply() from concurrent tasks.
 	 */
-	regulator_lock(rdev);
+	regulator_lock_two(rdev, r, &ww_ctx);
 
 	/* Supply just resolved by a concurrent task? */
 	if (rdev->supply) {
-		regulator_unlock(rdev);
+		regulator_unlock_two(rdev, r, &ww_ctx);
 		put_device(&r->dev);
 		goto out;
 	}
 
 	ret = set_supply(rdev, r);
 	if (ret < 0) {
-		regulator_unlock(rdev);
+		regulator_unlock_two(rdev, r, &ww_ctx);
 		put_device(&r->dev);
 		goto out;
 	}
 
-	regulator_unlock(rdev);
+	regulator_unlock_two(rdev, r, &ww_ctx);
 
 	/*
 	 * In set_machine_constraints() we may have turned this regulator on
@@ -2146,7 +2219,9 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 		return regulator;
 	}
 
+	regulator_lock(rdev);
 	regulator = create_regulator(rdev, dev, id);
+	regulator_unlock(rdev);
 	if (regulator == NULL) {
 		regulator = ERR_PTR(-ENOMEM);
 		module_put(rdev->owner);
@@ -2624,7 +2699,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 
 	trace_regulator_enable(rdev_get_name(rdev));
 
-	if (rdev->desc->off_on_delay && rdev->last_off) {
+	if (rdev->desc->off_on_delay) {
 		/* if needed, keep a distance of off_on_delay from last time
 		 * this regulator was disabled.
 		 */
@@ -5967,6 +6042,7 @@ static void regulator_summary_lock(struct ww_acquire_ctx *ww_ctx)
 			ww_mutex_lock_slow(&new_contended_rdev->mutex, ww_ctx);
 			old_contended_rdev = new_contended_rdev;
 			old_contended_rdev->ref_cnt++;
+			old_contended_rdev->mutex_owner = current;
 		}
 
 		err = regulator_summary_lock_all(ww_ctx,
diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index 2a42acb7c24e..e5dd4db6403b 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -129,17 +129,16 @@ static const struct regulator_desc stm32_pwr_desc[] = {
 
 static int stm32_pwr_regulator_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct stm32_pwr_reg *priv;
 	void __iomem *base;
 	struct regulator_dev *rdev;
 	struct regulator_config config = { };
 	int i, ret = 0;
 
-	base = of_iomap(np, 0);
-	if (!base) {
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base)) {
 		dev_err(&pdev->dev, "Unable to map IO memory\n");
-		return -ENOMEM;
+		return PTR_ERR(base);
 	}
 
 	config.dev = &pdev->dev;
diff --git a/drivers/rtc/rtc-meson-vrtc.c b/drivers/rtc/rtc-meson-vrtc.c
index 1463c8621561..648fa362ec44 100644
--- a/drivers/rtc/rtc-meson-vrtc.c
+++ b/drivers/rtc/rtc-meson-vrtc.c
@@ -23,7 +23,7 @@ static int meson_vrtc_read_time(struct device *dev, struct rtc_time *tm)
 	struct timespec64 time;
 
 	dev_dbg(dev, "%s\n", __func__);
-	ktime_get_raw_ts64(&time);
+	ktime_get_real_ts64(&time);
 	rtc_time64_to_tm(time.tv_sec, tm);
 
 	return 0;
@@ -96,7 +96,7 @@ static int __maybe_unused meson_vrtc_suspend(struct device *dev)
 		long alarm_secs;
 		struct timespec64 time;
 
-		ktime_get_raw_ts64(&time);
+		ktime_get_real_ts64(&time);
 		local_time = time.tv_sec;
 
 		dev_dbg(dev, "alarm_time = %lus, local_time=%lus\n",
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index d46e0f0cc502..3ff832a5af37 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/rtc.h>
+#include <linux/rtc/rtc-omap.h>
 
 /*
  * The OMAP RTC is a year/month/day/hours/minutes/seconds BCD clock
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 8240b804ef84..ed897dc499ff 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2963,7 +2963,7 @@ static int _dasd_requeue_request(struct dasd_ccw_req *cqr)
 		return 0;
 	spin_lock_irq(&cqr->dq->lock);
 	req = (struct request *) cqr->callback_data;
-	blk_mq_requeue_request(req, false);
+	blk_mq_requeue_request(req, true);
 	spin_unlock_irq(&cqr->dq->lock);
 
 	return 0;
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index f79299f6178c..2ca4cf1b58c4 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -11738,7 +11738,7 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
 				goto out_iounmap_all;
 		} else {
 			error = -ENOMEM;
-			goto out_iounmap_all;
+			goto out_iounmap_ctrl;
 		}
 	}
 
@@ -11756,7 +11756,7 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
 			dev_err(&pdev->dev,
 			   "ioremap failed for SLI4 HBA dpp registers.\n");
 			error = -ENOMEM;
-			goto out_iounmap_ctrl;
+			goto out_iounmap_all;
 		}
 		phba->pci_bar4_memmap_p = phba->sli4_hba.dpp_regs_memmap_p;
 	}
@@ -11781,9 +11781,11 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba *phba)
 	return 0;
 
 out_iounmap_all:
-	iounmap(phba->sli4_hba.drbl_regs_memmap_p);
+	if (phba->sli4_hba.drbl_regs_memmap_p)
+		iounmap(phba->sli4_hba.drbl_regs_memmap_p);
 out_iounmap_ctrl:
-	iounmap(phba->sli4_hba.ctrl_regs_memmap_p);
+	if (phba->sli4_hba.ctrl_regs_memmap_p)
+		iounmap(phba->sli4_hba.ctrl_regs_memmap_p);
 out_iounmap_conf:
 	iounmap(phba->sli4_hba.conf_regs_memmap_p);
 
diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index 7dd6dd74d2bc..6122cc60a8b3 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -1443,6 +1443,7 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 		 */
 		if (cmdid == CMDID_INT_CMDS) {
 			scb = &adapter->int_scb;
+			cmd = scb->cmd;
 
 			list_del_init(&scb->list);
 			scb->state = SCB_FREE;
diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index 7bab4bbaf02d..285302bf3ef9 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -527,7 +527,7 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 
 	ret = am33xx_pm_alloc_sram();
 	if (ret)
-		return ret;
+		goto err_wkup_m3_ipc_put;
 
 	ret = am33xx_pm_rtc_setup();
 	if (ret)
@@ -574,13 +574,14 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 err_pm_runtime_disable:
 	pm_runtime_disable(dev);
-	wkup_m3_ipc_put(m3_ipc);
 err_unsetup_rtc:
 	iounmap(rtc_base_virt);
 	clk_put(rtc_fck);
 err_free_sram:
 	am33xx_pm_free_sram();
 	pm33xx_dev = NULL;
+err_wkup_m3_ipc_put:
+	wkup_m3_ipc_put(m3_ipc);
 	return ret;
 }
 
diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 500035a1fd46..52d0e4164c6b 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -640,7 +640,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 
 	ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
 	/* Configure number of retries of a read/write cmd */
-	if (ctrl->version > 0x01050001) {
+	if (ctrl->version >= 0x01050001) {
 		/* Only for versions >= 1.5.1 */
 		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR,
 				SWRM_RD_WR_CMD_RETRIES |
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index cda70de38330..5c8f198b0ae3 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1619,17 +1619,30 @@ static int cqspi_remove(struct platform_device *pdev)
 static int cqspi_suspend(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
+	struct spi_master *master = dev_get_drvdata(dev);
+	int ret;
 
+	ret = spi_master_suspend(master);
 	cqspi_controller_enable(cqspi, 0);
-	return 0;
+
+	clk_disable_unprepare(cqspi->clk);
+
+	return ret;
 }
 
 static int cqspi_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
+	struct spi_master *master = dev_get_drvdata(dev);
 
-	cqspi_controller_enable(cqspi, 1);
-	return 0;
+	clk_prepare_enable(cqspi->clk);
+	cqspi_wait_idle(cqspi);
+	cqspi_controller_init(cqspi);
+
+	cqspi->current_cs = -1;
+	cqspi->sclk = 0;
+
+	return spi_master_resume(master);
 }
 
 static const struct dev_pm_ops cqspi__dev_pm_ops = {
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index bdf94cc7be1a..1bad0ceac81b 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -207,8 +207,8 @@ static int mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
 				struct spi_device *spi,
 				int bits_per_word)
 {
-	/* QE uses Little Endian for words > 8
-	 * so transform all words > 8 into 8 bits
+	/* CPM/QE uses Little Endian for words > 8
+	 * so transform 16 and 32 bits words into 8 bits
 	 * Unfortnatly that doesn't work for LSB so
 	 * reject these for now */
 	/* Note: 32 bits word, LSB works iff
@@ -216,9 +216,11 @@ static int mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
 	if (spi->mode & SPI_LSB_FIRST &&
 	    bits_per_word > 8)
 		return -EINVAL;
-	if (bits_per_word > 8)
+	if (bits_per_word <= 8)
+		return bits_per_word;
+	if (bits_per_word == 16 || bits_per_word == 32)
 		return 8; /* pretend its 8 bits */
-	return bits_per_word;
+	return -EINVAL;
 }
 
 static int fsl_spi_setup_transfer(struct spi_device *spi,
@@ -248,7 +250,7 @@ static int fsl_spi_setup_transfer(struct spi_device *spi,
 		bits_per_word = mspi_apply_cpu_mode_quirks(cs, spi,
 							   mpc8xxx_spi,
 							   bits_per_word);
-	else if (mpc8xxx_spi->flags & SPI_QE)
+	else
 		bits_per_word = mspi_apply_qe_mode_quirks(cs, spi,
 							  bits_per_word);
 
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 890b2cf02149..2f06f2840d61 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1552,9 +1552,8 @@ spi_imx_prepare_message(struct spi_master *master, struct spi_message *msg)
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 	int ret;
 
-	ret = pm_runtime_get_sync(spi_imx->dev);
+	ret = pm_runtime_resume_and_get(spi_imx->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(spi_imx->dev);
 		dev_err(spi_imx->dev, "failed to enable clock\n");
 		return ret;
 	}
@@ -1771,13 +1770,10 @@ static int spi_imx_remove(struct platform_device *pdev)
 	spi_bitbang_stop(&spi_imx->bitbang);
 
 	ret = pm_runtime_get_sync(spi_imx->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(spi_imx->dev);
-		dev_err(spi_imx->dev, "failed to enable clock\n");
-		return ret;
-	}
-
-	writel(0, spi_imx->base + MXC_CSPICTRL);
+	if (ret >= 0)
+		writel(0, spi_imx->base + MXC_CSPICTRL);
+	else
+		dev_warn(spi_imx->dev, "failed to enable clock, skip hw disable\n");
 
 	pm_runtime_dont_use_autosuspend(spi_imx->dev);
 	pm_runtime_put_sync(spi_imx->dev);
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index f3877eeb3da6..8bf58510cca6 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1276,18 +1276,22 @@ static int spi_qup_remove(struct platform_device *pdev)
 	struct spi_qup *controller = spi_master_get_devdata(master);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_sync(&pdev->dev);
 
-	ret = spi_qup_set_state(controller, QUP_STATE_RESET);
-	if (ret)
-		return ret;
+	if (ret >= 0) {
+		ret = spi_qup_set_state(controller, QUP_STATE_RESET);
+		if (ret)
+			dev_warn(&pdev->dev, "failed to reset controller (%pe)\n",
+				 ERR_PTR(ret));
 
-	spi_qup_release_dma(master);
+		clk_disable_unprepare(controller->cclk);
+		clk_disable_unprepare(controller->iclk);
+	} else {
+		dev_warn(&pdev->dev, "failed to resume, skip hw disable (%pe)\n",
+			 ERR_PTR(ret));
+	}
 
-	clk_disable_unprepare(controller->cclk);
-	clk_disable_unprepare(controller->iclk);
+	spi_qup_release_dma(master);
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index b37ead9e2fad..38913c0f1115 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -350,7 +350,8 @@ static void spmi_drv_remove(struct device *dev)
 	const struct spmi_driver *sdrv = to_spmi_driver(dev->driver);
 
 	pm_runtime_get_sync(dev);
-	sdrv->remove(to_spmi_device(dev));
+	if (sdrv->remove)
+		sdrv->remove(to_spmi_device(dev));
 	pm_runtime_put_noidle(dev);
 
 	pm_runtime_disable(dev);
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 74adb82f37c3..a19cfb2998c9 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -101,7 +101,7 @@ struct ad2s1210_state {
 static const int ad2s1210_mode_vals[4][2] = {
 	[MOD_POS] = { 0, 0 },
 	[MOD_VEL] = { 0, 1 },
-	[MOD_CONFIG] = { 1, 0 },
+	[MOD_CONFIG] = { 1, 1 },
 };
 
 static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
index 91f4866c7e59..964092e2f41f 100644
--- a/drivers/staging/media/av7110/av7110_av.c
+++ b/drivers/staging/media/av7110/av7110_av.c
@@ -823,10 +823,10 @@ static int write_ts_to_decoder(struct av7110 *av7110, int type, const u8 *buf, s
 		av7110_ipack_flush(ipack);
 
 	if (buf[3] & ADAPT_FIELD) {
+		if (buf[4] > len - 1 - 4)
+			return 0;
 		len -= buf[4] + 1;
 		buf += buf[4] + 1;
-		if (!len)
-			return 0;
 	}
 
 	av7110_ipack_instant_repack(buf + 4, len - 4, ipack);
diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 4fd4a2907da7..bc4683a75e61 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -1042,6 +1042,8 @@ static int rkvdec_remove(struct platform_device *pdev)
 {
 	struct rkvdec_dev *rkvdec = platform_get_drvdata(pdev);
 
+	cancel_delayed_work_sync(&rkvdec->watchdog_work);
+
 	rkvdec_v4l2_cleanup(rkvdec);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 616ab3c8fde4..48c696df8d01 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -768,6 +768,7 @@ static int _rtl92e_sta_up(struct net_device *dev, bool is_silent_reset)
 	else
 		netif_wake_queue(dev);
 
+	priv->bfirst_after_down = false;
 	return 0;
 }
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 26c40042d2be..5b64980e8522 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1547,7 +1547,7 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 		return;
 
-	spin_lock_irq(&pmlmepriv->lock);
+	spin_lock_bh(&pmlmepriv->lock);
 
 	if (rtw_to_roam(adapter) > 0) { /* join timeout caused by roaming */
 		while (1) {
@@ -1575,7 +1575,7 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 
 	}
 
-	spin_unlock_irq(&pmlmepriv->lock);
+	spin_unlock_bh(&pmlmepriv->lock);
 }
 
 /*
@@ -1588,11 +1588,11 @@ void rtw_scan_timeout_handler(struct timer_list *t)
 						  mlmepriv.scan_to_timer);
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
-	spin_lock_irq(&pmlmepriv->lock);
+	spin_lock_bh(&pmlmepriv->lock);
 
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 
-	spin_unlock_irq(&pmlmepriv->lock);
+	spin_unlock_bh(&pmlmepriv->lock);
 
 	rtw_indicate_scan_done(adapter, true);
 }
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 2c54c5d8412d..9c6b98438f98 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4086,9 +4086,12 @@ static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
 	list_for_each_entry_safe(cmd, cmd_tmp, &tmp_list, i_conn_node) {
 		struct se_cmd *se_cmd = &cmd->se_cmd;
 
-		if (se_cmd->se_tfo != NULL) {
-			spin_lock_irq(&se_cmd->t_state_lock);
-			if (se_cmd->transport_state & CMD_T_ABORTED) {
+		if (!se_cmd->se_tfo)
+			continue;
+
+		spin_lock_irq(&se_cmd->t_state_lock);
+		if (se_cmd->transport_state & CMD_T_ABORTED) {
+			if (!(se_cmd->transport_state & CMD_T_TAS))
 				/*
 				 * LIO's abort path owns the cleanup for this,
 				 * so put it back on the list and let
@@ -4096,11 +4099,10 @@ static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
 				 */
 				list_move_tail(&cmd->i_conn_node,
 					       &conn->conn_cmd_list);
-			} else {
-				se_cmd->transport_state |= CMD_T_FABRIC_STOP;
-			}
-			spin_unlock_irq(&se_cmd->t_state_lock);
+		} else {
+			se_cmd->transport_state |= CMD_T_FABRIC_STOP;
 		}
+		spin_unlock_irq(&se_cmd->t_state_lock);
 	}
 	spin_unlock_bh(&conn->cmd_lock);
 
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index fa866acef5bb..e18617371a9b 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -773,6 +773,7 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
 	spin_lock_init(&dev->t10_alua.lba_map_lock);
 
 	INIT_WORK(&dev->delayed_cmd_work, target_do_delayed_work);
+	mutex_init(&dev->lun_reset_mutex);
 
 	dev->t10_wwn.t10_dev = dev;
 	/*
diff --git a/drivers/target/target_core_tmr.c b/drivers/target/target_core_tmr.c
index 2b95b4550a63..4718db628222 100644
--- a/drivers/target/target_core_tmr.c
+++ b/drivers/target/target_core_tmr.c
@@ -188,14 +188,23 @@ static void core_tmr_drain_tmr_list(
 	 * LUN_RESET tmr..
 	 */
 	spin_lock_irqsave(&dev->se_tmr_lock, flags);
-	if (tmr)
-		list_del_init(&tmr->tmr_list);
 	list_for_each_entry_safe(tmr_p, tmr_pp, &dev->dev_tmr_list, tmr_list) {
+		if (tmr_p == tmr)
+			continue;
+
 		cmd = tmr_p->task_cmd;
 		if (!cmd) {
 			pr_err("Unable to locate struct se_cmd for TMR\n");
 			continue;
 		}
+
+		/*
+		 * We only execute one LUN_RESET at a time so we can't wait
+		 * on them below.
+		 */
+		if (tmr_p->function == TMR_LUN_RESET)
+			continue;
+
 		/*
 		 * If this function was called with a valid pr_res_key
 		 * parameter (eg: for PROUT PREEMPT_AND_ABORT service action
@@ -379,14 +388,25 @@ int core_tmr_lun_reset(
 				tmr_nacl->initiatorname);
 		}
 	}
+
+
+	/*
+	 * We only allow one reset or preempt and abort to execute at a time
+	 * to prevent one call from claiming all the cmds causing a second
+	 * call from returning while cmds it should have waited on are still
+	 * running.
+	 */
+	mutex_lock(&dev->lun_reset_mutex);
+
 	pr_debug("LUN_RESET: %s starting for [%s], tas: %d\n",
 		(preempt_and_abort_list) ? "Preempt" : "TMR",
 		dev->transport->name, tas);
-
 	core_tmr_drain_tmr_list(dev, tmr, preempt_and_abort_list);
 	core_tmr_drain_state_list(dev, prout_cmd, tmr_sess, tas,
 				preempt_and_abort_list);
 
+	mutex_unlock(&dev->lun_reset_mutex);
+
 	/*
 	 * Clear any legacy SPC-2 reservation when called during
 	 * LOGICAL UNIT RESET
diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index ede94eadddda..9c857fb5d968 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -1028,7 +1028,12 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	auxadc_base = of_iomap(auxadc, 0);
+	auxadc_base = devm_of_iomap(&pdev->dev, auxadc, 0, NULL);
+	if (IS_ERR(auxadc_base)) {
+		of_node_put(auxadc);
+		return PTR_ERR(auxadc_base);
+	}
+
 	auxadc_phys_base = of_get_phys_base(auxadc);
 
 	of_node_put(auxadc);
@@ -1044,7 +1049,12 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	apmixed_base = of_iomap(apmixedsys, 0);
+	apmixed_base = devm_of_iomap(&pdev->dev, apmixedsys, 0, NULL);
+	if (IS_ERR(apmixed_base)) {
+		of_node_put(apmixedsys);
+		return PTR_ERR(apmixed_base);
+	}
+
 	apmixed_phys_base = of_get_phys_base(apmixedsys);
 
 	of_node_put(apmixedsys);
diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 60b3ac1a0317..87ff28a3a94c 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1018,14 +1018,16 @@ static int brcmuart_probe(struct platform_device *pdev)
 	/* See if a Baud clock has been specified */
 	baud_mux_clk = of_clk_get_by_name(np, "sw_baud");
 	if (IS_ERR(baud_mux_clk)) {
-		if (PTR_ERR(baud_mux_clk) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(baud_mux_clk) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto release_dma;
+		}
 		dev_dbg(dev, "BAUD MUX clock not specified\n");
 	} else {
 		dev_dbg(dev, "BAUD MUX clock found\n");
 		ret = clk_prepare_enable(baud_mux_clk);
 		if (ret)
-			return ret;
+			goto release_dma;
 		priv->baud_mux_clk = baud_mux_clk;
 		init_real_clk_rates(dev, priv);
 		clk_rate = priv->default_mux_rate;
@@ -1033,7 +1035,8 @@ static int brcmuart_probe(struct platform_device *pdev)
 
 	if (clk_rate == 0) {
 		dev_err(dev, "clock-frequency or clk not defined\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto release_dma;
 	}
 
 	dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
@@ -1120,7 +1123,9 @@ static int brcmuart_probe(struct platform_device *pdev)
 	serial8250_unregister_port(priv->line);
 err:
 	brcmuart_free_bufs(dev, priv);
-	brcmuart_arbitration(priv, 0);
+release_dma:
+	if (priv->dma_enabled)
+		brcmuart_arbitration(priv, 0);
 	return ret;
 }
 
@@ -1132,7 +1137,8 @@ static int brcmuart_remove(struct platform_device *pdev)
 	hrtimer_cancel(&priv->hrt);
 	serial8250_unregister_port(priv->line);
 	brcmuart_free_bufs(&pdev->dev, priv);
-	brcmuart_arbitration(priv, 0);
+	if (priv->dma_enabled)
+		brcmuart_arbitration(priv, 0);
 	return 0;
 }
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 691e7a07565c..5939f510cb0c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -15,6 +15,7 @@
 #include <linux/moduleparam.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/console.h>
 #include <linux/gpio/consumer.h>
 #include <linux/sysrq.h>
@@ -1904,6 +1905,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 {
 	unsigned char status;
 	struct uart_8250_port *up = up_to_u8250p(port);
+	struct tty_port *tport = &port->state->port;
 	bool skip_rx = false;
 	unsigned long flags;
 
@@ -1928,6 +1930,8 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		skip_rx = true;
 
 	if (status & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
+		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
+			pm_wakeup_event(tport->tty->dev, 0);
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
 	}
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 5cabc3c85eb1..00a941db8dcb 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1250,7 +1250,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	 * 10ms at any baud rate.
 	 */
 	sport->rx_dma_rng_buf_len = (DMA_RX_TIMEOUT * baud /  bits / 1000) * 2;
-	sport->rx_dma_rng_buf_len = (1 << (fls(sport->rx_dma_rng_buf_len) - 1));
+	sport->rx_dma_rng_buf_len = (1 << fls(sport->rx_dma_rng_buf_len));
 	if (sport->rx_dma_rng_buf_len < 16)
 		sport->rx_dma_rng_buf_len = 16;
 
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 5c60960e185d..3b7d4481edbe 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -264,19 +264,22 @@ static unsigned long stm32_usart_get_char(struct uart_port *port, u32 *sr,
 	return c;
 }
 
-static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
+static void stm32_usart_receive_chars(struct uart_port *port, bool irqflag)
 {
 	struct tty_port *tport = &port->state->port;
 	struct stm32_port *stm32_port = to_stm32_port(port);
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
-	unsigned long c;
+	unsigned long c, flags;
 	u32 sr;
 	char flag;
 
-	spin_lock(&port->lock);
+	if (irqflag)
+		spin_lock_irqsave(&port->lock, flags);
+	else
+		spin_lock(&port->lock);
 
 	while (stm32_usart_pending_rx(port, &sr, &stm32_port->last_res,
-				      threaded)) {
+				      irqflag)) {
 		sr |= USART_SR_DUMMY_RX;
 		flag = TTY_NORMAL;
 
@@ -330,7 +333,10 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
 		uart_insert_char(port, sr, USART_SR_ORE, c, flag);
 	}
 
-	uart_unlock_and_check_sysrq(port);
+	if (irqflag)
+		uart_unlock_and_check_sysrq_irqrestore(port, irqflag);
+	else
+		uart_unlock_and_check_sysrq(port);
 
 	tty_flip_buffer_push(tport);
 }
@@ -496,8 +502,9 @@ static void stm32_usart_transmit_chars(struct uart_port *port)
 	int ret;
 
 	if (!stm32_port->hw_flow_control &&
-	    port->rs485.flags & SER_RS485_ENABLED) {
-		stm32_port->txdone = false;
+	    port->rs485.flags & SER_RS485_ENABLED &&
+	    (port->x_char ||
+	     !(uart_circ_empty(xmit) || uart_tx_stopped(port)))) {
 		stm32_usart_tc_interrupt_disable(port);
 		stm32_usart_rs485_rts_enable(port);
 	}
@@ -599,10 +606,9 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 static irqreturn_t stm32_usart_threaded_interrupt(int irq, void *ptr)
 {
 	struct uart_port *port = ptr;
-	struct stm32_port *stm32_port = to_stm32_port(port);
 
-	if (stm32_port->rx_ch)
-		stm32_usart_receive_chars(port, true);
+	/* Receiver timeout irq for DMA RX */
+	stm32_usart_receive_chars(port, false);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 6b445ece8339..4ffed77f8001 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -301,7 +301,7 @@ static const struct sysrq_key_op sysrq_showregs_op = {
 static void sysrq_handle_showstate(int key)
 {
 	show_state();
-	show_workqueue_state();
+	show_all_workqueues();
 }
 static const struct sysrq_key_op sysrq_showstate_op = {
 	.handler	= sysrq_handle_showstate,
diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index f310a8274df1..72b88aafd536 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -62,6 +62,8 @@ int __tty_check_change(struct tty_struct *tty, int sig);
 int tty_check_change(struct tty_struct *tty);
 void __stop_tty(struct tty_struct *tty);
 void __start_tty(struct tty_struct *tty);
+void tty_write_unlock(struct tty_struct *tty);
+int tty_write_lock(struct tty_struct *tty, int ndelay);
 void tty_vhangup_session(struct tty_struct *tty);
 void tty_open_proc_set_tty(struct file *filp, struct tty_struct *tty);
 int tty_signal_session_leader(struct tty_struct *tty, int exit_session);
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 64dd6439d179..3d540dff42ef 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -950,13 +950,13 @@ static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
 	return i;
 }
 
-static void tty_write_unlock(struct tty_struct *tty)
+void tty_write_unlock(struct tty_struct *tty)
 {
 	mutex_unlock(&tty->atomic_write_lock);
 	wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
 }
 
-static int tty_write_lock(struct tty_struct *tty, int ndelay)
+int tty_write_lock(struct tty_struct *tty, int ndelay)
 {
 	if (!mutex_trylock(&tty->atomic_write_lock)) {
 		if (ndelay)
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 507a25d692bb..1736130f9c39 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -421,21 +421,42 @@ static int set_termios(struct tty_struct *tty, void __user *arg, int opt)
 	tmp_termios.c_ispeed = tty_termios_input_baud_rate(&tmp_termios);
 	tmp_termios.c_ospeed = tty_termios_baud_rate(&tmp_termios);
 
-	ld = tty_ldisc_ref(tty);
+	if (opt & (TERMIOS_FLUSH|TERMIOS_WAIT)) {
+retry_write_wait:
+		retval = wait_event_interruptible(tty->write_wait, !tty_chars_in_buffer(tty));
+		if (retval < 0)
+			return retval;
 
-	if (ld != NULL) {
-		if ((opt & TERMIOS_FLUSH) && ld->ops->flush_buffer)
-			ld->ops->flush_buffer(tty);
-		tty_ldisc_deref(ld);
-	}
+		if (tty_write_lock(tty, 0) < 0)
+			goto retry_write_wait;
 
-	if (opt & TERMIOS_WAIT) {
-		tty_wait_until_sent(tty, 0);
-		if (signal_pending(current))
-			return -ERESTARTSYS;
-	}
+		/* Racing writer? */
+		if (tty_chars_in_buffer(tty)) {
+			tty_write_unlock(tty);
+			goto retry_write_wait;
+		}
 
-	tty_set_termios(tty, &tmp_termios);
+		ld = tty_ldisc_ref(tty);
+		if (ld != NULL) {
+			if ((opt & TERMIOS_FLUSH) && ld->ops->flush_buffer)
+				ld->ops->flush_buffer(tty);
+			tty_ldisc_deref(ld);
+		}
+
+		if ((opt & TERMIOS_WAIT) && tty->ops->wait_until_sent) {
+			tty->ops->wait_until_sent(tty, 0);
+			if (signal_pending(current)) {
+				tty_write_unlock(tty);
+				return -ERESTARTSYS;
+			}
+		}
+
+		tty_set_termios(tty, &tmp_termios);
+
+		tty_write_unlock(tty);
+	} else {
+		tty_set_termios(tty, &tmp_termios);
+	}
 
 	/* FIXME: Arguably if tmp_termios == tty->termios AND the
 	   actual requested termios was not tmp_termios then we may
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index a9869975ce32..0e8f4aa031f8 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -1098,7 +1098,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	ret = ci_usb_phy_init(ci);
 	if (ret) {
 		dev_err(dev, "unable to init phy: %d\n", ret);
-		return ret;
+		goto ulpi_exit;
 	}
 
 	ci->hw_bank.phys = res->start;
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7258e640e9ee..9dbea2148362 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1642,13 +1642,11 @@ static int dwc3_probe(struct platform_device *pdev)
 	spin_lock_init(&dwc->lock);
 	mutex_init(&dwc->mutex);
 
+	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, DWC3_DEFAULT_AUTOSUSPEND_DELAY);
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
-		goto err1;
 
 	pm_runtime_forbid(dev);
 
@@ -1707,12 +1705,10 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc3_free_event_buffers(dwc);
 
 err2:
-	pm_runtime_allow(&pdev->dev);
-
-err1:
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-
+	pm_runtime_allow(dev);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
 disable_clks:
 	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
 assert_reset:
@@ -1736,6 +1732,7 @@ static int dwc3_remove(struct platform_device *pdev)
 	dwc3_core_exit(dwc);
 	dwc3_ulpi_exit(dwc);
 
+	pm_runtime_allow(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index eaf64f33fe07..7ff77a0de515 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4092,15 +4092,8 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		break;
 	case DWC3_DEVICE_EVENT_SUSPEND:
 		/* It changed to be suspend event for version 2.30a and above */
-		if (!DWC3_VER_IS_PRIOR(DWC3, 230A)) {
-			/*
-			 * Ignore suspend event until the gadget enters into
-			 * USB_STATE_CONFIGURED state.
-			 */
-			if (dwc->gadget->state >= USB_STATE_CONFIGURED)
-				dwc3_gadget_suspend_interrupt(dwc,
-						event->event_info);
-		}
+		if (!DWC3_VER_IS_PRIOR(DWC3, 230A))
+			dwc3_gadget_suspend_interrupt(dwc, event->event_info);
 		break;
 	case DWC3_DEVICE_EVENT_SOF:
 	case DWC3_DEVICE_EVENT_ERRATIC_ERROR:
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 601829a6b4ba..a10f41c4a3f2 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2568,6 +2568,7 @@ static int renesas_usb3_remove(struct platform_device *pdev)
 	debugfs_remove_recursive(usb3->dentry);
 	device_remove_file(&pdev->dev, &dev_attr_role);
 
+	cancel_work_sync(&usb3->role_work);
 	usb_role_switch_unregister(usb3->role_sw);
 
 	usb_del_gadget_udc(&usb3->gadget);
diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index cb4ddfa52cb0..1cb4258077bd 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -2154,7 +2154,7 @@ static int tegra_xudc_gadget_vbus_draw(struct usb_gadget *gadget,
 
 	dev_dbg(xudc->dev, "%s: %u mA\n", __func__, m_a);
 
-	if (xudc->curr_usbphy->chg_type == SDP_TYPE)
+	if (xudc->curr_usbphy && xudc->curr_usbphy->chg_type == SDP_TYPE)
 		ret = usb_phy_set_power(xudc->curr_usbphy, m_a);
 
 	return ret;
diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index dc832ddf7033..bd40caeeb21c 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -133,6 +133,7 @@ static void xhci_debugfs_regset(struct xhci_hcd *xhci, u32 base,
 	regset->regs = regs;
 	regset->nregs = nregs;
 	regset->base = hcd->regs + base;
+	regset->dev = hcd->self.controller;
 
 	debugfs_create_regset32((const char *)rgs->name, 0444, parent, regset);
 }
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index 9888ba7d85b6..cfafa1c50ade 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -75,7 +75,6 @@ MODULE_FIRMWARE(XHCI_RCAR_FIRMWARE_NAME_V3);
 
 /* For soc_device_attribute */
 #define RCAR_XHCI_FIRMWARE_V2   BIT(0) /* FIRMWARE V2 */
-#define RCAR_XHCI_FIRMWARE_V3   BIT(1) /* FIRMWARE V3 */
 
 static const struct soc_device_attribute rcar_quirks_match[]  = {
 	{
@@ -147,8 +146,6 @@ static int xhci_rcar_download_firmware(struct usb_hcd *hcd)
 
 	if (quirks & RCAR_XHCI_FIRMWARE_V2)
 		firmware_name = XHCI_RCAR_FIRMWARE_NAME_V2;
-	else if (quirks & RCAR_XHCI_FIRMWARE_V3)
-		firmware_name = XHCI_RCAR_FIRMWARE_NAME_V3;
 	else
 		firmware_name = priv->firmware_name;
 
diff --git a/drivers/usb/mtu3/mtu3_qmu.c b/drivers/usb/mtu3/mtu3_qmu.c
index 2ea3157ddb6e..e65586147965 100644
--- a/drivers/usb/mtu3/mtu3_qmu.c
+++ b/drivers/usb/mtu3/mtu3_qmu.c
@@ -210,6 +210,7 @@ static struct qmu_gpd *advance_enq_gpd(struct mtu3_gpd_ring *ring)
 	return ring->enqueue;
 }
 
+/* @dequeue may be NULL if ring is unallocated or freed */
 static struct qmu_gpd *advance_deq_gpd(struct mtu3_gpd_ring *ring)
 {
 	if (ring->dequeue < ring->end)
@@ -484,7 +485,7 @@ static void qmu_done_tx(struct mtu3 *mtu, u8 epnum)
 	dev_dbg(mtu->dev, "%s EP%d, last=%p, current=%p, enq=%p\n",
 		__func__, epnum, gpd, gpd_current, ring->enqueue);
 
-	while (gpd != gpd_current && !GET_GPD_HWO(gpd)) {
+	while (gpd && gpd != gpd_current && !GET_GPD_HWO(gpd)) {
 
 		mreq = next_request(mep);
 
@@ -523,7 +524,7 @@ static void qmu_done_rx(struct mtu3 *mtu, u8 epnum)
 	dev_dbg(mtu->dev, "%s EP%d, last=%p, current=%p, enq=%p\n",
 		__func__, epnum, gpd, gpd_current, ring->enqueue);
 
-	while (gpd != gpd_current && !GET_GPD_HWO(gpd)) {
+	while (gpd && gpd != gpd_current && !GET_GPD_HWO(gpd)) {
 
 		mreq = next_request(mep);
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 603a6f4345ef..800df63c5869 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -809,6 +809,14 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
 
 	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
 		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
+
+		/*
+		 * If device triggered an event already it won't trigger one again:
+		 * no need to disable.
+		 */
+		if (vq->event_triggered)
+			return;
+
 		if (vq->event)
 			/* TODO: this is a hack. Figure out a cleaner value to write. */
 			vring_used_event(&vq->split.vring) = 0x0;
@@ -1500,6 +1508,14 @@ static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
 
 	if (vq->packed.event_flags_shadow != VRING_PACKED_EVENT_FLAG_DISABLE) {
 		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
+
+		/*
+		 * If device triggered an event already it won't trigger one again:
+		 * no need to disable.
+		 */
+		if (vq->event_triggered)
+			return;
+
 		vq->packed.vring.driver->flags =
 			cpu_to_le16(vq->packed.event_flags_shadow);
 	}
@@ -2019,12 +2035,6 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	/* If device triggered an event already it won't trigger one again:
-	 * no need to disable.
-	 */
-	if (vq->event_triggered)
-		return;
-
 	if (vq->packed_ring)
 		virtqueue_disable_cb_packed(_vq);
 	else
diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
index fd3a644b0855..b3e3d1bb37f3 100644
--- a/drivers/xen/pcpu.c
+++ b/drivers/xen/pcpu.c
@@ -58,6 +58,7 @@ struct pcpu {
 	struct list_head list;
 	struct device dev;
 	uint32_t cpu_id;
+	uint32_t acpi_id;
 	uint32_t flags;
 };
 
@@ -249,6 +250,7 @@ static struct pcpu *create_and_register_pcpu(struct xenpf_pcpuinfo *info)
 
 	INIT_LIST_HEAD(&pcpu->list);
 	pcpu->cpu_id = info->xen_cpuid;
+	pcpu->acpi_id = info->acpi_id;
 	pcpu->flags = info->flags;
 
 	/* Need hold on xen_pcpu_lock before pcpu list manipulations */
@@ -381,3 +383,21 @@ static int __init xen_pcpu_init(void)
 	return ret;
 }
 arch_initcall(xen_pcpu_init);
+
+#ifdef CONFIG_ACPI
+bool __init xen_processor_present(uint32_t acpi_id)
+{
+	const struct pcpu *pcpu;
+	bool online = false;
+
+	mutex_lock(&xen_pcpu_lock);
+	list_for_each_entry(pcpu, &xen_pcpus, list)
+		if (pcpu->acpi_id == acpi_id) {
+			online = pcpu->flags & XEN_PCPU_FLAGS_ONLINE;
+			break;
+		}
+	mutex_unlock(&xen_pcpu_lock);
+
+	return online;
+}
+#endif
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 785bacb972da..91b1f8cabd58 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -219,6 +219,7 @@ static void afs_apply_status(struct afs_operation *op,
 			set_bit(AFS_VNODE_ZAP_DATA, &vnode->flags);
 		}
 		change_size = true;
+		data_changed = true;
 	} else if (vnode->status.type == AFS_FTYPE_DIR) {
 		/* Expected directory change is handled elsewhere so
 		 * that we can locally edit the directory and save on a
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f4173294f60e..c9b3d99171b2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3715,6 +3715,11 @@ static long btrfs_ioctl_scrub(struct file *file, void __user *arg)
 	if (IS_ERR(sa))
 		return PTR_ERR(sa);
 
+	if (sa->flags & ~BTRFS_SCRUB_SUPPORTED_FLAGS) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	if (!(sa->flags & BTRFS_SCRUB_READONLY)) {
 		ret = mnt_want_write_file(file);
 		if (ret)
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index b3cf9ab50139..ebf2877dbe76 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4870,6 +4870,8 @@ void cifs_oplock_break(struct work_struct *work)
 	struct TCP_Server_Info *server = tcon->ses->server;
 	int rc = 0;
 	bool purge_cache = false;
+	struct cifs_deferred_close *dclose;
+	bool is_deferred = false;
 
 	wait_on_bit(&cinode->flags, CIFS_INODE_PENDING_WRITERS,
 			TASK_UNINTERRUPTIBLE);
@@ -4905,6 +4907,20 @@ void cifs_oplock_break(struct work_struct *work)
 		cifs_dbg(VFS, "Push locks rc = %d\n", rc);
 
 oplock_break_ack:
+	/*
+	 * When oplock break is received and there are no active
+	 * file handles but cached, then schedule deferred close immediately.
+	 * So, new open will not use cached handle.
+	 */
+	spin_lock(&CIFS_I(inode)->deferred_lock);
+	is_deferred = cifs_is_deferred_close(cfile, &dclose);
+	spin_unlock(&CIFS_I(inode)->deferred_lock);
+
+	if (!CIFS_CACHE_HANDLE(cinode) && is_deferred &&
+			cfile->deferred_close_scheduled && delayed_work_pending(&cfile->deferred)) {
+		cifs_close_deferred_file(cinode);
+	}
+
 	/*
 	 * releasing stale oplock after recent reconnect of smb session using
 	 * a now incorrect file handle is not a data integrity issue but do
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 300f5f382e43..5e4dab5dfb7a 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -733,7 +733,9 @@ cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode)
 	list_for_each_entry(cfile, &cifs_inode->openFileList, flist) {
 		if (delayed_work_pending(&cfile->deferred)) {
 			if (cancel_delayed_work(&cfile->deferred)) {
+				spin_lock(&cifs_inode->deferred_lock);
 				cifs_del_deferred_close(cfile);
+				spin_unlock(&cifs_inode->deferred_lock);
 
 				tmp_list = kmalloc(sizeof(struct file_list), GFP_ATOMIC);
 				if (tmp_list == NULL)
@@ -746,7 +748,7 @@ cifs_close_deferred_file(struct cifsInodeInfo *cifs_inode)
 	spin_unlock(&cifs_inode->open_file_lock);
 
 	list_for_each_entry_safe(tmp_list, tmp_next_list, &file_head, list) {
-		_cifsFileInfo_put(tmp_list->cfile, true, false);
+		_cifsFileInfo_put(tmp_list->cfile, false, false);
 		list_del(&tmp_list->list);
 		kfree(tmp_list);
 	}
@@ -766,7 +768,9 @@ cifs_close_all_deferred_files(struct cifs_tcon *tcon)
 		cfile = list_entry(tmp, struct cifsFileInfo, tlist);
 		if (delayed_work_pending(&cfile->deferred)) {
 			if (cancel_delayed_work(&cfile->deferred)) {
+				spin_lock(&CIFS_I(d_inode(cfile->dentry))->deferred_lock);
 				cifs_del_deferred_close(cfile);
+				spin_unlock(&CIFS_I(d_inode(cfile->dentry))->deferred_lock);
 
 				tmp_list = kmalloc(sizeof(struct file_list), GFP_ATOMIC);
 				if (tmp_list == NULL)
@@ -803,7 +807,9 @@ cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon, const char *path)
 		if (strstr(full_path, path)) {
 			if (delayed_work_pending(&cfile->deferred)) {
 				if (cancel_delayed_work(&cfile->deferred)) {
+					spin_lock(&CIFS_I(d_inode(cfile->dentry))->deferred_lock);
 					cifs_del_deferred_close(cfile);
+					spin_unlock(&CIFS_I(d_inode(cfile->dentry))->deferred_lock);
 
 					tmp_list = kmalloc(sizeof(struct file_list), GFP_ATOMIC);
 					if (tmp_list == NULL)
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b77acf09726c..beadb06d8feb 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -226,7 +226,7 @@ struct erofs_inode {
 
 	unsigned char datalayout;
 	unsigned char inode_isize;
-	unsigned short xattr_isize;
+	unsigned int xattr_isize;
 
 	unsigned int xattr_shared_count;
 	unsigned int *xattr_shared_xattrs;
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 73b86b5c1a75..2c8575a8f6da 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -191,6 +191,10 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
+		if (m->clusterofs >= 1 << vi->z_logical_clusterbits) {
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
 		break;
 	default:
diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 0613dfcbfd4a..5a35768d6149 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -246,7 +246,6 @@ ext4_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	handle = ext4_journal_start(inode, EXT4_HT_XATTR, credits);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
-	ext4_fc_start_update(inode);
 
 	if ((type == ACL_TYPE_ACCESS) && acl) {
 		error = posix_acl_update_mode(mnt_userns, inode, &mode, &acl);
@@ -264,7 +263,6 @@ ext4_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	}
 out_stop:
 	ext4_journal_stop(handle);
-	ext4_fc_stop_update(inode);
 	if (error == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry;
 	return error;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index d3fae909fcbf..13497bd4e14b 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4701,8 +4701,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		     FALLOC_FL_INSERT_RANGE))
 		return -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
-
 	inode_lock(inode);
 	ret = ext4_convert_inline_data(inode);
 	inode_unlock(inode);
@@ -4772,7 +4770,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	inode_unlock(inode);
 	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
 exit:
-	ext4_fc_stop_update(inode);
 	return ret;
 }
 
@@ -5815,7 +5812,8 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
 	 * mapped - no physical clusters have been allocated, and the
 	 * file has no extents
 	 */
-	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
+	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) ||
+	    ext4_has_inline_data(inode))
 		return 0;
 
 	/* search for the extent closest to the first block in the cluster */
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 45f6d75de660..4704fe627c4e 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -259,7 +259,6 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
 	inode_lock(inode);
 	ret = ext4_write_checks(iocb, from);
 	if (ret <= 0)
@@ -271,7 +270,6 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 
 out:
 	inode_unlock(inode);
-	ext4_fc_stop_update(inode);
 	if (likely(ret > 0)) {
 		iocb->ki_pos += ret;
 		ret = generic_write_sync(iocb, ret);
@@ -558,9 +556,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out;
 		}
 
-		ext4_fc_start_update(inode);
 		ret = ext4_orphan_add(handle, inode);
-		ext4_fc_stop_update(inode);
 		if (ret) {
 			ext4_journal_stop(handle);
 			goto out;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a39d5cca4121..20b446a23e23 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3065,6 +3065,9 @@ static int ext4_da_write_end(struct file *file,
 	    ext4_has_inline_data(inode))
 		return ext4_write_inline_data_end(inode, pos, len, copied, page);
 
+	if (unlikely(copied < len) && !PageUptodate(page))
+		copied = 0;
+
 	start = pos & (PAGE_SIZE - 1);
 	end = start + copied - 1;
 
@@ -5366,7 +5369,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		if (error)
 			return error;
 	}
-	ext4_fc_start_update(inode);
+
 	if ((ia_valid & ATTR_UID && !uid_eq(attr->ia_uid, inode->i_uid)) ||
 	    (ia_valid & ATTR_GID && !gid_eq(attr->ia_gid, inode->i_gid))) {
 		handle_t *handle;
@@ -5390,7 +5393,6 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 		if (error) {
 			ext4_journal_stop(handle);
-			ext4_fc_stop_update(inode);
 			return error;
 		}
 		/* Update corresponding info in inode so that everything is in
@@ -5402,7 +5404,6 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		error = ext4_mark_inode_dirty(handle, inode);
 		ext4_journal_stop(handle);
 		if (unlikely(error)) {
-			ext4_fc_stop_update(inode);
 			return error;
 		}
 	}
@@ -5417,12 +5418,10 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 			struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 
 			if (attr->ia_size > sbi->s_bitmap_maxbytes) {
-				ext4_fc_stop_update(inode);
 				return -EFBIG;
 			}
 		}
 		if (!S_ISREG(inode->i_mode)) {
-			ext4_fc_stop_update(inode);
 			return -EINVAL;
 		}
 
@@ -5548,7 +5547,6 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		ext4_std_error(inode->i_sb, error);
 	if (!error)
 		error = rc;
-	ext4_fc_stop_update(inode);
 	return error;
 }
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 656c6ba66ca7..47ec00cfb445 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -744,7 +744,6 @@ int ext4_fileattr_set(struct user_namespace *mnt_userns,
 	u32 flags = fa->flags;
 	int err = -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
 	if (flags & ~EXT4_FL_USER_VISIBLE)
 		goto out;
 
@@ -765,7 +764,6 @@ int ext4_fileattr_set(struct user_namespace *mnt_userns,
 		goto out;
 	err = ext4_ioctl_setproject(inode, fa->fsx_projid);
 out:
-	ext4_fc_stop_update(inode);
 	return err;
 }
 
@@ -1272,13 +1270,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
-	long ret;
-
-	ext4_fc_start_update(file_inode(filp));
-	ret = __ext4_ioctl(filp, cmd, arg);
-	ext4_fc_stop_update(file_inode(filp));
-
-	return ret;
+	return __ext4_ioctl(filp, cmd, arg);
 }
 
 #ifdef CONFIG_COMPAT
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 4fa62f98cb51..455fac164fda 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1477,6 +1477,12 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		if (!PageDirty(cc->rpages[i]))
 			goto continue_unlock;
 
+		if (PageWriteback(cc->rpages[i])) {
+			if (wbc->sync_mode == WB_SYNC_NONE)
+				goto continue_unlock;
+			f2fs_wait_on_page_writeback(cc->rpages[i], DATA, true, true);
+		}
+
 		if (!clear_page_dirty_for_io(cc->rpages[i]))
 			goto continue_unlock;
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 524d4b49a520..d38bffe28b03 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -808,6 +808,8 @@ void f2fs_submit_merged_ipu_write(struct f2fs_sb_info *sbi,
 	bool found = false;
 	struct bio *target = bio ? *bio : NULL;
 
+	f2fs_bug_on(sbi, !target && !page);
+
 	for (temp = HOT; temp < NR_TEMP_TYPE && !found; temp++) {
 		struct f2fs_bio_info *io = sbi->write_io[DATA] + temp;
 		struct list_head *head = &io->bio_list;
@@ -2867,7 +2869,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 
 	if (unlikely(f2fs_cp_error(sbi))) {
 		f2fs_submit_merged_write(sbi, DATA);
-		f2fs_submit_merged_ipu_write(sbi, bio, NULL);
+		if (bio && *bio)
+			f2fs_submit_merged_ipu_write(sbi, bio, NULL);
 		submitted = NULL;
 	}
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 80e4f9afe86f..7424470c68cb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1211,7 +1211,6 @@ struct f2fs_dev_info {
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int nr_blkz;		/* Total number of zones */
 	unsigned long *blkz_seq;	/* Bitmap indicating sequential zones */
-	block_t *zone_capacity_blocks;  /* Array of zone capacity in blks */
 #endif
 };
 
@@ -1632,6 +1631,7 @@ struct f2fs_sb_info {
 	unsigned int meta_ino_num;		/* meta inode number*/
 	unsigned int log_blocks_per_seg;	/* log2 blocks per segment */
 	unsigned int blocks_per_seg;		/* blocks per segment */
+	unsigned int unusable_blocks_per_sec;	/* unusable blocks per section */
 	unsigned int segs_per_sec;		/* segments per section */
 	unsigned int secs_per_zone;		/* sections per zone */
 	unsigned int total_sections;		/* total section count */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3be34ea4e299..2c24162f72f0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2977,15 +2977,16 @@ int f2fs_transfer_project_quota(struct inode *inode, kprojid_t kprojid)
 	struct dquot *transfer_to[MAXQUOTAS] = {};
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct super_block *sb = sbi->sb;
-	int err = 0;
+	int err;
 
 	transfer_to[PRJQUOTA] = dqget(sb, make_kqid_projid(kprojid));
-	if (!IS_ERR(transfer_to[PRJQUOTA])) {
-		err = __dquot_transfer(inode, transfer_to);
-		if (err)
-			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
-		dqput(transfer_to[PRJQUOTA]);
-	}
+	if (IS_ERR(transfer_to[PRJQUOTA]))
+		return PTR_ERR(transfer_to[PRJQUOTA]);
+
+	err = __dquot_transfer(inode, transfer_to);
+	if (err)
+		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+	dqput(transfer_to[PRJQUOTA]);
 	return err;
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 58dd4de41986..79ad696cddec 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -5053,54 +5053,6 @@ int f2fs_check_write_pointer(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
-static bool is_conv_zone(struct f2fs_sb_info *sbi, unsigned int zone_idx,
-						unsigned int dev_idx)
-{
-	if (!bdev_is_zoned(FDEV(dev_idx).bdev))
-		return true;
-	return !test_bit(zone_idx, FDEV(dev_idx).blkz_seq);
-}
-
-/* Return the zone index in the given device */
-static unsigned int get_zone_idx(struct f2fs_sb_info *sbi, unsigned int secno,
-					int dev_idx)
-{
-	block_t sec_start_blkaddr = START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, secno));
-
-	return (sec_start_blkaddr - FDEV(dev_idx).start_blk) >>
-						sbi->log_blocks_per_blkz;
-}
-
-/*
- * Return the usable segments in a section based on the zone's
- * corresponding zone capacity. Zone is equal to a section.
- */
-static inline unsigned int f2fs_usable_zone_segs_in_sec(
-		struct f2fs_sb_info *sbi, unsigned int segno)
-{
-	unsigned int dev_idx, zone_idx, unusable_segs_in_sec;
-
-	dev_idx = f2fs_target_device_index(sbi, START_BLOCK(sbi, segno));
-	zone_idx = get_zone_idx(sbi, GET_SEC_FROM_SEG(sbi, segno), dev_idx);
-
-	/* Conventional zone's capacity is always equal to zone size */
-	if (is_conv_zone(sbi, zone_idx, dev_idx))
-		return sbi->segs_per_sec;
-
-	/*
-	 * If the zone_capacity_blocks array is NULL, then zone capacity
-	 * is equal to the zone size for all zones
-	 */
-	if (!FDEV(dev_idx).zone_capacity_blocks)
-		return sbi->segs_per_sec;
-
-	/* Get the segment count beyond zone capacity block */
-	unusable_segs_in_sec = (sbi->blocks_per_blkz -
-				FDEV(dev_idx).zone_capacity_blocks[zone_idx]) >>
-				sbi->log_blocks_per_seg;
-	return sbi->segs_per_sec - unusable_segs_in_sec;
-}
-
 /*
  * Return the number of usable blocks in a segment. The number of blocks
  * returned is always equal to the number of blocks in a segment for
@@ -5113,26 +5065,15 @@ static inline unsigned int f2fs_usable_zone_blks_in_seg(
 			struct f2fs_sb_info *sbi, unsigned int segno)
 {
 	block_t seg_start, sec_start_blkaddr, sec_cap_blkaddr;
-	unsigned int zone_idx, dev_idx, secno;
-
-	secno = GET_SEC_FROM_SEG(sbi, segno);
-	seg_start = START_BLOCK(sbi, segno);
-	dev_idx = f2fs_target_device_index(sbi, seg_start);
-	zone_idx = get_zone_idx(sbi, secno, dev_idx);
-
-	/*
-	 * Conventional zone's capacity is always equal to zone size,
-	 * so, blocks per segment is unchanged.
-	 */
-	if (is_conv_zone(sbi, zone_idx, dev_idx))
-		return sbi->blocks_per_seg;
+	unsigned int secno;
 
-	if (!FDEV(dev_idx).zone_capacity_blocks)
+	if (!sbi->unusable_blocks_per_sec)
 		return sbi->blocks_per_seg;
 
+	secno = GET_SEC_FROM_SEG(sbi, segno);
+	seg_start = START_BLOCK(sbi, segno);
 	sec_start_blkaddr = START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, secno));
-	sec_cap_blkaddr = sec_start_blkaddr +
-				FDEV(dev_idx).zone_capacity_blocks[zone_idx];
+	sec_cap_blkaddr = sec_start_blkaddr + CAP_BLKS_PER_SEC(sbi);
 
 	/*
 	 * If segment starts before zone capacity and spans beyond
@@ -5164,11 +5105,6 @@ static inline unsigned int f2fs_usable_zone_blks_in_seg(struct f2fs_sb_info *sbi
 	return 0;
 }
 
-static inline unsigned int f2fs_usable_zone_segs_in_sec(struct f2fs_sb_info *sbi,
-							unsigned int segno)
-{
-	return 0;
-}
 #endif
 unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
 					unsigned int segno)
@@ -5183,7 +5119,7 @@ unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
 					unsigned int segno)
 {
 	if (f2fs_sb_has_blkzoned(sbi))
-		return f2fs_usable_zone_segs_in_sec(sbi, segno);
+		return CAP_SEGS_PER_SEC(sbi);
 
 	return sbi->segs_per_sec;
 }
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 957edb6d70d7..04f448ddf49e 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -101,6 +101,12 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 		GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
 #define BLKS_PER_SEC(sbi)					\
 	((sbi)->segs_per_sec * (sbi)->blocks_per_seg)
+#define CAP_BLKS_PER_SEC(sbi)					\
+	((sbi)->segs_per_sec * (sbi)->blocks_per_seg -		\
+	 (sbi)->unusable_blocks_per_sec)
+#define CAP_SEGS_PER_SEC(sbi)					\
+	((sbi)->segs_per_sec - ((sbi)->unusable_blocks_per_sec >>\
+	(sbi)->log_blocks_per_seg))
 #define GET_SEC_FROM_SEG(sbi, segno)				\
 	(((segno) == -1) ? -1: (segno) / (sbi)->segs_per_sec)
 #define GET_SEG_FROM_SEC(sbi, secno)				\
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ae72211e422e..4cc9b948139a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1515,7 +1515,6 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 		blkdev_put(FDEV(i).bdev, FMODE_EXCL);
 #ifdef CONFIG_BLK_DEV_ZONED
 		kvfree(FDEV(i).blkz_seq);
-		kfree(FDEV(i).zone_capacity_blocks);
 #endif
 	}
 	kvfree(sbi->devs);
@@ -3631,24 +3630,29 @@ static int init_percpu_info(struct f2fs_sb_info *sbi)
 #ifdef CONFIG_BLK_DEV_ZONED
 
 struct f2fs_report_zones_args {
+	struct f2fs_sb_info *sbi;
 	struct f2fs_dev_info *dev;
-	bool zone_cap_mismatch;
 };
 
 static int f2fs_report_zone_cb(struct blk_zone *zone, unsigned int idx,
 			      void *data)
 {
 	struct f2fs_report_zones_args *rz_args = data;
+	block_t unusable_blocks = (zone->len - zone->capacity) >>
+					F2FS_LOG_SECTORS_PER_BLOCK;
 
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return 0;
 
 	set_bit(idx, rz_args->dev->blkz_seq);
-	rz_args->dev->zone_capacity_blocks[idx] = zone->capacity >>
-						F2FS_LOG_SECTORS_PER_BLOCK;
-	if (zone->len != zone->capacity && !rz_args->zone_cap_mismatch)
-		rz_args->zone_cap_mismatch = true;
-
+	if (!rz_args->sbi->unusable_blocks_per_sec) {
+		rz_args->sbi->unusable_blocks_per_sec = unusable_blocks;
+		return 0;
+	}
+	if (rz_args->sbi->unusable_blocks_per_sec != unusable_blocks) {
+		f2fs_err(rz_args->sbi, "F2FS supports single zone capacity\n");
+		return -EINVAL;
+	}
 	return 0;
 }
 
@@ -3682,26 +3686,13 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	if (!FDEV(devi).blkz_seq)
 		return -ENOMEM;
 
-	/* Get block zones type and zone-capacity */
-	FDEV(devi).zone_capacity_blocks = f2fs_kzalloc(sbi,
-					FDEV(devi).nr_blkz * sizeof(block_t),
-					GFP_KERNEL);
-	if (!FDEV(devi).zone_capacity_blocks)
-		return -ENOMEM;
-
+	rep_zone_arg.sbi = sbi;
 	rep_zone_arg.dev = &FDEV(devi);
-	rep_zone_arg.zone_cap_mismatch = false;
 
 	ret = blkdev_report_zones(bdev, 0, BLK_ALL_ZONES, f2fs_report_zone_cb,
 				  &rep_zone_arg);
 	if (ret < 0)
 		return ret;
-
-	if (!rep_zone_arg.zone_cap_mismatch) {
-		kfree(FDEV(devi).zone_capacity_blocks);
-		FDEV(devi).zone_capacity_blocks = NULL;
-	}
-
 	return 0;
 }
 #endif
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index f4a5a0c2858a..fbc3f0ef38c0 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1009,6 +1009,16 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 			continue;
 		}
 
+		/*
+		 * If wb_tryget fails, the wb has been shutdown, skip it.
+		 *
+		 * Pin @wb so that it stays on @bdi->wb_list.  This allows
+		 * continuing iteration from @wb after dropping and
+		 * regrabbing rcu read lock.
+		 */
+		if (!wb_tryget(wb))
+			continue;
+
 		/* alloc failed, execute synchronously using on-stack fallback */
 		work = &fallback_work;
 		*work = *base_work;
@@ -1017,13 +1027,6 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 		work->done = &fallback_work_done;
 
 		wb_queue_work(wb, work);
-
-		/*
-		 * Pin @wb so that it stays on @bdi->wb_list.  This allows
-		 * continuing iteration from @wb after dropping and
-		 * regrabbing rcu read lock.
-		 */
-		wb_get(wb);
 		last_wb = wb;
 
 		rcu_read_unlock();
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 097ba728d516..580d2fdfe21f 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -757,6 +757,7 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
 	}
 	journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
 	write_unlock(&journal->j_state_lock);
+	jbd2_journal_lock_updates(journal);
 
 	return 0;
 }
@@ -768,6 +769,7 @@ EXPORT_SYMBOL(jbd2_fc_begin_commit);
  */
 static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
 {
+	jbd2_journal_unlock_updates(journal);
 	if (journal->j_fc_cleanup_callback)
 		journal->j_fc_cleanup_callback(journal, 0, tid);
 	write_lock(&journal->j_state_lock);
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 55232064cab2..ce4a5ccadeff 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2378,6 +2378,9 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
 			spin_unlock(&jh->b_state_lock);
 			write_unlock(&journal->j_state_lock);
 			jbd2_journal_put_journal_head(jh);
+			/* Already zapped buffer? Nothing to do... */
+			if (!bh->b_bdev)
+				return 0;
 			return -EBUSY;
 		}
 		/*
diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index 976d09aaee70..1c5e7e023058 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -611,6 +611,7 @@ static int __init ksmbd_server_init(void)
 static void __exit ksmbd_server_exit(void)
 {
 	ksmbd_server_shutdown();
+	rcu_barrier();
 	ksmbd_release_inode_hash();
 }
 
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 1cd6170b9a5c..22d9fcb5f7ca 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1786,6 +1786,10 @@ int smb2_sess_setup(struct ksmbd_work *work)
 				}
 				kfree(sess->Preauth_HashValue);
 				sess->Preauth_HashValue = NULL;
+			} else {
+				pr_info_ratelimited("Unknown NTLMSSP message type : 0x%x\n",
+						le32_to_cpu(negblob->MessageType));
+				rc = -EINVAL;
 			}
 		} else {
 			/* TODO: need one more negotiation */
@@ -4879,6 +4883,9 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 	int rc = 0, len;
 	int fs_infoclass_size = 0;
 
+	if (!share->path)
+		return -EIO;
+
 	rc = kern_path(share->path, LOOKUP_NO_SYMLINKS, &path);
 	if (rc) {
 		pr_err("cannot create vfs path\n");
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 7223816bc5d5..15ba6ad1c571 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -67,6 +67,8 @@
 
 #define OPENOWNER_POOL_SIZE	8
 
+static void nfs4_state_start_reclaim_reboot(struct nfs_client *clp);
+
 const nfs4_stateid zero_stateid = {
 	{ .data = { 0 } },
 	.type = NFS4_SPECIAL_STATEID_TYPE,
@@ -330,6 +332,8 @@ int nfs41_init_clientid(struct nfs_client *clp, const struct cred *cred)
 	status = nfs4_proc_create_session(clp, cred);
 	if (status != 0)
 		goto out;
+	if (!(clp->cl_exchange_flags & EXCHGID4_FLAG_CONFIRMED_R))
+		nfs4_state_start_reclaim_reboot(clp);
 	nfs41_finish_session_reset(clp);
 	nfs_mark_client_ready(clp, NFS_CS_READY);
 out:
diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
index 5900879d5693..8ebb69c4ad18 100644
--- a/fs/nilfs2/bmap.c
+++ b/fs/nilfs2/bmap.c
@@ -67,20 +67,28 @@ int nilfs_bmap_lookup_at_level(struct nilfs_bmap *bmap, __u64 key, int level,
 
 	down_read(&bmap->b_sem);
 	ret = bmap->b_ops->bop_lookup(bmap, key, level, ptrp);
-	if (ret < 0) {
-		ret = nilfs_bmap_convert_error(bmap, __func__, ret);
+	if (ret < 0)
 		goto out;
-	}
+
 	if (NILFS_BMAP_USE_VBN(bmap)) {
 		ret = nilfs_dat_translate(nilfs_bmap_get_dat(bmap), *ptrp,
 					  &blocknr);
 		if (!ret)
 			*ptrp = blocknr;
+		else if (ret == -ENOENT) {
+			/*
+			 * If there was no valid entry in DAT for the block
+			 * address obtained by b_ops->bop_lookup, then pass
+			 * internal code -EINVAL to nilfs_bmap_convert_error
+			 * to treat it as metadata corruption.
+			 */
+			ret = -EINVAL;
+		}
 	}
 
  out:
 	up_read(&bmap->b_sem);
-	return ret;
+	return nilfs_bmap_convert_error(bmap, __func__, ret);
 }
 
 int nilfs_bmap_lookup_contig(struct nilfs_bmap *bmap, __u64 key, __u64 *ptrp,
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index da233ab435ce..c25f28094508 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2039,6 +2039,9 @@ static int nilfs_segctor_do_construct(struct nilfs_sc_info *sci, int mode)
 	struct the_nilfs *nilfs = sci->sc_super->s_fs_info;
 	int err;
 
+	if (sb_rdonly(sci->sc_super))
+		return -EROFS;
+
 	nilfs_sc_cstage_set(sci, NILFS_ST_INIT);
 	sci->sc_cno = nilfs->ns_cno;
 
@@ -2724,7 +2727,7 @@ static void nilfs_segctor_write_out(struct nilfs_sc_info *sci)
 
 		flush_work(&sci->sc_iput_work);
 
-	} while (ret && retrycount-- > 0);
+	} while (ret && ret != -EROFS && retrycount-- > 0);
 }
 
 /**
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 20abdb268286..59f813cbdaa8 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -2575,7 +2575,7 @@ static int read_next_log_rec(struct ntfs_log *log, struct lcb *lcb, u64 *lsn)
 	return find_log_rec(log, *lsn, lcb);
 }
 
-static inline bool check_index_header(const struct INDEX_HDR *hdr, size_t bytes)
+bool check_index_header(const struct INDEX_HDR *hdr, size_t bytes)
 {
 	__le16 mask;
 	u32 min_de, de_off, used, total;
@@ -4256,6 +4256,10 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	rec_len -= t32;
 
 	attr_names = kmemdup(Add2Ptr(lrh, t32), rec_len, GFP_NOFS);
+	if (!attr_names) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	lcb_put(lcb);
 	lcb = NULL;
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 99f8a57e9f7a..f62e0df7a7b4 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -679,9 +679,13 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 	u32 e_size, e_key_len;
 	u32 end = le32_to_cpu(hdr->used);
 	u32 off = le32_to_cpu(hdr->de_off);
+	u32 total = le32_to_cpu(hdr->total);
 	u16 offs[128];
 
 fill_table:
+	if (end > total)
+		return NULL;
+
 	if (off + sizeof(struct NTFS_DE) > end)
 		return NULL;
 
@@ -798,6 +802,10 @@ static inline struct NTFS_DE *hdr_delete_de(struct INDEX_HDR *hdr,
 	u32 off = PtrOffset(hdr, re);
 	int bytes = used - (off + esize);
 
+	/* check INDEX_HDR valid before using INDEX_HDR */
+	if (!check_index_header(hdr, le32_to_cpu(hdr->total)))
+		return NULL;
+
 	if (off >= used || esize < sizeof(struct NTFS_DE) ||
 	    bytes < sizeof(struct NTFS_DE))
 		return NULL;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 136236a25da6..359eff346910 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -257,7 +257,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 			goto out;
 
 		root = Add2Ptr(attr, roff);
-		is_root = true;
 
 		if (attr->name_len != ARRAY_SIZE(I30_NAME) ||
 		    memcmp(attr_name(attr), I30_NAME, sizeof(I30_NAME)))
@@ -270,6 +269,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		if (!is_dir)
 			goto next_attr;
 
+		is_root = true;
 		ni->ni_flags |= NI_FLAG_DIR;
 
 		err = indx_init(&ni->dir, sbi, attr, INDEX_MUTEX_I30);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 8aaec7e0804e..e571e7643596 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -575,6 +575,7 @@ int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
 bool ni_is_dirty(struct inode *inode);
 
 /* Globals from fslog.c */
+bool check_index_header(const struct INDEX_HDR *hdr, size_t bytes);
 int log_replay(struct ntfs_inode *ni, bool *initialized);
 
 /* Globals from fsntfs.c */
diff --git a/fs/pstore/pmsg.c b/fs/pstore/pmsg.c
index 18cf94b597e0..d8542ec2f38c 100644
--- a/fs/pstore/pmsg.c
+++ b/fs/pstore/pmsg.c
@@ -7,10 +7,9 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
-#include <linux/rtmutex.h>
 #include "internal.h"
 
-static DEFINE_RT_MUTEX(pmsg_lock);
+static DEFINE_MUTEX(pmsg_lock);
 
 static ssize_t write_pmsg(struct file *file, const char __user *buf,
 			  size_t count, loff_t *ppos)
@@ -29,9 +28,9 @@ static ssize_t write_pmsg(struct file *file, const char __user *buf,
 	if (!access_ok(buf, count))
 		return -EFAULT;
 
-	rt_mutex_lock(&pmsg_lock);
+	mutex_lock(&pmsg_lock);
 	ret = psinfo->write_user(&record, buf);
-	rt_mutex_unlock(&pmsg_lock);
+	mutex_unlock(&pmsg_lock);
 	return ret ? ret : count;
 }
 
diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
index 857a65b05726..157ebfe2456b 100644
--- a/fs/reiserfs/xattr_security.c
+++ b/fs/reiserfs/xattr_security.c
@@ -82,11 +82,15 @@ int reiserfs_security_write(struct reiserfs_transaction_handle *th,
 			    struct inode *inode,
 			    struct reiserfs_security_handle *sec)
 {
+	char xattr_name[XATTR_NAME_MAX + 1] = XATTR_SECURITY_PREFIX;
 	int error;
-	if (strlen(sec->name) < sizeof(XATTR_SECURITY_PREFIX))
+
+	if (XATTR_SECURITY_PREFIX_LEN + strlen(sec->name) > XATTR_NAME_MAX)
 		return -EINVAL;
 
-	error = reiserfs_xattr_set_handle(th, inode, sec->name, sec->value,
+	strlcat(xattr_name, sec->name, sizeof(xattr_name));
+
+	error = reiserfs_xattr_set_handle(th, inode, xattr_name, sec->value,
 					  sec->length, XATTR_CREATE);
 	if (error == -ENODATA || error == -EOPNOTSUPP)
 		error = 0;
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index e7c36e3a9b9e..7717d23906db 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -488,6 +488,7 @@ static int ubifs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	unlock_2_inodes(dir, inode);
 
 	ubifs_release_budget(c, &req);
+	fscrypt_free_filename(&nm);
 
 	return 0;
 
diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index 2469f72eeaab..6b7d95b65f4b 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -44,6 +44,33 @@ enum {
 	NOT_ON_MEDIA = 3,
 };
 
+static void do_insert_old_idx(struct ubifs_info *c,
+			      struct ubifs_old_idx *old_idx)
+{
+	struct ubifs_old_idx *o;
+	struct rb_node **p, *parent = NULL;
+
+	p = &c->old_idx.rb_node;
+	while (*p) {
+		parent = *p;
+		o = rb_entry(parent, struct ubifs_old_idx, rb);
+		if (old_idx->lnum < o->lnum)
+			p = &(*p)->rb_left;
+		else if (old_idx->lnum > o->lnum)
+			p = &(*p)->rb_right;
+		else if (old_idx->offs < o->offs)
+			p = &(*p)->rb_left;
+		else if (old_idx->offs > o->offs)
+			p = &(*p)->rb_right;
+		else {
+			ubifs_err(c, "old idx added twice!");
+			kfree(old_idx);
+		}
+	}
+	rb_link_node(&old_idx->rb, parent, p);
+	rb_insert_color(&old_idx->rb, &c->old_idx);
+}
+
 /**
  * insert_old_idx - record an index node obsoleted since the last commit start.
  * @c: UBIFS file-system description object
@@ -69,35 +96,15 @@ enum {
  */
 static int insert_old_idx(struct ubifs_info *c, int lnum, int offs)
 {
-	struct ubifs_old_idx *old_idx, *o;
-	struct rb_node **p, *parent = NULL;
+	struct ubifs_old_idx *old_idx;
 
 	old_idx = kmalloc(sizeof(struct ubifs_old_idx), GFP_NOFS);
 	if (unlikely(!old_idx))
 		return -ENOMEM;
 	old_idx->lnum = lnum;
 	old_idx->offs = offs;
+	do_insert_old_idx(c, old_idx);
 
-	p = &c->old_idx.rb_node;
-	while (*p) {
-		parent = *p;
-		o = rb_entry(parent, struct ubifs_old_idx, rb);
-		if (lnum < o->lnum)
-			p = &(*p)->rb_left;
-		else if (lnum > o->lnum)
-			p = &(*p)->rb_right;
-		else if (offs < o->offs)
-			p = &(*p)->rb_left;
-		else if (offs > o->offs)
-			p = &(*p)->rb_right;
-		else {
-			ubifs_err(c, "old idx added twice!");
-			kfree(old_idx);
-			return 0;
-		}
-	}
-	rb_link_node(&old_idx->rb, parent, p);
-	rb_insert_color(&old_idx->rb, &c->old_idx);
 	return 0;
 }
 
@@ -199,23 +206,6 @@ static struct ubifs_znode *copy_znode(struct ubifs_info *c,
 	__set_bit(DIRTY_ZNODE, &zn->flags);
 	__clear_bit(COW_ZNODE, &zn->flags);
 
-	ubifs_assert(c, !ubifs_zn_obsolete(znode));
-	__set_bit(OBSOLETE_ZNODE, &znode->flags);
-
-	if (znode->level != 0) {
-		int i;
-		const int n = zn->child_cnt;
-
-		/* The children now have new parent */
-		for (i = 0; i < n; i++) {
-			struct ubifs_zbranch *zbr = &zn->zbranch[i];
-
-			if (zbr->znode)
-				zbr->znode->parent = zn;
-		}
-	}
-
-	atomic_long_inc(&c->dirty_zn_cnt);
 	return zn;
 }
 
@@ -233,6 +223,42 @@ static int add_idx_dirt(struct ubifs_info *c, int lnum, int dirt)
 	return ubifs_add_dirt(c, lnum, dirt);
 }
 
+/**
+ * replace_znode - replace old znode with new znode.
+ * @c: UBIFS file-system description object
+ * @new_zn: new znode
+ * @old_zn: old znode
+ * @zbr: the branch of parent znode
+ *
+ * Replace old znode with new znode in TNC.
+ */
+static void replace_znode(struct ubifs_info *c, struct ubifs_znode *new_zn,
+			  struct ubifs_znode *old_zn, struct ubifs_zbranch *zbr)
+{
+	ubifs_assert(c, !ubifs_zn_obsolete(old_zn));
+	__set_bit(OBSOLETE_ZNODE, &old_zn->flags);
+
+	if (old_zn->level != 0) {
+		int i;
+		const int n = new_zn->child_cnt;
+
+		/* The children now have new parent */
+		for (i = 0; i < n; i++) {
+			struct ubifs_zbranch *child = &new_zn->zbranch[i];
+
+			if (child->znode)
+				child->znode->parent = new_zn;
+		}
+	}
+
+	zbr->znode = new_zn;
+	zbr->lnum = 0;
+	zbr->offs = 0;
+	zbr->len = 0;
+
+	atomic_long_inc(&c->dirty_zn_cnt);
+}
+
 /**
  * dirty_cow_znode - ensure a znode is not being committed.
  * @c: UBIFS file-system description object
@@ -265,28 +291,32 @@ static struct ubifs_znode *dirty_cow_znode(struct ubifs_info *c,
 		return zn;
 
 	if (zbr->len) {
-		err = insert_old_idx(c, zbr->lnum, zbr->offs);
-		if (unlikely(err))
-			/*
-			 * Obsolete znodes will be freed by tnc_destroy_cnext()
-			 * or free_obsolete_znodes(), copied up znodes should
-			 * be added back to tnc and freed by
-			 * ubifs_destroy_tnc_subtree().
-			 */
+		struct ubifs_old_idx *old_idx;
+
+		old_idx = kmalloc(sizeof(struct ubifs_old_idx), GFP_NOFS);
+		if (unlikely(!old_idx)) {
+			err = -ENOMEM;
 			goto out;
+		}
+		old_idx->lnum = zbr->lnum;
+		old_idx->offs = zbr->offs;
+
 		err = add_idx_dirt(c, zbr->lnum, zbr->len);
-	} else
-		err = 0;
+		if (err) {
+			kfree(old_idx);
+			goto out;
+		}
 
-out:
-	zbr->znode = zn;
-	zbr->lnum = 0;
-	zbr->offs = 0;
-	zbr->len = 0;
+		do_insert_old_idx(c, old_idx);
+	}
+
+	replace_znode(c, zn, znode, zbr);
 
-	if (unlikely(err))
-		return ERR_PTR(err);
 	return zn;
+
+out:
+	kfree(zn);
+	return ERR_PTR(err);
 }
 
 /**
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 04e2a57313fa..26dd9ceb44b4 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -72,7 +72,8 @@ xfs_sb_validate_v5_features(
 }
 
 /*
- * We support all XFS versions newer than a v4 superblock with V2 directories.
+ * We current support XFS v5 formats with known features and v4 superblocks with
+ * at least V2 directories.
  */
 bool
 xfs_sb_good_version(
@@ -86,16 +87,16 @@ xfs_sb_good_version(
 	if (xfs_sb_is_v5(sbp))
 		return xfs_sb_validate_v5_features(sbp);
 
+	/* versions prior to v4 are not supported */
+	if (XFS_SB_VERSION_NUM(sbp) != XFS_SB_VERSION_4)
+		return false;
+
 	/* We must not have any unknown v4 feature bits set */
 	if ((sbp->sb_versionnum & ~XFS_SB_VERSION_OKBITS) ||
 	    ((sbp->sb_versionnum & XFS_SB_VERSION_MOREBITSBIT) &&
 	     (sbp->sb_features2 & ~XFS_SB_VERSION2_OKBITS)))
 		return false;
 
-	/* versions prior to v4 are not supported */
-	if (XFS_SB_VERSION_NUM(sbp) < XFS_SB_VERSION_4)
-		return false;
-
 	/* V4 filesystems need v2 directories and unwritten extents */
 	if (!(sbp->sb_versionnum & XFS_SB_VERSION_DIRV2BIT))
 		return false;
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 98954dda5734..82f2c01accbb 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -190,7 +190,7 @@ static inline u64 readq(const volatile void __iomem *addr)
 	u64 val;
 
 	__io_br();
-	val = __le64_to_cpu(__raw_readq(addr));
+	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
 	__io_ar(val);
 	return val;
 }
@@ -233,7 +233,7 @@ static inline void writel(u32 value, volatile void __iomem *addr)
 static inline void writeq(u64 value, volatile void __iomem *addr)
 {
 	__io_bw();
-	__raw_writeq(__cpu_to_le64(value), addr);
+	__raw_writeq((u64 __force)__cpu_to_le64(value), addr);
 	__io_aw();
 }
 #endif
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index 69b24fe92cbf..5e96bad54804 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -97,8 +97,8 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
 int blk_crypto_start_using_key(const struct blk_crypto_key *key,
 			       struct request_queue *q);
 
-int blk_crypto_evict_key(struct request_queue *q,
-			 const struct blk_crypto_key *key);
+void blk_crypto_evict_key(struct request_queue *q,
+			  const struct blk_crypto_key *key);
 
 bool blk_crypto_config_supported(struct request_queue *q,
 				 const struct blk_crypto_config *cfg);
diff --git a/include/linux/mailbox/zynqmp-ipi-message.h b/include/linux/mailbox/zynqmp-ipi-message.h
index 35ce84c8ca02..31d8046d945e 100644
--- a/include/linux/mailbox/zynqmp-ipi-message.h
+++ b/include/linux/mailbox/zynqmp-ipi-message.h
@@ -9,7 +9,7 @@
  * @data: message payload
  *
  * This is the structure for data used in mbox_send_message
- * the maximum length of data buffer is fixed to 12 bytes.
+ * the maximum length of data buffer is fixed to 32 bytes.
  * Client is supposed to be aware of this.
  */
 struct zynqmp_ipi_message {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 49ea0004109e..442b6ac8a66c 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -8508,7 +8508,8 @@ struct mlx5_ifc_alloc_flow_counter_in_bits {
 	u8         reserved_at_20[0x10];
 	u8         op_mod[0x10];
 
-	u8         reserved_at_40[0x38];
+	u8         reserved_at_40[0x33];
+	u8         flow_counter_bulk_log_size[0x5];
 	u8         flow_counter_bulk[0x8];
 };
 
diff --git a/include/linux/netfilter/nfnetlink.h b/include/linux/netfilter/nfnetlink.h
index 241e005f290a..e9a9ab34a7cc 100644
--- a/include/linux/netfilter/nfnetlink.h
+++ b/include/linux/netfilter/nfnetlink.h
@@ -45,7 +45,6 @@ struct nfnetlink_subsystem {
 	int (*commit)(struct net *net, struct sk_buff *skb);
 	int (*abort)(struct net *net, struct sk_buff *skb,
 		     enum nfnl_abort_action action);
-	void (*cleanup)(struct net *net);
 	bool (*valid_genid)(struct net *net, u32 genid);
 };
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index de235916c31c..461ee0ee59fe 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -613,6 +613,10 @@ enum {
 	NVME_AER_VS			= 7,
 };
 
+enum {
+	NVME_AER_ERROR_PERSIST_INT_ERR	= 0x03,
+};
+
 enum {
 	NVME_AER_NOTICE_NS_CHANGED	= 0x00,
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 7c96f169d274..8aefdc0099c8 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -203,7 +203,18 @@ extern void platform_device_put(struct platform_device *pdev);
 
 struct platform_driver {
 	int (*probe)(struct platform_device *);
+
+	/*
+	 * Traditionally the remove callback returned an int which however is
+	 * ignored by the driver core. This led to wrong expectations by driver
+	 * authors who thought returning an error code was a valid error
+	 * handling strategy. To convert to a callback returning void, new
+	 * drivers should implement .remove_new() until the conversion it done
+	 * that eventually makes .remove() return void.
+	 */
 	int (*remove)(struct platform_device *);
+	void (*remove_new)(struct platform_device *);
+
 	void (*shutdown)(struct platform_device *);
 	int (*suspend)(struct platform_device *, pm_message_t state);
 	int (*resume)(struct platform_device *);
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 5bbcd280bfd2..65d5759be156 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -4,6 +4,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/alarmtimer.h>
 #include <linux/timerqueue.h>
 #include <linux/task_work.h>
@@ -63,16 +64,18 @@ static inline int clockid_to_fd(const clockid_t clk)
  * cpu_timer - Posix CPU timer representation for k_itimer
  * @node:	timerqueue node to queue in the task/sig
  * @head:	timerqueue head on which this timer is queued
- * @task:	Pointer to target task
+ * @pid:	Pointer to target task PID
  * @elist:	List head for the expiry list
  * @firing:	Timer is currently firing
+ * @handling:	Pointer to the task which handles expiry
  */
 struct cpu_timer {
-	struct timerqueue_node	node;
-	struct timerqueue_head	*head;
-	struct pid		*pid;
-	struct list_head	elist;
-	int			firing;
+	struct timerqueue_node		node;
+	struct timerqueue_head		*head;
+	struct pid			*pid;
+	struct list_head		elist;
+	int				firing;
+	struct task_struct __rcu	*handling;
 };
 
 static inline bool cpu_timer_enqueue(struct timerqueue_head *head,
@@ -136,10 +139,12 @@ struct posix_cputimers {
 /**
  * posix_cputimers_work - Container for task work based posix CPU timer expiry
  * @work:	The task work to be scheduled
+ * @mutex:	Mutex held around expiry in context of this task work
  * @scheduled:  @work has been scheduled already, no further processing
  */
 struct posix_cputimers_work {
 	struct callback_head	work;
+	struct mutex		mutex;
 	unsigned int		scheduled;
 };
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e418935f8db6..7c17742d359c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -522,7 +522,7 @@ struct sched_statistics {
 	u64				nr_wakeups_passive;
 	u64				nr_wakeups_idle;
 #endif
-};
+} ____cacheline_aligned;
 
 struct sched_entity {
 	/* For load-balancing: */
@@ -538,8 +538,6 @@ struct sched_entity {
 
 	u64				nr_migrations;
 
-	struct sched_statistics		statistics;
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	int				depth;
 	struct sched_entity		*parent;
@@ -803,6 +801,8 @@ struct task_struct {
 	struct uclamp_se		uclamp[UCLAMP_CNT];
 #endif
 
+	struct sched_statistics         stats;
+
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	/* List of struct preempt_notifier: */
 	struct hlist_head		preempt_notifiers;
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index a237b8dbf608..ba047a145e09 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -90,8 +90,7 @@ struct rpc_task {
 #endif
 	unsigned char		tk_priority : 2,/* Task priority */
 				tk_garb_retry : 2,
-				tk_cred_retry : 2,
-				tk_rebind_retry : 2;
+				tk_cred_retry : 2;
 };
 
 typedef void			(*rpc_action)(struct rpc_task *);
diff --git a/include/linux/tick.h b/include/linux/tick.h
index bfd571f18cfd..9459fef5b857 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -216,6 +216,7 @@ extern void tick_nohz_dep_set_signal(struct task_struct *tsk,
 				     enum tick_dep_bits bit);
 extern void tick_nohz_dep_clear_signal(struct signal_struct *signal,
 				       enum tick_dep_bits bit);
+extern bool tick_nohz_cpu_hotpluggable(unsigned int cpu);
 
 /*
  * The below are tick_nohz_[set,clear]_dep() wrappers that optimize off-cases
@@ -280,6 +281,7 @@ static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask) { }
 
 static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
 static inline void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit) { }
+static inline bool tick_nohz_cpu_hotpluggable(unsigned int cpu) { return true; }
 
 static inline void tick_dep_set(enum tick_dep_bits bit) { }
 static inline void tick_dep_clear(enum tick_dep_bits bit) { }
diff --git a/include/linux/vt_buffer.h b/include/linux/vt_buffer.h
index 848db1b1569f..919d999a8c1d 100644
--- a/include/linux/vt_buffer.h
+++ b/include/linux/vt_buffer.h
@@ -16,7 +16,7 @@
 
 #include <linux/string.h>
 
-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
+#if IS_ENABLED(CONFIG_VGA_CONSOLE) || IS_ENABLED(CONFIG_MDA_CONSOLE)
 #include <asm/vga.h>
 #endif
 
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 74d3c1efd9bb..7fee9b6cfede 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -469,7 +469,8 @@ extern bool workqueue_congested(int cpu, struct workqueue_struct *wq);
 extern unsigned int work_busy(struct work_struct *work);
 extern __printf(1, 2) void set_worker_desc(const char *fmt, ...);
 extern void print_worker_info(const char *log_lvl, struct task_struct *task);
-extern void show_workqueue_state(void);
+extern void show_all_workqueues(void);
+extern void show_one_workqueue(struct workqueue_struct *wq);
 extern void wq_worker_comm(char *buf, size_t size, struct task_struct *task);
 
 /**
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 8def00a04541..22f67ae935e0 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -584,6 +584,7 @@ struct nft_set_binding {
 };
 
 enum nft_trans_phase;
+void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set);
 void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      struct nft_set_binding *binding,
 			      enum nft_trans_phase phase);
diff --git a/include/net/scm.h b/include/net/scm.h
index 1ce365f4c256..585adc1346bd 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -105,16 +105,27 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 		}
 	}
 }
+
+static inline bool scm_has_secdata(struct socket *sock)
+{
+	return test_bit(SOCK_PASSSEC, &sock->flags);
+}
 #else
 static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm)
 { }
+
+static inline bool scm_has_secdata(struct socket *sock)
+{
+	return false;
+}
 #endif /* CONFIG_SECURITY_NETWORK */
 
 static __inline__ void scm_recv(struct socket *sock, struct msghdr *msg,
 				struct scm_cookie *scm, int flags)
 {
 	if (!msg->msg_control) {
-		if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp)
+		if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp ||
+		    scm_has_secdata(sock))
 			msg->msg_flags |= MSG_CTRUNC;
 		scm_destroy(scm);
 		return;
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 7517f4faf6b3..ebd1f43578d6 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -152,13 +152,8 @@ static inline bool xp_desc_crosses_non_contig_pg(struct xsk_buff_pool *pool,
 	if (likely(!cross_pg))
 		return false;
 
-	if (pool->dma_pages_cnt) {
-		return !(pool->dma_pages[addr >> PAGE_SHIFT] &
-			 XSK_NEXT_PG_CONTIG_MASK);
-	}
-
-	/* skb path */
-	return addr + len > pool->addrs_cnt;
+	return pool->dma_pages_cnt &&
+	       !(pool->dma_pages[addr >> PAGE_SHIFT] & XSK_NEXT_PG_CONTIG_MASK);
 }
 
 static inline u64 xp_aligned_extract_addr(struct xsk_buff_pool *pool, u64 addr)
diff --git a/include/target/target_core_base.h b/include/target/target_core_base.h
index 2121a323fd6c..c83bb58bfcd1 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -865,6 +865,7 @@ struct se_device {
 	struct rcu_head		rcu_head;
 	int			queue_cnt;
 	struct se_device_queue	*queues;
+	struct mutex		lun_reset_mutex;
 };
 
 struct se_hba {
diff --git a/include/trace/events/qrtr.h b/include/trace/events/qrtr.h
index b1de14c3bb93..441132c67133 100644
--- a/include/trace/events/qrtr.h
+++ b/include/trace/events/qrtr.h
@@ -10,15 +10,16 @@
 
 TRACE_EVENT(qrtr_ns_service_announce_new,
 
-	TP_PROTO(__le32 service, __le32 instance, __le32 node, __le32 port),
+	TP_PROTO(unsigned int service, unsigned int instance,
+		 unsigned int node, unsigned int port),
 
 	TP_ARGS(service, instance, node, port),
 
 	TP_STRUCT__entry(
-		__field(__le32, service)
-		__field(__le32, instance)
-		__field(__le32, node)
-		__field(__le32, port)
+		__field(unsigned int, service)
+		__field(unsigned int, instance)
+		__field(unsigned int, node)
+		__field(unsigned int, port)
 	),
 
 	TP_fast_assign(
@@ -36,15 +37,16 @@ TRACE_EVENT(qrtr_ns_service_announce_new,
 
 TRACE_EVENT(qrtr_ns_service_announce_del,
 
-	TP_PROTO(__le32 service, __le32 instance, __le32 node, __le32 port),
+	TP_PROTO(unsigned int service, unsigned int instance,
+		 unsigned int node, unsigned int port),
 
 	TP_ARGS(service, instance, node, port),
 
 	TP_STRUCT__entry(
-		__field(__le32, service)
-		__field(__le32, instance)
-		__field(__le32, node)
-		__field(__le32, port)
+		__field(unsigned int, service)
+		__field(unsigned int, instance)
+		__field(unsigned int, node)
+		__field(unsigned int, port)
 	),
 
 	TP_fast_assign(
@@ -62,15 +64,16 @@ TRACE_EVENT(qrtr_ns_service_announce_del,
 
 TRACE_EVENT(qrtr_ns_server_add,
 
-	TP_PROTO(__le32 service, __le32 instance, __le32 node, __le32 port),
+	TP_PROTO(unsigned int service, unsigned int instance,
+		 unsigned int node, unsigned int port),
 
 	TP_ARGS(service, instance, node, port),
 
 	TP_STRUCT__entry(
-		__field(__le32, service)
-		__field(__le32, instance)
-		__field(__le32, node)
-		__field(__le32, port)
+		__field(unsigned int, service)
+		__field(unsigned int, instance)
+		__field(unsigned int, node)
+		__field(unsigned int, port)
 	),
 
 	TP_fast_assign(
diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 6ad031c71be7..1cf012de6442 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -368,7 +368,8 @@ TRACE_EVENT(itimer_expire,
 		tick_dep_name(PERF_EVENTS)		\
 		tick_dep_name(SCHED)			\
 		tick_dep_name(CLOCK_UNSTABLE)		\
-		tick_dep_name_end(RCU)
+		tick_dep_name(RCU)			\
+		tick_dep_name_end(RCU_EXP)
 
 #undef tick_dep_name
 #undef tick_dep_mask_name
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index d7d3cfead056..5f4513f2d41d 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -181,6 +181,7 @@ struct btrfs_scrub_progress {
 };
 
 #define BTRFS_SCRUB_READONLY	1
+#define BTRFS_SCRUB_SUPPORTED_FLAGS	(BTRFS_SCRUB_READONLY)
 struct btrfs_ioctl_scrub_args {
 	__u64 devid;				/* in */
 	__u64 start;				/* in */
diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
index af2a44c08683..a429381e7ca5 100644
--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -28,7 +28,7 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
-#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
+#define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
 #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
 
 #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 43efba045acc..5a6a2ab675be 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -61,4 +61,15 @@ void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);
 #include <xen/balloon.h>
 #endif
 
+#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI) && defined(CONFIG_X86)
+bool __init xen_processor_present(uint32_t acpi_id);
+#else
+#include <linux/bug.h>
+static inline bool xen_processor_present(uint32_t acpi_id)
+{
+	BUG();
+	return false;
+}
+#endif
+
 #endif	/* _XEN_XEN_H */
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index eb3e787a3a97..87174832aa86 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1586,7 +1586,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		goto out;
 	}
 
-	if (ctx.optlen > max_optlen || ctx.optlen < 0) {
+	if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -1600,8 +1600,11 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	}
 
 	if (ctx.optlen != 0) {
-		if (copy_to_user(optval, ctx.optval, ctx.optlen) ||
-		    put_user(ctx.optlen, optlen)) {
+		if (optval && copy_to_user(optval, ctx.optval, ctx.optlen)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		if (put_user(ctx.optlen, optlen)) {
 			ret = -EFAULT;
 			goto out;
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 37d4b5f5ec0c..261c2ed3adb1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3114,17 +3114,13 @@ static int check_stack_read(struct bpf_verifier_env *env,
 	}
 	/* Variable offset is prohibited for unprivileged mode for simplicity
 	 * since it requires corresponding support in Spectre masking for stack
-	 * ALU. See also retrieve_ptr_limit().
+	 * ALU. See also retrieve_ptr_limit(). The check in
+	 * check_stack_access_for_ptr_arithmetic() called by
+	 * adjust_ptr_min_max_vals() prevents users from creating stack pointers
+	 * with variable offsets, therefore no check is required here. Further,
+	 * just checking it here would be insufficient as speculative stack
+	 * writes could still lead to unsafe speculative behaviour.
 	 */
-	if (!env->bypass_spec_v1 && var_off) {
-		char tn_buf[48];
-
-		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-		verbose(env, "R%d variable offset stack access prohibited for !root, var_off=%s\n",
-				ptr_regno, tn_buf);
-		return -EACCES;
-	}
-
 	if (!var_off) {
 		off += reg->var_off.value;
 		err = check_stack_read_fixed_off(env, state, off, size,
@@ -10616,10 +10612,11 @@ static int propagate_precision(struct bpf_verifier_env *env,
 		state_reg = state->regs;
 		for (i = 0; i < BPF_REG_FP; i++, state_reg++) {
 			if (state_reg->type != SCALAR_VALUE ||
-			    !state_reg->precise)
+			    !state_reg->precise ||
+			    !(state_reg->live & REG_LIVE_READ))
 				continue;
 			if (env->log.level & BPF_LOG_LEVEL2)
-				verbose(env, "frame %d: propagating r%d\n", i, fr);
+				verbose(env, "frame %d: propagating r%d\n", fr, i);
 			err = mark_chain_precision_frame(env, fr, i);
 			if (err < 0)
 				return err;
@@ -10630,11 +10627,12 @@ static int propagate_precision(struct bpf_verifier_env *env,
 				continue;
 			state_reg = &state->stack[i].spilled_ptr;
 			if (state_reg->type != SCALAR_VALUE ||
-			    !state_reg->precise)
+			    !state_reg->precise ||
+			    !(state_reg->live & REG_LIVE_READ))
 				continue;
 			if (env->log.level & BPF_LOG_LEVEL2)
 				verbose(env, "frame %d: propagating fp%d\n",
-					(-i - 1) * BPF_REG_SIZE, fr);
+					fr, (-i - 1) * BPF_REG_SIZE);
 			err = mark_chain_precision_stack_frame(env, fr, i);
 			if (err < 0)
 				return err;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index dc57835e7096..97052b2dff7e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9271,8 +9271,8 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
 		hwc->interrupts = 1;
 	} else {
 		hwc->interrupts++;
-		if (unlikely(throttle
-			     && hwc->interrupts >= max_samples_per_tick)) {
+		if (unlikely(throttle &&
+			     hwc->interrupts > max_samples_per_tick)) {
 			__this_cpu_inc(perf_throttled_count);
 			tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
 			hwc->interrupts = MAX_INTERRUPTS;
diff --git a/kernel/kheaders.c b/kernel/kheaders.c
index 8f69772af77b..42163c9e94e5 100644
--- a/kernel/kheaders.c
+++ b/kernel/kheaders.c
@@ -26,15 +26,15 @@ asm (
 "	.popsection				\n"
 );
 
-extern char kernel_headers_data;
-extern char kernel_headers_data_end;
+extern char kernel_headers_data[];
+extern char kernel_headers_data_end[];
 
 static ssize_t
 ikheaders_read(struct file *file,  struct kobject *kobj,
 	       struct bin_attribute *bin_attr,
 	       char *buf, loff_t off, size_t len)
 {
-	memcpy(buf, &kernel_headers_data + off, len);
+	memcpy(buf, &kernel_headers_data[off], len);
 	return len;
 }
 
@@ -48,8 +48,8 @@ static struct bin_attribute kheaders_attr __ro_after_init = {
 
 static int __init ikheaders_init(void)
 {
-	kheaders_attr.size = (&kernel_headers_data_end -
-			      &kernel_headers_data);
+	kheaders_attr.size = (kernel_headers_data_end -
+			      kernel_headers_data);
 	return sysfs_create_bin_file(kernel_kobj, &kheaders_attr);
 }
 
diff --git a/kernel/power/process.c b/kernel/power/process.c
index ee78a39463e6..11b570fcf049 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -94,7 +94,7 @@ static int try_to_freeze_tasks(bool user_only)
 		       todo - wq_busy, wq_busy);
 
 		if (wq_busy)
-			show_workqueue_state();
+			show_all_workqueues();
 
 		if (!wakeup || pm_debug_messages_on) {
 			read_lock(&tasklist_lock);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cf101da389b0..03902ee655ee 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -975,6 +975,7 @@ void __rcu_irq_enter_check_tick(void)
 	}
 	raw_spin_unlock_rcu_node(rdp->mynode);
 }
+NOKPROBE_SYMBOL(__rcu_irq_enter_check_tick);
 #endif /* CONFIG_NO_HZ_FULL */
 
 /**
diff --git a/kernel/relay.c b/kernel/relay.c
index 6825b8403877..a4d6889af94f 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -992,7 +992,8 @@ static size_t relay_file_read_start_pos(struct rchan_buf *buf)
 	size_t subbuf_size = buf->chan->subbuf_size;
 	size_t n_subbufs = buf->chan->n_subbufs;
 	size_t consumed = buf->subbufs_consumed % n_subbufs;
-	size_t read_pos = consumed * subbuf_size + buf->bytes_consumed;
+	size_t read_pos = (consumed * subbuf_size + buf->bytes_consumed)
+			% (n_subbufs * subbuf_size);
 
 	read_subbuf = read_pos / subbuf_size;
 	padding = buf->padding[read_subbuf];
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ed57d8358f24..d34a56f16d13 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3522,11 +3522,11 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 #ifdef CONFIG_SMP
 	if (cpu == rq->cpu) {
 		__schedstat_inc(rq->ttwu_local);
-		__schedstat_inc(p->se.statistics.nr_wakeups_local);
+		__schedstat_inc(p->stats.nr_wakeups_local);
 	} else {
 		struct sched_domain *sd;
 
-		__schedstat_inc(p->se.statistics.nr_wakeups_remote);
+		__schedstat_inc(p->stats.nr_wakeups_remote);
 		rcu_read_lock();
 		for_each_domain(rq->cpu, sd) {
 			if (cpumask_test_cpu(cpu, sched_domain_span(sd))) {
@@ -3538,14 +3538,14 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 	}
 
 	if (wake_flags & WF_MIGRATED)
-		__schedstat_inc(p->se.statistics.nr_wakeups_migrate);
+		__schedstat_inc(p->stats.nr_wakeups_migrate);
 #endif /* CONFIG_SMP */
 
 	__schedstat_inc(rq->ttwu_count);
-	__schedstat_inc(p->se.statistics.nr_wakeups);
+	__schedstat_inc(p->stats.nr_wakeups);
 
 	if (wake_flags & WF_SYNC)
-		__schedstat_inc(p->se.statistics.nr_wakeups_sync);
+		__schedstat_inc(p->stats.nr_wakeups_sync);
 }
 
 /*
@@ -4241,7 +4241,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
-	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
+	memset(&p->stats, 0, sizeof(p->stats));
 #endif
 
 	RB_CLEAR_NODE(&p->dl.rb_node);
@@ -9706,9 +9706,9 @@ void normalize_rt_tasks(void)
 			continue;
 
 		p->se.exec_start = 0;
-		schedstat_set(p->se.statistics.wait_start,  0);
-		schedstat_set(p->se.statistics.sleep_start, 0);
-		schedstat_set(p->se.statistics.block_start, 0);
+		schedstat_set(p->stats.wait_start,  0);
+		schedstat_set(p->stats.sleep_start, 0);
+		schedstat_set(p->stats.block_start, 0);
 
 		if (!dl_task(p) && !rt_task(p)) {
 			/*
@@ -10576,11 +10576,14 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 	seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);
 
 	if (schedstat_enabled() && tg != &root_task_group) {
+		struct sched_statistics *stats;
 		u64 ws = 0;
 		int i;
 
-		for_each_possible_cpu(i)
-			ws += schedstat_val(tg->se[i]->statistics.wait_sum);
+		for_each_possible_cpu(i) {
+			stats = __schedstats_from_se(tg->se[i]);
+			ws += schedstat_val(stats->wait_sum);
+		}
 
 		seq_printf(sf, "wait_sum %llu\n", ws);
 	}
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 226c814368d1..b3e206498395 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1265,8 +1265,8 @@ static void update_curr_dl(struct rq *rq)
 		return;
 	}
 
-	schedstat_set(curr->se.statistics.exec_max,
-		      max(curr->se.statistics.exec_max, delta_exec));
+	schedstat_set(curr->stats.exec_max,
+		      max(curr->stats.exec_max, delta_exec));
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
@@ -2084,6 +2084,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !dl_task(task) ||
+				     is_migration_disabled(task) ||
 				     !task_on_rq_queued(task))) {
 				double_unlock_balance(rq, later_rq);
 				later_rq = NULL;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 34c5ff3a0669..5ffe16ff039f 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -448,9 +448,11 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	struct sched_entity *se = tg->se[cpu];
 
 #define P(F)		SEQ_printf(m, "  .%-30s: %lld\n",	#F, (long long)F)
-#define P_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld\n",	#F, (long long)schedstat_val(F))
+#define P_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld\n",	\
+		#F, (long long)schedstat_val(stats->F))
 #define PN(F)		SEQ_printf(m, "  .%-30s: %lld.%06ld\n", #F, SPLIT_NS((long long)F))
-#define PN_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", #F, SPLIT_NS((long long)schedstat_val(F)))
+#define PN_SCHEDSTAT(F)	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", \
+		#F, SPLIT_NS((long long)schedstat_val(stats->F)))
 
 	if (!se)
 		return;
@@ -460,16 +462,19 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	PN(se->sum_exec_runtime);
 
 	if (schedstat_enabled()) {
-		PN_SCHEDSTAT(se->statistics.wait_start);
-		PN_SCHEDSTAT(se->statistics.sleep_start);
-		PN_SCHEDSTAT(se->statistics.block_start);
-		PN_SCHEDSTAT(se->statistics.sleep_max);
-		PN_SCHEDSTAT(se->statistics.block_max);
-		PN_SCHEDSTAT(se->statistics.exec_max);
-		PN_SCHEDSTAT(se->statistics.slice_max);
-		PN_SCHEDSTAT(se->statistics.wait_max);
-		PN_SCHEDSTAT(se->statistics.wait_sum);
-		P_SCHEDSTAT(se->statistics.wait_count);
+		struct sched_statistics *stats;
+		stats = __schedstats_from_se(se);
+
+		PN_SCHEDSTAT(wait_start);
+		PN_SCHEDSTAT(sleep_start);
+		PN_SCHEDSTAT(block_start);
+		PN_SCHEDSTAT(sleep_max);
+		PN_SCHEDSTAT(block_max);
+		PN_SCHEDSTAT(exec_max);
+		PN_SCHEDSTAT(slice_max);
+		PN_SCHEDSTAT(wait_max);
+		PN_SCHEDSTAT(wait_sum);
+		P_SCHEDSTAT(wait_count);
 	}
 
 	P(se->load.weight);
@@ -536,9 +541,9 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 		p->prio);
 
 	SEQ_printf(m, "%9Ld.%06ld %9Ld.%06ld %9Ld.%06ld",
-		SPLIT_NS(schedstat_val_or_zero(p->se.statistics.wait_sum)),
+		SPLIT_NS(schedstat_val_or_zero(p->stats.wait_sum)),
 		SPLIT_NS(p->se.sum_exec_runtime),
-		SPLIT_NS(schedstat_val_or_zero(p->se.statistics.sum_sleep_runtime)));
+		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_sleep_runtime)));
 
 #ifdef CONFIG_NUMA_BALANCING
 	SEQ_printf(m, " %d %d", task_node(p), task_numa_group_id(p));
@@ -944,8 +949,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		"---------------------------------------------------------"
 		"----------\n");
 
-#define P_SCHEDSTAT(F)  __PS(#F, schedstat_val(p->F))
-#define PN_SCHEDSTAT(F) __PSN(#F, schedstat_val(p->F))
+#define P_SCHEDSTAT(F)  __PS(#F, schedstat_val(p->stats.F))
+#define PN_SCHEDSTAT(F) __PSN(#F, schedstat_val(p->stats.F))
 
 	PN(se.exec_start);
 	PN(se.vruntime);
@@ -958,33 +963,33 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	if (schedstat_enabled()) {
 		u64 avg_atom, avg_per_cpu;
 
-		PN_SCHEDSTAT(se.statistics.sum_sleep_runtime);
-		PN_SCHEDSTAT(se.statistics.wait_start);
-		PN_SCHEDSTAT(se.statistics.sleep_start);
-		PN_SCHEDSTAT(se.statistics.block_start);
-		PN_SCHEDSTAT(se.statistics.sleep_max);
-		PN_SCHEDSTAT(se.statistics.block_max);
-		PN_SCHEDSTAT(se.statistics.exec_max);
-		PN_SCHEDSTAT(se.statistics.slice_max);
-		PN_SCHEDSTAT(se.statistics.wait_max);
-		PN_SCHEDSTAT(se.statistics.wait_sum);
-		P_SCHEDSTAT(se.statistics.wait_count);
-		PN_SCHEDSTAT(se.statistics.iowait_sum);
-		P_SCHEDSTAT(se.statistics.iowait_count);
-		P_SCHEDSTAT(se.statistics.nr_migrations_cold);
-		P_SCHEDSTAT(se.statistics.nr_failed_migrations_affine);
-		P_SCHEDSTAT(se.statistics.nr_failed_migrations_running);
-		P_SCHEDSTAT(se.statistics.nr_failed_migrations_hot);
-		P_SCHEDSTAT(se.statistics.nr_forced_migrations);
-		P_SCHEDSTAT(se.statistics.nr_wakeups);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_sync);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_migrate);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_local);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_remote);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_affine);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_affine_attempts);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_passive);
-		P_SCHEDSTAT(se.statistics.nr_wakeups_idle);
+		PN_SCHEDSTAT(sum_sleep_runtime);
+		PN_SCHEDSTAT(wait_start);
+		PN_SCHEDSTAT(sleep_start);
+		PN_SCHEDSTAT(block_start);
+		PN_SCHEDSTAT(sleep_max);
+		PN_SCHEDSTAT(block_max);
+		PN_SCHEDSTAT(exec_max);
+		PN_SCHEDSTAT(slice_max);
+		PN_SCHEDSTAT(wait_max);
+		PN_SCHEDSTAT(wait_sum);
+		P_SCHEDSTAT(wait_count);
+		PN_SCHEDSTAT(iowait_sum);
+		P_SCHEDSTAT(iowait_count);
+		P_SCHEDSTAT(nr_migrations_cold);
+		P_SCHEDSTAT(nr_failed_migrations_affine);
+		P_SCHEDSTAT(nr_failed_migrations_running);
+		P_SCHEDSTAT(nr_failed_migrations_hot);
+		P_SCHEDSTAT(nr_forced_migrations);
+		P_SCHEDSTAT(nr_wakeups);
+		P_SCHEDSTAT(nr_wakeups_sync);
+		P_SCHEDSTAT(nr_wakeups_migrate);
+		P_SCHEDSTAT(nr_wakeups_local);
+		P_SCHEDSTAT(nr_wakeups_remote);
+		P_SCHEDSTAT(nr_wakeups_affine);
+		P_SCHEDSTAT(nr_wakeups_affine_attempts);
+		P_SCHEDSTAT(nr_wakeups_passive);
+		P_SCHEDSTAT(nr_wakeups_idle);
 
 		avg_atom = p->se.sum_exec_runtime;
 		if (nr_switches)
@@ -1050,7 +1055,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 void proc_sched_set_task(struct task_struct *p)
 {
 #ifdef CONFIG_SCHEDSTATS
-	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
+	memset(&p->stats, 0, sizeof(p->stats));
 #endif
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 591fdc81378e..646a6ae4b250 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -837,8 +837,13 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 	curr->exec_start = now;
 
-	schedstat_set(curr->statistics.exec_max,
-		      max(delta_exec, curr->statistics.exec_max));
+	if (schedstat_enabled()) {
+		struct sched_statistics *stats;
+
+		stats = __schedstats_from_se(curr);
+		__schedstat_set(stats->exec_max,
+				max(delta_exec, stats->exec_max));
+	}
 
 	curr->sum_exec_runtime += delta_exec;
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
@@ -866,39 +871,45 @@ static inline void
 update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	u64 wait_start, prev_wait_start;
+	struct sched_statistics *stats;
 
 	if (!schedstat_enabled())
 		return;
 
+	stats = __schedstats_from_se(se);
+
 	wait_start = rq_clock(rq_of(cfs_rq));
-	prev_wait_start = schedstat_val(se->statistics.wait_start);
+	prev_wait_start = schedstat_val(stats->wait_start);
 
 	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)) &&
 	    likely(wait_start > prev_wait_start))
 		wait_start -= prev_wait_start;
 
-	__schedstat_set(se->statistics.wait_start, wait_start);
+	__schedstat_set(stats->wait_start, wait_start);
 }
 
 static inline void
 update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	struct task_struct *p;
+	struct sched_statistics *stats;
+	struct task_struct *p = NULL;
 	u64 delta;
 
 	if (!schedstat_enabled())
 		return;
 
+	stats = __schedstats_from_se(se);
+
 	/*
 	 * When the sched_schedstat changes from 0 to 1, some sched se
 	 * maybe already in the runqueue, the se->statistics.wait_start
 	 * will be 0.So it will let the delta wrong. We need to avoid this
 	 * scenario.
 	 */
-	if (unlikely(!schedstat_val(se->statistics.wait_start)))
+	if (unlikely(!schedstat_val(stats->wait_start)))
 		return;
 
-	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
+	delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(stats->wait_start);
 
 	if (entity_is_task(se)) {
 		p = task_of(se);
@@ -908,30 +919,33 @@ update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
 			 * time stamp can be adjusted to accumulate wait time
 			 * prior to migration.
 			 */
-			__schedstat_set(se->statistics.wait_start, delta);
+			__schedstat_set(stats->wait_start, delta);
 			return;
 		}
 		trace_sched_stat_wait(p, delta);
 	}
 
-	__schedstat_set(se->statistics.wait_max,
-		      max(schedstat_val(se->statistics.wait_max), delta));
-	__schedstat_inc(se->statistics.wait_count);
-	__schedstat_add(se->statistics.wait_sum, delta);
-	__schedstat_set(se->statistics.wait_start, 0);
+	__schedstat_set(stats->wait_max,
+		      max(schedstat_val(stats->wait_max), delta));
+	__schedstat_inc(stats->wait_count);
+	__schedstat_add(stats->wait_sum, delta);
+	__schedstat_set(stats->wait_start, 0);
 }
 
 static inline void
 update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	struct sched_statistics *stats;
 	struct task_struct *tsk = NULL;
 	u64 sleep_start, block_start;
 
 	if (!schedstat_enabled())
 		return;
 
-	sleep_start = schedstat_val(se->statistics.sleep_start);
-	block_start = schedstat_val(se->statistics.block_start);
+	stats = __schedstats_from_se(se);
+
+	sleep_start = schedstat_val(stats->sleep_start);
+	block_start = schedstat_val(stats->block_start);
 
 	if (entity_is_task(se))
 		tsk = task_of(se);
@@ -942,11 +956,11 @@ update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		if ((s64)delta < 0)
 			delta = 0;
 
-		if (unlikely(delta > schedstat_val(se->statistics.sleep_max)))
-			__schedstat_set(se->statistics.sleep_max, delta);
+		if (unlikely(delta > schedstat_val(stats->sleep_max)))
+			__schedstat_set(stats->sleep_max, delta);
 
-		__schedstat_set(se->statistics.sleep_start, 0);
-		__schedstat_add(se->statistics.sum_sleep_runtime, delta);
+		__schedstat_set(stats->sleep_start, 0);
+		__schedstat_add(stats->sum_sleep_runtime, delta);
 
 		if (tsk) {
 			account_scheduler_latency(tsk, delta >> 10, 1);
@@ -959,16 +973,16 @@ update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		if ((s64)delta < 0)
 			delta = 0;
 
-		if (unlikely(delta > schedstat_val(se->statistics.block_max)))
-			__schedstat_set(se->statistics.block_max, delta);
+		if (unlikely(delta > schedstat_val(stats->block_max)))
+			__schedstat_set(stats->block_max, delta);
 
-		__schedstat_set(se->statistics.block_start, 0);
-		__schedstat_add(se->statistics.sum_sleep_runtime, delta);
+		__schedstat_set(stats->block_start, 0);
+		__schedstat_add(stats->sum_sleep_runtime, delta);
 
 		if (tsk) {
 			if (tsk->in_iowait) {
-				__schedstat_add(se->statistics.iowait_sum, delta);
-				__schedstat_inc(se->statistics.iowait_count);
+				__schedstat_add(stats->iowait_sum, delta);
+				__schedstat_inc(stats->iowait_count);
 				trace_sched_stat_iowait(tsk, delta);
 			}
 
@@ -1030,10 +1044,10 @@ update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		/* XXX racy against TTWU */
 		state = READ_ONCE(tsk->__state);
 		if (state & TASK_INTERRUPTIBLE)
-			__schedstat_set(se->statistics.sleep_start,
+			__schedstat_set(tsk->stats.sleep_start,
 				      rq_clock(rq_of(cfs_rq)));
 		if (state & TASK_UNINTERRUPTIBLE)
-			__schedstat_set(se->statistics.block_start,
+			__schedstat_set(tsk->stats.block_start,
 				      rq_clock(rq_of(cfs_rq)));
 	}
 }
@@ -4691,9 +4705,12 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 */
 	if (schedstat_enabled() &&
 	    rq_of(cfs_rq)->cfs.load.weight >= 2*se->load.weight) {
-		schedstat_set(se->statistics.slice_max,
-			max((u64)schedstat_val(se->statistics.slice_max),
-			    se->sum_exec_runtime - se->prev_sum_exec_runtime));
+		struct sched_statistics *stats;
+
+		stats = __schedstats_from_se(se);
+		__schedstat_set(stats->slice_max,
+				max((u64)stats->slice_max,
+				    se->sum_exec_runtime - se->prev_sum_exec_runtime));
 	}
 
 	se->prev_sum_exec_runtime = se->sum_exec_runtime;
@@ -6189,12 +6206,12 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
 
-	schedstat_inc(p->se.statistics.nr_wakeups_affine_attempts);
-	if (target == nr_cpumask_bits)
+	schedstat_inc(p->stats.nr_wakeups_affine_attempts);
+	if (target != this_cpu)
 		return prev_cpu;
 
 	schedstat_inc(sd->ttwu_move_affine);
-	schedstat_inc(p->se.statistics.nr_wakeups_affine);
+	schedstat_inc(p->stats.nr_wakeups_affine);
 	return target;
 }
 
@@ -8030,7 +8047,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
 
-		schedstat_inc(p->se.statistics.nr_failed_migrations_affine);
+		schedstat_inc(p->stats.nr_failed_migrations_affine);
 
 		env->flags |= LBF_SOME_PINNED;
 
@@ -8064,7 +8081,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	env->flags &= ~LBF_ALL_PINNED;
 
 	if (task_running(env->src_rq, p)) {
-		schedstat_inc(p->se.statistics.nr_failed_migrations_running);
+		schedstat_inc(p->stats.nr_failed_migrations_running);
 		return 0;
 	}
 
@@ -8086,12 +8103,12 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	    env->sd->nr_balance_failed > env->sd->cache_nice_tries) {
 		if (tsk_cache_hot == 1) {
 			schedstat_inc(env->sd->lb_hot_gained[env->idle]);
-			schedstat_inc(p->se.statistics.nr_forced_migrations);
+			schedstat_inc(p->stats.nr_forced_migrations);
 		}
 		return 1;
 	}
 
-	schedstat_inc(p->se.statistics.nr_failed_migrations_hot);
+	schedstat_inc(p->stats.nr_failed_migrations_hot);
 	return 0;
 }
 
@@ -11774,7 +11791,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		if (!cfs_rq)
 			goto err;
 
-		se = kzalloc_node(sizeof(struct sched_entity),
+		se = kzalloc_node(sizeof(struct sched_entity_stats),
 				  GFP_KERNEL, cpu_to_node(i));
 		if (!se)
 			goto err_free_rq;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 08af6076c809..4b9281e6b1cc 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1021,8 +1021,8 @@ static void update_curr_rt(struct rq *rq)
 	if (unlikely((s64)delta_exec <= 0))
 		return;
 
-	schedstat_set(curr->se.statistics.exec_max,
-		      max(curr->se.statistics.exec_max, delta_exec));
+	schedstat_set(curr->stats.exec_max,
+		      max(curr->stats.exec_max, delta_exec));
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
@@ -1842,11 +1842,15 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 * the mean time, task could have
 			 * migrated already or had its affinity changed.
 			 * Also make sure that it wasn't scheduled on its rq.
+			 * It is possible the task was scheduled, set
+			 * "migrate_disabled" and then got preempted, so we must
+			 * check the task migration disable flag here too.
 			 */
 			if (unlikely(task_rq(task) != rq ||
 				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !rt_task(task) ||
+				     is_migration_disabled(task) ||
 				     !task_on_rq_queued(task))) {
 
 				double_unlock_balance(rq, lowest_rq);
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 606a3982d13a..975703572bc0 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -41,6 +41,7 @@ rq_sched_info_dequeue(struct rq *rq, unsigned long long delta)
 #define   schedstat_val_or_zero(var)	((schedstat_enabled()) ? (var) : 0)
 
 #else /* !CONFIG_SCHEDSTATS: */
+
 static inline void rq_sched_info_arrive  (struct rq *rq, unsigned long long delta) { }
 static inline void rq_sched_info_dequeue(struct rq *rq, unsigned long long delta) { }
 static inline void rq_sched_info_depart  (struct rq *rq, unsigned long long delta) { }
@@ -53,8 +54,26 @@ static inline void rq_sched_info_depart  (struct rq *rq, unsigned long long delt
 # define   schedstat_set(var, val)	do { } while (0)
 # define   schedstat_val(var)		0
 # define   schedstat_val_or_zero(var)	0
+
 #endif /* CONFIG_SCHEDSTATS */
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+struct sched_entity_stats {
+	struct sched_entity     se;
+	struct sched_statistics stats;
+} __no_randomize_layout;
+#endif
+
+static inline struct sched_statistics *
+__schedstats_from_se(struct sched_entity *se)
+{
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	if (!entity_is_task(se))
+		return &container_of(se, struct sched_entity_stats, se)->stats;
+#endif
+	return &task_of(se)->stats;
+}
+
 #ifdef CONFIG_PSI
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index f988ebe3febb..0b165a25f22f 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -78,8 +78,8 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 	if (unlikely((s64)delta_exec < 0))
 		delta_exec = 0;
 
-	schedstat_set(curr->se.statistics.exec_max,
-			max(curr->se.statistics.exec_max, delta_exec));
+	schedstat_set(curr->stats.exec_max,
+		      max(curr->stats.exec_max, delta_exec));
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 96b4e7810426..6b6271387de8 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -840,6 +840,8 @@ static u64 collect_timerqueue(struct timerqueue_head *head,
 			return expires;
 
 		ctmr->firing = 1;
+		/* See posix_cpu_timer_wait_running() */
+		rcu_assign_pointer(ctmr->handling, current);
 		cpu_timer_dequeue(ctmr);
 		list_add_tail(&ctmr->elist, firing);
 	}
@@ -1155,7 +1157,49 @@ static void handle_posix_cpu_timers(struct task_struct *tsk);
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
 static void posix_cpu_timers_work(struct callback_head *work)
 {
+	struct posix_cputimers_work *cw = container_of(work, typeof(*cw), work);
+
+	mutex_lock(&cw->mutex);
 	handle_posix_cpu_timers(current);
+	mutex_unlock(&cw->mutex);
+}
+
+/*
+ * Invoked from the posix-timer core when a cancel operation failed because
+ * the timer is marked firing. The caller holds rcu_read_lock(), which
+ * protects the timer and the task which is expiring it from being freed.
+ */
+static void posix_cpu_timer_wait_running(struct k_itimer *timr)
+{
+	struct task_struct *tsk = rcu_dereference(timr->it.cpu.handling);
+
+	/* Has the handling task completed expiry already? */
+	if (!tsk)
+		return;
+
+	/* Ensure that the task cannot go away */
+	get_task_struct(tsk);
+	/* Now drop the RCU protection so the mutex can be locked */
+	rcu_read_unlock();
+	/* Wait on the expiry mutex */
+	mutex_lock(&tsk->posix_cputimers_work.mutex);
+	/* Release it immediately again. */
+	mutex_unlock(&tsk->posix_cputimers_work.mutex);
+	/* Drop the task reference. */
+	put_task_struct(tsk);
+	/* Relock RCU so the callsite is balanced */
+	rcu_read_lock();
+}
+
+static void posix_cpu_timer_wait_running_nsleep(struct k_itimer *timr)
+{
+	/* Ensure that timr->it.cpu.handling task cannot go away */
+	rcu_read_lock();
+	spin_unlock_irq(&timr->it_lock);
+	posix_cpu_timer_wait_running(timr);
+	rcu_read_unlock();
+	/* @timr is on stack and is valid */
+	spin_lock_irq(&timr->it_lock);
 }
 
 /*
@@ -1171,6 +1215,7 @@ void clear_posix_cputimers_work(struct task_struct *p)
 	       sizeof(p->posix_cputimers_work.work));
 	init_task_work(&p->posix_cputimers_work.work,
 		       posix_cpu_timers_work);
+	mutex_init(&p->posix_cputimers_work.mutex);
 	p->posix_cputimers_work.scheduled = false;
 }
 
@@ -1249,6 +1294,18 @@ static inline void __run_posix_cpu_timers(struct task_struct *tsk)
 	lockdep_posixtimer_exit();
 }
 
+static void posix_cpu_timer_wait_running(struct k_itimer *timr)
+{
+	cpu_relax();
+}
+
+static void posix_cpu_timer_wait_running_nsleep(struct k_itimer *timr)
+{
+	spin_unlock_irq(&timr->it_lock);
+	cpu_relax();
+	spin_lock_irq(&timr->it_lock);
+}
+
 static inline bool posix_cpu_timers_work_scheduled(struct task_struct *tsk)
 {
 	return false;
@@ -1357,6 +1414,8 @@ static void handle_posix_cpu_timers(struct task_struct *tsk)
 		 */
 		if (likely(cpu_firing >= 0))
 			cpu_timer_fire(timer);
+		/* See posix_cpu_timer_wait_running() */
+		rcu_assign_pointer(timer->it.cpu.handling, NULL);
 		spin_unlock(&timer->it_lock);
 	}
 }
@@ -1491,23 +1550,16 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 		expires = cpu_timer_getexpires(&timer.it.cpu);
 		error = posix_cpu_timer_set(&timer, 0, &zero_it, &it);
 		if (!error) {
-			/*
-			 * Timer is now unarmed, deletion can not fail.
-			 */
+			/* Timer is now unarmed, deletion can not fail. */
 			posix_cpu_timer_del(&timer);
+		} else {
+			while (error == TIMER_RETRY) {
+				posix_cpu_timer_wait_running_nsleep(&timer);
+				error = posix_cpu_timer_del(&timer);
+			}
 		}
-		spin_unlock_irq(&timer.it_lock);
 
-		while (error == TIMER_RETRY) {
-			/*
-			 * We need to handle case when timer was or is in the
-			 * middle of firing. In other cases we already freed
-			 * resources.
-			 */
-			spin_lock_irq(&timer.it_lock);
-			error = posix_cpu_timer_del(&timer);
-			spin_unlock_irq(&timer.it_lock);
-		}
+		spin_unlock_irq(&timer.it_lock);
 
 		if ((it.it_value.tv_sec | it.it_value.tv_nsec) == 0) {
 			/*
@@ -1617,6 +1669,7 @@ const struct k_clock clock_posix_cpu = {
 	.timer_del		= posix_cpu_timer_del,
 	.timer_get		= posix_cpu_timer_get,
 	.timer_rearm		= posix_cpu_timer_rearm,
+	.timer_wait_running	= posix_cpu_timer_wait_running,
 };
 
 const struct k_clock clock_process = {
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 0c8a87a11b39..808a247205a9 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -846,6 +846,10 @@ static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 	rcu_read_lock();
 	unlock_timer(timer, *flags);
 
+	/*
+	 * kc->timer_wait_running() might drop RCU lock. So @timer
+	 * cannot be touched anymore after the function returns!
+	 */
 	if (!WARN_ON_ONCE(!kc->timer_wait_running))
 		kc->timer_wait_running(timer);
 
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 46789356f856..65b8658da829 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -218,9 +218,19 @@ static void tick_setup_device(struct tick_device *td,
 		 * this cpu:
 		 */
 		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
+			ktime_t next_p;
+			u32 rem;
+
 			tick_do_timer_cpu = cpu;
 
-			tick_next_period = ktime_get();
+			next_p = ktime_get();
+			div_u64_rem(next_p, TICK_NSEC, &rem);
+			if (rem) {
+				next_p -= rem;
+				next_p += TICK_NSEC;
+			}
+
+			tick_next_period = next_p;
 #ifdef CONFIG_NO_HZ_FULL
 			/*
 			 * The boot CPU may be nohz_full, in which case set
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9c6f661fb436..e014927c82e7 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -264,6 +264,11 @@ static bool check_tick_dependency(atomic_t *dep)
 		return true;
 	}
 
+	if (val & TICK_DEP_MASK_RCU_EXP) {
+		trace_tick_stop(0, TICK_DEP_MASK_RCU_EXP);
+		return true;
+	}
+
 	return false;
 }
 
@@ -510,7 +515,7 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 	tick_nohz_full_running = true;
 }
 
-static int tick_nohz_cpu_down(unsigned int cpu)
+bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
 {
 	/*
 	 * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
@@ -518,8 +523,13 @@ static int tick_nohz_cpu_down(unsigned int cpu)
 	 * CPUs. It must remain online when nohz full is enabled.
 	 */
 	if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
-		return -EBUSY;
-	return 0;
+		return false;
+	return true;
+}
+
+static int tick_nohz_cpu_down(unsigned int cpu)
+{
+	return tick_nohz_cpu_hotpluggable(cpu) ? 0 : -EBUSY;
 }
 
 void __init tick_nohz_init(void)
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d6a0ff68df41..d921c1b256cf 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -523,7 +523,7 @@ EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
  * partially updated.  Since the tk->offs_boot update is a rare event, this
  * should be a rare occurrence which postprocessing should be able to handle.
  *
- * The caveats vs. timestamp ordering as documented for ktime_get_fast_ns()
+ * The caveats vs. timestamp ordering as documented for ktime_get_mono_fast_ns()
  * apply as well.
  */
 u64 notrace ktime_get_boot_fast_ns(void)
@@ -559,7 +559,7 @@ static __always_inline u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *mono)
 /**
  * ktime_get_real_fast_ns: - NMI safe and fast access to clock realtime.
  *
- * See ktime_get_fast_ns() for documentation of the time stamp ordering.
+ * See ktime_get_mono_fast_ns() for documentation of the time stamp ordering.
  */
 u64 ktime_get_real_fast_ns(void)
 {
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c75c81f0a3c3..bacd1f87f941 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1742,6 +1742,8 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 	struct list_head *head = cpu_buffer->pages;
 	struct buffer_page *bpage, *tmp;
 
+	irq_work_sync(&cpu_buffer->irq_work.work);
+
 	free_buffer_page(cpu_buffer->reader_page);
 
 	if (head) {
@@ -1848,6 +1850,8 @@ ring_buffer_free(struct trace_buffer *buffer)
 
 	cpuhp_state_remove_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
 
+	irq_work_sync(&buffer->irq_work.work);
+
 	for_each_buffer_cpu(buffer, cpu)
 		rb_free_cpu_buffer(buffer->buffers[cpu]);
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e2277cba4817..f8b5abd6e36c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9565,7 +9565,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 
 	tr->buffer_percent = 50;
 
-	trace_create_file("buffer_percent", TRACE_MODE_READ, d_tracer,
+	trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
 			tr, &buffer_percent_fops);
 
 	create_trace_options_dir(tr);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f5fa7be8d17e..2d27bed9881d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -375,6 +375,7 @@ EXPORT_SYMBOL_GPL(system_freezable_power_efficient_wq);
 static int worker_thread(void *__worker);
 static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
 static void show_pwq(struct pool_workqueue *pwq);
+static void show_one_worker_pool(struct worker_pool *pool);
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/workqueue.h>
@@ -4454,7 +4455,7 @@ void destroy_workqueue(struct workqueue_struct *wq)
 			raw_spin_unlock_irq(&pwq->pool->lock);
 			mutex_unlock(&wq->mutex);
 			mutex_unlock(&wq_pool_mutex);
-			show_workqueue_state();
+			show_one_workqueue(wq);
 			return;
 		}
 		raw_spin_unlock_irq(&pwq->pool->lock);
@@ -4804,97 +4805,120 @@ static void show_pwq(struct pool_workqueue *pwq)
 }
 
 /**
- * show_workqueue_state - dump workqueue state
- *
- * Called from a sysrq handler or try_to_freeze_tasks() and prints out
- * all busy workqueues and pools.
+ * show_one_workqueue - dump state of specified workqueue
+ * @wq: workqueue whose state will be printed
  */
-void show_workqueue_state(void)
+void show_one_workqueue(struct workqueue_struct *wq)
 {
-	struct workqueue_struct *wq;
-	struct worker_pool *pool;
+	struct pool_workqueue *pwq;
+	bool idle = true;
 	unsigned long flags;
-	int pi;
 
-	rcu_read_lock();
-
-	pr_info("Showing busy workqueues and worker pools:\n");
-
-	list_for_each_entry_rcu(wq, &workqueues, list) {
-		struct pool_workqueue *pwq;
-		bool idle = true;
-
-		for_each_pwq(pwq, wq) {
-			if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
-				idle = false;
-				break;
-			}
+	for_each_pwq(pwq, wq) {
+		if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
+			idle = false;
+			break;
 		}
-		if (idle)
-			continue;
+	}
+	if (idle) /* Nothing to print for idle workqueue */
+		return;
 
-		pr_info("workqueue %s: flags=0x%x\n", wq->name, wq->flags);
+	pr_info("workqueue %s: flags=0x%x\n", wq->name, wq->flags);
 
-		for_each_pwq(pwq, wq) {
-			raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-			if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
-				/*
-				 * Defer printing to avoid deadlocks in console
-				 * drivers that queue work while holding locks
-				 * also taken in their write paths.
-				 */
-				printk_deferred_enter();
-				show_pwq(pwq);
-				printk_deferred_exit();
-			}
-			raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
+	for_each_pwq(pwq, wq) {
+		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
+		if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
 			/*
-			 * We could be printing a lot from atomic context, e.g.
-			 * sysrq-t -> show_workqueue_state(). Avoid triggering
-			 * hard lockup.
+			 * Defer printing to avoid deadlocks in console
+			 * drivers that queue work while holding locks
+			 * also taken in their write paths.
 			 */
-			touch_nmi_watchdog();
-		}
-	}
-
-	for_each_pool(pool, pi) {
-		struct worker *worker;
-		bool first = true;
-
-		raw_spin_lock_irqsave(&pool->lock, flags);
-		if (pool->nr_workers == pool->nr_idle)
-			goto next_pool;
-		/*
-		 * Defer printing to avoid deadlocks in console drivers that
-		 * queue work while holding locks also taken in their write
-		 * paths.
-		 */
-		printk_deferred_enter();
-		pr_info("pool %d:", pool->id);
-		pr_cont_pool_info(pool);
-		pr_cont(" hung=%us workers=%d",
-			jiffies_to_msecs(jiffies - pool->watchdog_ts) / 1000,
-			pool->nr_workers);
-		if (pool->manager)
-			pr_cont(" manager: %d",
-				task_pid_nr(pool->manager->task));
-		list_for_each_entry(worker, &pool->idle_list, entry) {
-			pr_cont(" %s%d", first ? "idle: " : "",
-				task_pid_nr(worker->task));
-			first = false;
+			printk_deferred_enter();
+			show_pwq(pwq);
+			printk_deferred_exit();
 		}
-		pr_cont("\n");
-		printk_deferred_exit();
-	next_pool:
-		raw_spin_unlock_irqrestore(&pool->lock, flags);
+		raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 		/*
 		 * We could be printing a lot from atomic context, e.g.
-		 * sysrq-t -> show_workqueue_state(). Avoid triggering
+		 * sysrq-t -> show_all_workqueues(). Avoid triggering
 		 * hard lockup.
 		 */
 		touch_nmi_watchdog();
 	}
 
+}
+
+/**
+ * show_one_worker_pool - dump state of specified worker pool
+ * @pool: worker pool whose state will be printed
+ */
+static void show_one_worker_pool(struct worker_pool *pool)
+{
+	struct worker *worker;
+	bool first = true;
+	unsigned long flags;
+	unsigned long hung = 0;
+
+	raw_spin_lock_irqsave(&pool->lock, flags);
+	if (pool->nr_workers == pool->nr_idle)
+		goto next_pool;
+
+	/* How long the first pending work is waiting for a worker. */
+	if (!list_empty(&pool->worklist))
+		hung = jiffies_to_msecs(jiffies - pool->watchdog_ts) / 1000;
+
+	/*
+	 * Defer printing to avoid deadlocks in console drivers that
+	 * queue work while holding locks also taken in their write
+	 * paths.
+	 */
+	printk_deferred_enter();
+	pr_info("pool %d:", pool->id);
+	pr_cont_pool_info(pool);
+	pr_cont(" hung=%lus workers=%d", hung, pool->nr_workers);
+	if (pool->manager)
+		pr_cont(" manager: %d",
+			task_pid_nr(pool->manager->task));
+	list_for_each_entry(worker, &pool->idle_list, entry) {
+		pr_cont(" %s%d", first ? "idle: " : "",
+			task_pid_nr(worker->task));
+		first = false;
+	}
+	pr_cont("\n");
+	printk_deferred_exit();
+next_pool:
+	raw_spin_unlock_irqrestore(&pool->lock, flags);
+	/*
+	 * We could be printing a lot from atomic context, e.g.
+	 * sysrq-t -> show_all_workqueues(). Avoid triggering
+	 * hard lockup.
+	 */
+	touch_nmi_watchdog();
+
+}
+
+/**
+ * show_all_workqueues - dump workqueue state
+ *
+ * Called from a sysrq handler or try_to_freeze_tasks() and prints out
+ * all busy workqueues and pools.
+ */
+void show_all_workqueues(void)
+{
+	struct workqueue_struct *wq;
+	struct worker_pool *pool;
+	int pi;
+
+	rcu_read_lock();
+
+	pr_info("Showing busy workqueues and worker pools:\n");
+
+	list_for_each_entry_rcu(wq, &workqueues, list)
+		show_one_workqueue(wq);
+
+	for_each_pool(pool, pi)
+		show_one_worker_pool(pool);
+
 	rcu_read_unlock();
 }
 
@@ -5883,7 +5907,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 	rcu_read_unlock();
 
 	if (lockup_detected)
-		show_workqueue_state();
+		show_all_workqueues();
 
 	wq_watchdog_reset_touched();
 	mod_timer(&wq_watchdog_timer, jiffies + thresh);
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 793c31b7e417..824337ec36aa 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -219,10 +219,6 @@ static struct debug_obj *__alloc_object(struct hlist_head *list)
 	return obj;
 }
 
-/*
- * Allocate a new object. If the pool is empty, switch off the debugger.
- * Must be called with interrupts disabled.
- */
 static struct debug_obj *
 alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
 {
@@ -555,36 +551,74 @@ static void debug_object_is_on_stack(void *addr, int onstack)
 	WARN_ON(1);
 }
 
-static void
-__debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
+static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket *b,
+						const struct debug_obj_descr *descr,
+						bool onstack, bool alloc_ifstatic)
 {
-	enum debug_obj_state state;
-	bool check_stack = false;
-	struct debug_bucket *db;
-	struct debug_obj *obj;
-	unsigned long flags;
+	struct debug_obj *obj = lookup_object(addr, b);
+	enum debug_obj_state state = ODEBUG_STATE_NONE;
+
+	if (likely(obj))
+		return obj;
+
+	/*
+	 * debug_object_init() unconditionally allocates untracked
+	 * objects. It does not matter whether it is a static object or
+	 * not.
+	 *
+	 * debug_object_assert_init() and debug_object_activate() allow
+	 * allocation only if the descriptor callback confirms that the
+	 * object is static and considered initialized. For non-static
+	 * objects the allocation needs to be done from the fixup callback.
+	 */
+	if (unlikely(alloc_ifstatic)) {
+		if (!descr->is_static_object || !descr->is_static_object(addr))
+			return ERR_PTR(-ENOENT);
+		/* Statically allocated objects are considered initialized */
+		state = ODEBUG_STATE_INIT;
+	}
+
+	obj = alloc_object(addr, b, descr);
+	if (likely(obj)) {
+		obj->state = state;
+		debug_object_is_on_stack(addr, onstack);
+		return obj;
+	}
+
+	/* Out of memory. Do the cleanup outside of the locked region */
+	debug_objects_enabled = 0;
+	return NULL;
+}
 
+static void debug_objects_fill_pool(void)
+{
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
 	 * context:
 	 */
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
 		fill_pool();
+}
+
+static void
+__debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
+{
+	enum debug_obj_state state;
+	struct debug_bucket *db;
+	struct debug_obj *obj;
+	unsigned long flags;
+
+	debug_objects_fill_pool();
 
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);
 
-	obj = lookup_object(addr, db);
-	if (!obj) {
-		obj = alloc_object(addr, db, descr);
-		if (!obj) {
-			debug_objects_enabled = 0;
-			raw_spin_unlock_irqrestore(&db->lock, flags);
-			debug_objects_oom();
-			return;
-		}
-		check_stack = true;
+	obj = lookup_object_or_alloc(addr, db, descr, onstack, false);
+	if (unlikely(!obj)) {
+		raw_spin_unlock_irqrestore(&db->lock, flags);
+		debug_objects_oom();
+		return;
 	}
 
 	switch (obj->state) {
@@ -610,8 +644,6 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 	}
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
-	if (check_stack)
-		debug_object_is_on_stack(addr, onstack);
 }
 
 /**
@@ -651,24 +683,24 @@ EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
  */
 int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 {
+	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
 	enum debug_obj_state state;
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
 	int ret;
-	struct debug_obj o = { .object = addr,
-			       .state = ODEBUG_STATE_NOTAVAILABLE,
-			       .descr = descr };
 
 	if (!debug_objects_enabled)
 		return 0;
 
+	debug_objects_fill_pool();
+
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);
 
-	obj = lookup_object(addr, db);
-	if (obj) {
+	obj = lookup_object_or_alloc(addr, db, descr, false, true);
+	if (likely(!IS_ERR_OR_NULL(obj))) {
 		bool print_object = false;
 
 		switch (obj->state) {
@@ -701,24 +733,16 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 
 	raw_spin_unlock_irqrestore(&db->lock, flags);
 
-	/*
-	 * We are here when a static object is activated. We
-	 * let the type specific code confirm whether this is
-	 * true or not. if true, we just make sure that the
-	 * static object is tracked in the object tracker. If
-	 * not, this must be a bug, so we try to fix it up.
-	 */
-	if (descr->is_static_object && descr->is_static_object(addr)) {
-		/* track this static object */
-		debug_object_init(addr, descr);
-		debug_object_activate(addr, descr);
-	} else {
-		debug_print_object(&o, "activate");
-		ret = debug_object_fixup(descr->fixup_activate, addr,
-					ODEBUG_STATE_NOTAVAILABLE);
-		return ret ? 0 : -EINVAL;
+	/* If NULL the allocation has hit OOM */
+	if (!obj) {
+		debug_objects_oom();
+		return 0;
 	}
-	return 0;
+
+	/* Object is neither static nor tracked. It's not initialized */
+	debug_print_object(&o, "activate");
+	ret = debug_object_fixup(descr->fixup_activate, addr, ODEBUG_STATE_NOTAVAILABLE);
+	return ret ? 0 : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(debug_object_activate);
 
@@ -872,6 +896,7 @@ EXPORT_SYMBOL_GPL(debug_object_free);
  */
 void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 {
+	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
 	struct debug_bucket *db;
 	struct debug_obj *obj;
 	unsigned long flags;
@@ -879,34 +904,25 @@ void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 	if (!debug_objects_enabled)
 		return;
 
+	debug_objects_fill_pool();
+
 	db = get_bucket((unsigned long) addr);
 
 	raw_spin_lock_irqsave(&db->lock, flags);
+	obj = lookup_object_or_alloc(addr, db, descr, false, true);
+	raw_spin_unlock_irqrestore(&db->lock, flags);
+	if (likely(!IS_ERR_OR_NULL(obj)))
+		return;
 
-	obj = lookup_object(addr, db);
+	/* If NULL the allocation has hit OOM */
 	if (!obj) {
-		struct debug_obj o = { .object = addr,
-				       .state = ODEBUG_STATE_NOTAVAILABLE,
-				       .descr = descr };
-
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-		/*
-		 * Maybe the object is static, and we let the type specific
-		 * code confirm. Track this static object if true, else invoke
-		 * fixup.
-		 */
-		if (descr->is_static_object && descr->is_static_object(addr)) {
-			/* Track this static object */
-			debug_object_init(addr, descr);
-		} else {
-			debug_print_object(&o, "assert_init");
-			debug_object_fixup(descr->fixup_assert_init, addr,
-					   ODEBUG_STATE_NOTAVAILABLE);
-		}
+		debug_objects_oom();
 		return;
 	}
 
-	raw_spin_unlock_irqrestore(&db->lock, flags);
+	/* Object is neither tracked nor static. It's not initialized. */
+	debug_print_object(&o, "assert_init");
+	debug_object_fixup(descr->fixup_assert_init, addr, ODEBUG_STATE_NOTAVAILABLE);
 }
 EXPORT_SYMBOL_GPL(debug_object_assert_init);
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 142e118ade87..afdd13276845 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -385,6 +385,15 @@ static LIST_HEAD(offline_cgwbs);
 static void cleanup_offline_cgwbs_workfn(struct work_struct *work);
 static DECLARE_WORK(cleanup_offline_cgwbs_work, cleanup_offline_cgwbs_workfn);
 
+static void cgwb_free_rcu(struct rcu_head *rcu_head)
+{
+	struct bdi_writeback *wb = container_of(rcu_head,
+			struct bdi_writeback, rcu);
+
+	percpu_ref_exit(&wb->refcnt);
+	kfree(wb);
+}
+
 static void cgwb_release_workfn(struct work_struct *work)
 {
 	struct bdi_writeback *wb = container_of(work, struct bdi_writeback,
@@ -407,10 +416,9 @@ static void cgwb_release_workfn(struct work_struct *work)
 	list_del(&wb->offline_node);
 	spin_unlock_irq(&cgwb_lock);
 
-	percpu_ref_exit(&wb->refcnt);
 	wb_exit(wb);
 	WARN_ON_ONCE(!list_empty(&wb->b_attached));
-	kfree_rcu(wb, rcu);
+	call_rcu(&wb->rcu, cgwb_free_rcu);
 }
 
 static void cgwb_release(struct percpu_ref *refcnt)
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index a54535cbcf4c..b6d456c7952e 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -365,7 +365,7 @@ static int vlan_dev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 
 	switch (cmd) {
 	case SIOCSHWTSTAMP:
-		if (!net_eq(dev_net(dev), &init_net))
+		if (!net_eq(dev_net(dev), dev_net(real_dev)))
 			break;
 		fallthrough;
 	case SIOCGMIIPHY:
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 46cc3a7632f7..d4b25d6fd01d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4960,6 +4960,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 			skb = alloc_skb(0, GFP_ATOMIC);
 	} else {
 		skb = skb_clone(orig_skb, GFP_ATOMIC);
+
+		if (skb_orphan_frags_rx(skb, GFP_ATOMIC))
+			return;
 	}
 	if (!skb)
 		return;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index ef786c6232df..ae8a456df5ab 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1555,9 +1555,19 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	cork->dst = NULL;
 	skb_dst_set(skb, &rt->dst);
 
-	if (iph->protocol == IPPROTO_ICMP)
-		icmp_out_count(net, ((struct icmphdr *)
-			skb_transport_header(skb))->type);
+	if (iph->protocol == IPPROTO_ICMP) {
+		u8 icmp_type;
+
+		/* For such sockets, transhdrlen is zero when do ip_append_data(),
+		 * so icmphdr does not in skb linear region and can not get icmp_type
+		 * by icmp_hdr(skb)->type.
+		 */
+		if (sk->sk_type == SOCK_RAW && !inet_sk(sk)->hdrincl)
+			icmp_type = fl4->fl4_icmp_type;
+		else
+			icmp_type = icmp_hdr(skb)->type;
+		icmp_out_count(net, icmp_type);
+	}
 
 	ip_cork_release(cork);
 out:
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index d950041364d5..091df8a7cb1e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4839,12 +4839,24 @@ static void nf_tables_unbind_set(const struct nft_ctx *ctx, struct nft_set *set,
 	}
 }
 
+void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	if (nft_set_is_anonymous(set))
+		nft_clear(ctx->net, set);
+
+	set->use++;
+}
+EXPORT_SYMBOL_GPL(nf_tables_activate_set);
+
 void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      struct nft_set_binding *binding,
 			      enum nft_trans_phase phase)
 {
 	switch (phase) {
 	case NFT_TRANS_PREPARE:
+		if (nft_set_is_anonymous(set))
+			nft_deactivate_next(ctx->net, set);
+
 		set->use--;
 		return;
 	case NFT_TRANS_ABORT:
@@ -8360,6 +8372,8 @@ static int nf_tables_validate(struct net *net)
 			if (nft_table_validate(net, table) < 0)
 				return -EAGAIN;
 		}
+
+		nft_validate_state_update(net, NFT_VALIDATE_SKIP);
 		break;
 	}
 
@@ -9231,11 +9245,6 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 	return 0;
 }
 
-static void nf_tables_cleanup(struct net *net)
-{
-	nft_validate_state_update(net, NFT_VALIDATE_SKIP);
-}
-
 static int nf_tables_abort(struct net *net, struct sk_buff *skb,
 			   enum nfnl_abort_action action)
 {
@@ -9269,7 +9278,6 @@ static const struct nfnetlink_subsystem nf_tables_subsys = {
 	.cb		= nf_tables_cb,
 	.commit		= nf_tables_commit,
 	.abort		= nf_tables_abort,
-	.cleanup	= nf_tables_cleanup,
 	.valid_genid	= nf_tables_valid_genid,
 	.owner		= THIS_MODULE,
 };
diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index 2cce4033a70a..4d7a2a7bbd43 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -585,8 +585,6 @@ static void nfnetlink_rcv_batch(struct sk_buff *skb, struct nlmsghdr *nlh,
 			goto replay_abort;
 		}
 	}
-	if (ss->cleanup)
-		ss->cleanup(net);
 
 	nfnl_err_deliver(&err_list, oskb);
 	kfree_skb(skb);
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 87f3af4645d9..29c7ae8789e9 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -342,7 +342,7 @@ static void nft_dynset_activate(const struct nft_ctx *ctx,
 {
 	struct nft_dynset *priv = nft_expr_priv(expr);
 
-	priv->set->use++;
+	nf_tables_activate_set(ctx, priv->set);
 }
 
 static void nft_dynset_destroy(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index bd3485dd930f..9d18c5428d53 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -167,7 +167,7 @@ static void nft_lookup_activate(const struct nft_ctx *ctx,
 {
 	struct nft_lookup *priv = nft_expr_priv(expr);
 
-	priv->set->use++;
+	nf_tables_activate_set(ctx, priv->set);
 }
 
 static void nft_lookup_destroy(const struct nft_ctx *ctx,
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index 94b2327e71dc..3ff91bcaa5f2 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -183,7 +183,7 @@ static void nft_objref_map_activate(const struct nft_ctx *ctx,
 {
 	struct nft_objref_map *priv = nft_expr_priv(expr);
 
-	priv->set->use++;
+	nf_tables_activate_set(ctx, priv->set);
 }
 
 static void nft_objref_map_destroy(const struct nft_ctx *ctx,
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 011ec7d9a719..84a7a29be49d 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1752,7 +1752,8 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	struct netlink_sock *nlk = nlk_sk(sk);
-	int len, val, err;
+	unsigned int flag;
+	int len, val;
 
 	if (level != SOL_NETLINK)
 		return -ENOPROTOOPT;
@@ -1764,39 +1765,17 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case NETLINK_PKTINFO:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_RECV_PKTINFO ? 1 : 0;
-		if (put_user(len, optlen) ||
-		    put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_RECV_PKTINFO;
 		break;
 	case NETLINK_BROADCAST_ERROR:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_BROADCAST_SEND_ERROR ? 1 : 0;
-		if (put_user(len, optlen) ||
-		    put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_BROADCAST_SEND_ERROR;
 		break;
 	case NETLINK_NO_ENOBUFS:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_RECV_NO_ENOBUFS ? 1 : 0;
-		if (put_user(len, optlen) ||
-		    put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_RECV_NO_ENOBUFS;
 		break;
 	case NETLINK_LIST_MEMBERSHIPS: {
-		int pos, idx, shift;
+		int pos, idx, shift, err = 0;
 
-		err = 0;
 		netlink_lock_table();
 		for (pos = 0; pos * 8 < nlk->ngroups; pos += sizeof(u32)) {
 			if (len - pos < sizeof(u32))
@@ -1813,40 +1792,32 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 		if (put_user(ALIGN(nlk->ngroups / 8, sizeof(u32)), optlen))
 			err = -EFAULT;
 		netlink_unlock_table();
-		break;
+		return err;
 	}
 	case NETLINK_CAP_ACK:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_CAP_ACK ? 1 : 0;
-		if (put_user(len, optlen) ||
-		    put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_CAP_ACK;
 		break;
 	case NETLINK_EXT_ACK:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_EXT_ACK ? 1 : 0;
-		if (put_user(len, optlen) || put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_EXT_ACK;
 		break;
 	case NETLINK_GET_STRICT_CHK:
-		if (len < sizeof(int))
-			return -EINVAL;
-		len = sizeof(int);
-		val = nlk->flags & NETLINK_F_STRICT_CHK ? 1 : 0;
-		if (put_user(len, optlen) || put_user(val, optval))
-			return -EFAULT;
-		err = 0;
+		flag = NETLINK_F_STRICT_CHK;
 		break;
 	default:
-		err = -ENOPROTOOPT;
+		return -ENOPROTOOPT;
 	}
-	return err;
+
+	if (len < sizeof(int))
+		return -EINVAL;
+
+	len = sizeof(int);
+	val = nlk->flags & flag ? 1 : 0;
+
+	if (put_user(len, optlen) ||
+	    copy_to_user(optval, &val, len))
+		return -EFAULT;
+
+	return 0;
 }
 
 static void netlink_cmsg_recv_pktinfo(struct msghdr *msg, struct sk_buff *skb)
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 7f9f2d0ef0e6..0db871edd3a1 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -271,7 +271,8 @@ static void packet_cached_dev_reset(struct packet_sock *po)
 
 static bool packet_use_direct_xmit(const struct packet_sock *po)
 {
-	return po->xmit == packet_direct_xmit;
+	/* Paired with WRITE_ONCE() in packet_setsockopt() */
+	return READ_ONCE(po->xmit) == packet_direct_xmit;
 }
 
 static u16 packet_pick_tx_queue(struct sk_buff *skb)
@@ -2148,7 +2149,7 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll = &PACKET_SKB_CB(skb)->sa.ll;
 	sll->sll_hatype = dev->type;
 	sll->sll_pkttype = skb->pkt_type;
-	if (unlikely(po->origdev))
+	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
 	else
 		sll->sll_ifindex = dev->ifindex;
@@ -2421,7 +2422,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_hatype = dev->type;
 	sll->sll_protocol = skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
-	if (unlikely(po->origdev))
+	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
 	else
 		sll->sll_ifindex = dev->ifindex;
@@ -2828,7 +2829,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		packet_inc_pending(&po->tx_ring);
 
 		status = TP_STATUS_SEND_REQUEST;
-		err = po->xmit(skb);
+		/* Paired with WRITE_ONCE() in packet_setsockopt() */
+		err = READ_ONCE(po->xmit)(skb);
 		if (unlikely(err != 0)) {
 			if (err > 0)
 				err = net_xmit_errno(err);
@@ -3031,7 +3033,8 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		virtio_net_hdr_set_proto(skb, &vnet_hdr);
 	}
 
-	err = po->xmit(skb);
+	/* Paired with WRITE_ONCE() in packet_setsockopt() */
+	err = READ_ONCE(po->xmit)(skb);
 	if (unlikely(err != 0)) {
 		if (err > 0)
 			err = net_xmit_errno(err);
@@ -3482,7 +3485,7 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		memcpy(msg->msg_name, &PACKET_SKB_CB(skb)->sa, copy_len);
 	}
 
-	if (pkt_sk(sk)->auxdata) {
+	if (packet_sock_flag(pkt_sk(sk), PACKET_SOCK_AUXDATA)) {
 		struct tpacket_auxdata aux;
 
 		aux.tp_status = TP_STATUS_USER;
@@ -3866,9 +3869,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 
-		lock_sock(sk);
-		po->auxdata = !!val;
-		release_sock(sk);
+		packet_sock_flag_set(po, PACKET_SOCK_AUXDATA, val);
 		return 0;
 	}
 	case PACKET_ORIGDEV:
@@ -3880,9 +3881,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 
-		lock_sock(sk);
-		po->origdev = !!val;
-		release_sock(sk);
+		packet_sock_flag_set(po, PACKET_SOCK_ORIGDEV, val);
 		return 0;
 	}
 	case PACKET_VNET_HDR:
@@ -3976,7 +3975,8 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 		if (copy_from_sockptr(&val, optval, sizeof(val)))
 			return -EFAULT;
 
-		po->xmit = val ? packet_direct_xmit : dev_queue_xmit;
+		/* Paired with all lockless reads of po->xmit */
+		WRITE_ONCE(po->xmit, val ? packet_direct_xmit : dev_queue_xmit);
 		return 0;
 	}
 	default:
@@ -4027,10 +4027,10 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
 
 		break;
 	case PACKET_AUXDATA:
-		val = po->auxdata;
+		val = packet_sock_flag(po, PACKET_SOCK_AUXDATA);
 		break;
 	case PACKET_ORIGDEV:
-		val = po->origdev;
+		val = packet_sock_flag(po, PACKET_SOCK_ORIGDEV);
 		break;
 	case PACKET_VNET_HDR:
 		val = po->has_vnet_hdr;
diff --git a/net/packet/diag.c b/net/packet/diag.c
index 07812ae5ca07..d704c7bf51b2 100644
--- a/net/packet/diag.c
+++ b/net/packet/diag.c
@@ -23,9 +23,9 @@ static int pdiag_put_info(const struct packet_sock *po, struct sk_buff *nlskb)
 	pinfo.pdi_flags = 0;
 	if (po->running)
 		pinfo.pdi_flags |= PDI_RUNNING;
-	if (po->auxdata)
+	if (packet_sock_flag(po, PACKET_SOCK_AUXDATA))
 		pinfo.pdi_flags |= PDI_AUXDATA;
-	if (po->origdev)
+	if (packet_sock_flag(po, PACKET_SOCK_ORIGDEV))
 		pinfo.pdi_flags |= PDI_ORIGDEV;
 	if (po->has_vnet_hdr)
 		pinfo.pdi_flags |= PDI_VNETHDR;
diff --git a/net/packet/internal.h b/net/packet/internal.h
index 48af35b1aed2..3bae8ea7a36f 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -116,10 +116,9 @@ struct packet_sock {
 	int			copy_thresh;
 	spinlock_t		bind_lock;
 	struct mutex		pg_vec_lock;
+	unsigned long		flags;
 	unsigned int		running;	/* bind_lock must be held */
-	unsigned int		auxdata:1,	/* writer must hold sock lock */
-				origdev:1,
-				has_vnet_hdr:1,
+	unsigned int		has_vnet_hdr:1, /* writer must hold sock lock */
 				tp_loss:1,
 				tp_tx_has_off:1;
 	int			pressure;
@@ -144,4 +143,25 @@ static inline struct packet_sock *pkt_sk(struct sock *sk)
 	return (struct packet_sock *)sk;
 }
 
+enum packet_sock_flags {
+	PACKET_SOCK_ORIGDEV,
+	PACKET_SOCK_AUXDATA,
+};
+
+static inline void packet_sock_flag_set(struct packet_sock *po,
+					enum packet_sock_flags flag,
+					bool val)
+{
+	if (val)
+		set_bit(flag, &po->flags);
+	else
+		clear_bit(flag, &po->flags);
+}
+
+static inline bool packet_sock_flag(const struct packet_sock *po,
+				    enum packet_sock_flags flag)
+{
+	return test_bit(flag, &po->flags);
+}
+
 #endif
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 2fb76fc0cc31..5a1274199fe3 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -779,13 +779,17 @@ static int fq_resize(struct Qdisc *sch, u32 log)
 	return 0;
 }
 
+static struct netlink_range_validation iq_range = {
+	.max = INT_MAX,
+};
+
 static const struct nla_policy fq_policy[TCA_FQ_MAX + 1] = {
 	[TCA_FQ_UNSPEC]			= { .strict_start_type = TCA_FQ_TIMER_SLACK },
 
 	[TCA_FQ_PLIMIT]			= { .type = NLA_U32 },
 	[TCA_FQ_FLOW_PLIMIT]		= { .type = NLA_U32 },
 	[TCA_FQ_QUANTUM]		= { .type = NLA_U32 },
-	[TCA_FQ_INITIAL_QUANTUM]	= { .type = NLA_U32 },
+	[TCA_FQ_INITIAL_QUANTUM]	= NLA_POLICY_FULL_RANGE(NLA_U32, &iq_range),
 	[TCA_FQ_RATE_ENABLE]		= { .type = NLA_U32 },
 	[TCA_FQ_FLOW_DEFAULT_RATE]	= { .type = NLA_U32 },
 	[TCA_FQ_FLOW_MAX_RATE]		= { .type = NLA_U32 },
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index ad3e9a40b061..b9c54c03c30a 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1981,9 +1981,6 @@ call_bind_status(struct rpc_task *task)
 			status = -EOPNOTSUPP;
 			break;
 		}
-		if (task->tk_rebind_retry == 0)
-			break;
-		task->tk_rebind_retry--;
 		rpc_delay(task, 3*HZ);
 		goto retry_timeout;
 	case -ENOBUFS:
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index f0f55fbd1375..a00890962e11 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -796,7 +796,6 @@ rpc_init_task_statistics(struct rpc_task *task)
 	/* Initialize retry counters */
 	task->tk_garb_retry = 2;
 	task->tk_cred_retry = 2;
-	task->tk_rebind_retry = 2;
 
 	/* starting timestamp */
 	task->tk_start = ktime_get();
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index cca1fce8035c..6b4df83aa28f 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -157,6 +157,7 @@ static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
 		return false;
 
 	if (base_addr >= pool->addrs_cnt || addr >= pool->addrs_cnt ||
+	    addr + desc->len > pool->addrs_cnt ||
 	    xp_desc_crosses_non_contig_pg(pool, addr, desc->len))
 		return false;
 
diff --git a/scripts/gdb/linux/clk.py b/scripts/gdb/linux/clk.py
index 061aecfa294e..7a01fdc3e844 100644
--- a/scripts/gdb/linux/clk.py
+++ b/scripts/gdb/linux/clk.py
@@ -41,6 +41,8 @@ are cached and potentially out of date"""
             self.show_subtree(child, level + 1)
 
     def invoke(self, arg, from_tty):
+        if utils.gdb_eval_or_none("clk_root_list") is None:
+            raise gdb.GdbError("No clocks registered")
         gdb.write("                                 enable  prepare  protect               \n")
         gdb.write("   clock                          count    count    count        rate   \n")
         gdb.write("------------------------------------------------------------------------\n")
diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 2efbec6b6b8d..08f0587d15ea 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -39,6 +39,8 @@
 
 import gdb
 
+LX_CONFIG(CONFIG_DEBUG_INFO_REDUCED)
+
 /* linux/clk-provider.h */
 if IS_BUILTIN(CONFIG_COMMON_CLK):
     LX_GDBPARSED(CLK_GET_RATE_NOCACHE)
diff --git a/scripts/gdb/linux/genpd.py b/scripts/gdb/linux/genpd.py
index 39cd1abd8559..b53649c0a77a 100644
--- a/scripts/gdb/linux/genpd.py
+++ b/scripts/gdb/linux/genpd.py
@@ -5,7 +5,7 @@
 import gdb
 import sys
 
-from linux.utils import CachedType
+from linux.utils import CachedType, gdb_eval_or_none
 from linux.lists import list_for_each_entry
 
 generic_pm_domain_type = CachedType('struct generic_pm_domain')
@@ -70,6 +70,8 @@ Output is similar to /sys/kernel/debug/pm_genpd/pm_genpd_summary'''
             gdb.write('    %-50s  %s\n' % (kobj_path, rtpm_status_str(dev)))
 
     def invoke(self, arg, from_tty):
+        if gdb_eval_or_none("&gpd_list") is None:
+            raise gdb.GdbError("No power domain(s) registered")
         gdb.write('domain                          status          children\n');
         gdb.write('    /device                                             runtime status\n');
         gdb.write('----------------------------------------------------------------------\n');
diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index 071d0dd5a634..51def847f1ef 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -73,7 +73,7 @@ def print_cpu(hrtimer_bases, cpu, max_clock_bases):
     ts = cpus.per_cpu(tick_sched_ptr, cpu)
 
     text = "cpu: {}\n".format(cpu)
-    for i in xrange(max_clock_bases):
+    for i in range(max_clock_bases):
         text += " clock {}:\n".format(i)
         text += print_base(cpu_base['clock_base'][i])
 
@@ -158,6 +158,8 @@ def pr_cpumask(mask):
     num_bytes = (nr_cpu_ids + 7) / 8
     buf = utils.read_memoryview(inf, bits, num_bytes).tobytes()
     buf = binascii.b2a_hex(buf)
+    if type(buf) is not str:
+        buf=buf.decode()
 
     chunks = []
     i = num_bytes
diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
index 1553f68716cc..7f36aee32ac6 100644
--- a/scripts/gdb/linux/utils.py
+++ b/scripts/gdb/linux/utils.py
@@ -88,7 +88,10 @@ def get_target_endianness():
 
 
 def read_memoryview(inf, start, length):
-    return memoryview(inf.read_memory(start, length))
+    m = inf.read_memory(start, length)
+    if type(m) is memoryview:
+        return m
+    return memoryview(m)
 
 
 def read_u16(buffer, offset):
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index 4136dc2c59df..cd03de50c3be 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -22,6 +22,10 @@ except:
     gdb.write("NOTE: gdb 7.2 or later required for Linux helper scripts to "
               "work.\n")
 else:
+    import linux.constants
+    if linux.constants.LX_CONFIG_DEBUG_INFO_REDUCED:
+        raise gdb.GdbError("Reduced debug information will prevent GDB "
+                           "from having complete types.\n")
     import linux.utils
     import linux.symbols
     import linux.modules
@@ -32,7 +36,6 @@ else:
     import linux.lists
     import linux.rbtree
     import linux.proc
-    import linux.constants
     import linux.timerlist
     import linux.clk
     import linux.genpd
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 7249f16257c7..5d2c8990d1ac 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -8,7 +8,7 @@ config IMA
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
 	select CRYPTO_HASH_INFO
-	select TCG_TPM if HAS_IOMEM && !UML
+	select TCG_TPM if HAS_IOMEM
 	select TCG_TIS if TCG_TPM && X86
 	select TCG_CRB if TCG_TPM && ACPI
 	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES
diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 776162444882..0aecf9334ec3 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -23,8 +23,8 @@ ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
 $(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h
 
 quiet_cmd_flask = GEN     $(obj)/flask.h $(obj)/av_permissions.h
-      cmd_flask = scripts/selinux/genheaders/genheaders $(obj)/flask.h $(obj)/av_permissions.h
+      cmd_flask = $< $(obj)/flask.h $(obj)/av_permissions.h
 
 targets += flask.h av_permissions.h
-$(obj)/flask.h: $(src)/include/classmap.h FORCE
+$(obj)/flask.h $(obj)/av_permissions.h &: scripts/selinux/genheaders/genheaders FORCE
 	$(call if_changed,flask)
diff --git a/sound/oss/dmasound/dmasound.h b/sound/oss/dmasound/dmasound.h
index c1c52b479da2..ad8ce6a1c25c 100644
--- a/sound/oss/dmasound/dmasound.h
+++ b/sound/oss/dmasound/dmasound.h
@@ -88,11 +88,7 @@ static inline int ioctl_return(int __user *addr, int value)
      */
 
 extern int dmasound_init(void);
-#ifdef MODULE
 extern void dmasound_deinit(void);
-#else
-#define dmasound_deinit()	do { } while (0)
-#endif
 
 /* description of the set-up applies to either hard or soft settings */
 
@@ -114,9 +110,7 @@ typedef struct {
     void *(*dma_alloc)(unsigned int, gfp_t);
     void (*dma_free)(void *, unsigned int);
     int (*irqinit)(void);
-#ifdef MODULE
     void (*irqcleanup)(void);
-#endif
     void (*init)(void);
     void (*silence)(void);
     int (*setFormat)(int);
diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
index 0c95828ac0b1..164335d3c200 100644
--- a/sound/oss/dmasound/dmasound_core.c
+++ b/sound/oss/dmasound/dmasound_core.c
@@ -206,12 +206,10 @@ module_param(writeBufSize, int, 0);
 
 MODULE_LICENSE("GPL");
 
-#ifdef MODULE
 static int sq_unit = -1;
 static int mixer_unit = -1;
 static int state_unit = -1;
 static int irq_installed;
-#endif /* MODULE */
 
 /* control over who can modify resources shared between play/record */
 static fmode_t shared_resource_owner;
@@ -391,9 +389,6 @@ static const struct file_operations mixer_fops =
 
 static void mixer_init(void)
 {
-#ifndef MODULE
-	int mixer_unit;
-#endif
 	mixer_unit = register_sound_mixer(&mixer_fops, -1);
 	if (mixer_unit < 0)
 		return;
@@ -1171,9 +1166,6 @@ static const struct file_operations sq_fops =
 static int sq_init(void)
 {
 	const struct file_operations *fops = &sq_fops;
-#ifndef MODULE
-	int sq_unit;
-#endif
 
 	sq_unit = register_sound_dsp(fops, -1);
 	if (sq_unit < 0) {
@@ -1366,9 +1358,6 @@ static const struct file_operations state_fops = {
 
 static int state_init(void)
 {
-#ifndef MODULE
-	int state_unit;
-#endif
 	state_unit = register_sound_special(&state_fops, SND_DEV_STATUS);
 	if (state_unit < 0)
 		return state_unit ;
@@ -1386,10 +1375,9 @@ static int state_init(void)
 int dmasound_init(void)
 {
 	int res ;
-#ifdef MODULE
+
 	if (irq_installed)
 		return -EBUSY;
-#endif
 
 	/* Set up sound queue, /dev/audio and /dev/dsp. */
 
@@ -1408,9 +1396,7 @@ int dmasound_init(void)
 		printk(KERN_ERR "DMA sound driver: Interrupt initialization failed\n");
 		return -ENODEV;
 	}
-#ifdef MODULE
 	irq_installed = 1;
-#endif
 
 	printk(KERN_INFO "%s DMA sound driver rev %03d installed\n",
 		dmasound.mach.name, (DMASOUND_CORE_REVISION<<4) +
@@ -1424,8 +1410,6 @@ int dmasound_init(void)
 	return 0;
 }
 
-#ifdef MODULE
-
 void dmasound_deinit(void)
 {
 	if (irq_installed) {
@@ -1444,9 +1428,7 @@ void dmasound_deinit(void)
 		unregister_sound_dsp(sq_unit);
 }
 
-#else /* !MODULE */
-
-static int dmasound_setup(char *str)
+static int __maybe_unused dmasound_setup(char *str)
 {
 	int ints[6], size;
 
@@ -1489,8 +1471,6 @@ static int dmasound_setup(char *str)
 
 __setup("dmasound=", dmasound_setup);
 
-#endif /* !MODULE */
-
     /*
      *  Conversion tables
      */
@@ -1577,9 +1557,7 @@ char dmasound_alaw2dma8[] = {
 
 EXPORT_SYMBOL(dmasound);
 EXPORT_SYMBOL(dmasound_init);
-#ifdef MODULE
 EXPORT_SYMBOL(dmasound_deinit);
-#endif
 EXPORT_SYMBOL(dmasound_write_sq);
 EXPORT_SYMBOL(dmasound_catchRadius);
 #ifdef HAS_8BIT_TABLES
diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 5fb02635c140..afd6d401e3d0 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -810,12 +810,14 @@ static int es8316_i2c_probe(struct i2c_client *i2c_client,
 	es8316->irq = i2c_client->irq;
 	mutex_init(&es8316->lock);
 
-	ret = devm_request_threaded_irq(dev, es8316->irq, NULL, es8316_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_AUTOEN,
-					"es8316", es8316);
-	if (ret) {
-		dev_warn(dev, "Failed to get IRQ %d: %d\n", es8316->irq, ret);
-		es8316->irq = -ENXIO;
+	if (es8316->irq > 0) {
+		ret = devm_request_threaded_irq(dev, es8316->irq, NULL, es8316_irq,
+						IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_AUTOEN,
+						"es8316", es8316);
+		if (ret) {
+			dev_warn(dev, "Failed to get IRQ %d: %d\n", es8316->irq, ret);
+			es8316->irq = -ENXIO;
+		}
 	}
 
 	return devm_snd_soc_register_component(&i2c_client->dev,
diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
index 0d4efbed41da..c33439650823 100644
--- a/sound/soc/fsl/fsl_mqs.c
+++ b/sound/soc/fsl/fsl_mqs.c
@@ -204,10 +204,10 @@ static int fsl_mqs_probe(struct platform_device *pdev)
 		}
 
 		mqs_priv->regmap = syscon_node_to_regmap(gpr_np);
+		of_node_put(gpr_np);
 		if (IS_ERR(mqs_priv->regmap)) {
 			dev_err(&pdev->dev, "failed to get gpr regmap\n");
-			ret = PTR_ERR(mqs_priv->regmap);
-			goto err_free_gpr_np;
+			return PTR_ERR(mqs_priv->regmap);
 		}
 	} else {
 		regs = devm_platform_ioremap_resource(pdev, 0);
@@ -236,8 +236,7 @@ static int fsl_mqs_probe(struct platform_device *pdev)
 	if (IS_ERR(mqs_priv->mclk)) {
 		dev_err(&pdev->dev, "failed to get the clock: %ld\n",
 			PTR_ERR(mqs_priv->mclk));
-		ret = PTR_ERR(mqs_priv->mclk);
-		goto err_free_gpr_np;
+		return PTR_ERR(mqs_priv->mclk);
 	}
 
 	dev_set_drvdata(&pdev->dev, mqs_priv);
@@ -246,13 +245,9 @@ static int fsl_mqs_probe(struct platform_device *pdev)
 	ret = devm_snd_soc_register_component(&pdev->dev, &soc_codec_fsl_mqs,
 			&fsl_mqs_dai, 1);
 	if (ret)
-		goto err_free_gpr_np;
-	return 0;
-
-err_free_gpr_np:
-	of_node_put(gpr_np);
+		return ret;
 
-	return ret;
+	return 0;
 }
 
 static int fsl_mqs_remove(struct platform_device *pdev)
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 5f6e2bb32440..4df1be8170bb 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -533,6 +533,18 @@ static int byt_rt5640_aif1_hw_params(struct snd_pcm_substream *substream,
 
 /* Please keep this list alphabetically sorted */
 static const struct dmi_system_id byt_rt5640_quirk_table[] = {
+	{	/* Acer Iconia One 7 B1-750 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "VESPA2"),
+		},
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_JD_SRC_JD1_IN4P |
+					BYT_RT5640_OVCD_TH_1500UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* Acer Iconia Tab 8 W1-810 */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Acer"),
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 2d53a707aff9..089b6c7994f9 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -212,6 +212,17 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 					SOF_SDW_PCH_DMIC |
 					RT711_JD1),
 	},
+	{
+		/* NUC15 'Rooks County' LAPRC510 and LAPRC710 skews */
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel(R) Client Systems"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LAPRC"),
+		},
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					SOF_SDW_PCH_DMIC |
+					RT711_JD2_100K),
+	},
 	/* TigerLake-SDCA devices */
 	{
 		.callback = sof_sdw_quirk_cb,
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 3b673477f621..6f616ac4490f 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1554,10 +1554,14 @@ static void dpcm_runtime_setup_fe(struct snd_pcm_substream *substream)
 	struct snd_pcm_hardware *hw = &runtime->hw;
 	struct snd_soc_dai *dai;
 	int stream = substream->stream;
+	u64 formats = hw->formats;
 	int i;
 
 	soc_pcm_hw_init(hw);
 
+	if (formats)
+		hw->formats &= formats;
+
 	for_each_rtd_cpu_dais(fe, i, dai) {
 		struct snd_soc_pcm_stream *cpu_stream;
 
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index b2f896e86353..efe62f19c4d2 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3808,6 +3808,64 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 
+{
+	/*
+	 * PIONEER DJ DDJ-800
+	 * PCM is 6 channels out, 6 channels in @ 44.1 fixed
+	 * The Feedback for the output is the input
+	 */
+	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x0029),
+		.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 6,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x01,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
+						USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_44100,
+					.rate_min = 44100,
+					.rate_max = 44100,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) { 44100 }
+				}
+			},
+			{
+				.ifnum = 0,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 6,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x82,
+					.ep_idx = 1,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC|
+						USB_ENDPOINT_SYNC_ASYNC|
+					USB_ENDPOINT_USAGE_IMPLICIT_FB,
+					.rates = SNDRV_PCM_RATE_44100,
+					.rate_min = 44100,
+					.rate_max = 44100,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) { 44100 }
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
+
 /*
  * MacroSilicon MS2100/MS2106 based AV capture cards
  *
diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index 4f1c4b0c29e9..9914bdf4fc9e 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -184,8 +184,8 @@
 	 7,    0,  EBX,     27, avx512er, AVX512 Exponent Reciproca instr
 	 7,    0,  EBX,     28, avx512cd, AVX512 Conflict Detection instr
 	 7,    0,  EBX,     29, sha, Intel Secure Hash Algorithm Extensions instr
-	 7,    0,  EBX,     26, avx512bw, AVX512 Byte & Word instr
-	 7,    0,  EBX,     28, avx512vl, AVX512 Vector Length Extentions (VL)
+	 7,    0,  EBX,     30, avx512bw, AVX512 Byte & Word instr
+	 7,    0,  EBX,     31, avx512vl, AVX512 Vector Length Extentions (VL)
 	 7,    0,  ECX,      0, prefetchwt1, X
 	 7,    0,  ECX,      1, avx512vbmi, AVX512 Vector Byte Manipulation Instructions
 	 7,    0,  ECX,      2, umip, User-mode Instruction Prevention
diff --git a/tools/bpf/bpftool/json_writer.c b/tools/bpf/bpftool/json_writer.c
index 7fea83bedf48..bca5dd0a59e3 100644
--- a/tools/bpf/bpftool/json_writer.c
+++ b/tools/bpf/bpftool/json_writer.c
@@ -80,9 +80,6 @@ static void jsonw_puts(json_writer_t *self, const char *str)
 		case '"':
 			fputs("\\\"", self->out);
 			break;
-		case '\'':
-			fputs("\\\'", self->out);
-			break;
 		default:
 			putc(*str, self->out);
 		}
diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index f1f32e21d5cd..b91c62d0a7d6 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -369,8 +369,15 @@ void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
 	struct bpf_insn *insn_start = buf_start;
 	struct bpf_insn *insn_end = buf_end;
 	struct bpf_insn *cur = insn_start;
+	bool double_insn = false;
 
 	for (; cur <= insn_end; cur++) {
+		if (double_insn) {
+			double_insn = false;
+			continue;
+		}
+		double_insn = cur->code == (BPF_LD | BPF_IMM | BPF_DW);
+
 		printf("% 4d: ", (int)(cur - insn_start + start_idx));
 		print_bpf_insn(&cbs, cur, true);
 		if (cur != insn_end)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 32f119e8c3b2..f331780f0425 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2481,17 +2481,6 @@ static int update_cfi_state(struct instruction *insn,
 				break;
 			}
 
-			if (!cfi->drap && op->src.reg == CFI_SP &&
-			    op->dest.reg == CFI_BP && cfa->base == CFI_SP &&
-			    check_reg_frame_pos(&regs[CFI_BP], -cfa->offset + op->src.offset)) {
-
-				/* lea disp(%rsp), %rbp */
-				cfa->base = CFI_BP;
-				cfa->offset -= op->src.offset;
-				cfi->bp_scratch = false;
-				break;
-			}
-
 			if (op->src.reg == CFI_SP && cfa->base == CFI_SP) {
 
 				/* drap: lea disp(%rsp), %drap */
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 344b65a8f768..4461a29e2771 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2378,6 +2378,7 @@ static int find_entire_kern_cb(void *arg, const char *name __maybe_unused,
 			       char type, u64 start)
 {
 	struct sym_args *args = arg;
+	u64 size;
 
 	if (!kallsyms__is_function(type))
 		return 0;
@@ -2387,7 +2388,9 @@ static int find_entire_kern_cb(void *arg, const char *name __maybe_unused,
 		args->start = start;
 	}
 	/* Don't know exactly where the kernel ends, so we add a page */
-	args->size = round_up(start, page_size) + page_size - args->start;
+	size = round_up(start, page_size) + page_size - args->start;
+	if (size > args->size)
+		args->size = size;
 
 	return 0;
 }
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 372ffec96c2d..b9f94f198a3e 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1859,6 +1859,8 @@ static void intel_pt_calc_cbr(struct intel_pt_decoder *decoder)
 
 	decoder->cbr = cbr;
 	decoder->cbr_cyc_to_tsc = decoder->max_non_turbo_ratio_fp / cbr;
+	decoder->cyc_ref_timestamp = decoder->timestamp;
+	decoder->cycle_cnt = 0;
 
 	intel_pt_mtc_cyc_cnt_cbr(decoder);
 }
diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 6db1af8fdee7..c57e1e47e52f 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -84,7 +84,7 @@ static int __start_server(int type, const struct sockaddr *addr,
 	if (reuseport &&
 	    setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &on, sizeof(on))) {
 		log_err("Failed to set SO_REUSEPORT");
-		return -1;
+		goto error_close;
 	}
 
 	if (bind(fd, addr, addrlen) < 0) {
diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
index 876be0ecb654..a47ea4804766 100644
--- a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
@@ -56,8 +56,9 @@ static bool assert_storage_noexist(struct bpf_map *map, const void *key)
 
 static bool connect_send(const char *cgroup_path)
 {
-	bool res = true;
 	int server_fd = -1, client_fd = -1;
+	char message[] = "message";
+	bool res = true;
 
 	if (join_cgroup(cgroup_path))
 		goto out_clean;
@@ -70,7 +71,10 @@ static bool connect_send(const char *cgroup_path)
 	if (client_fd < 0)
 		goto out_clean;
 
-	if (send(client_fd, "message", strlen("message"), 0) < 0)
+	if (send(client_fd, &message, sizeof(message), 0) < 0)
+		goto out_clean;
+
+	if (read(server_fd, &message, sizeof(message)) < 0)
 		goto out_clean;
 
 	res = false;
diff --git a/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c b/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c
index 8d5a6023a1bb..4022c89ea268 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_stackid_cannot_attach.c
@@ -65,6 +65,7 @@ void test_get_stackid_cannot_attach(void)
 	skel->links.oncpu = bpf_program__attach_perf_event(skel->progs.oncpu,
 							   pmu_fd);
 	ASSERT_OK_PTR(skel->links.oncpu, "attach_perf_event_callchain");
+	bpf_link__destroy(skel->links.oncpu);
 	close(pmu_fd);
 
 	/* add exclude_callchain_kernel, attach should fail */
diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index cd7bf32e6a17..661995af7560 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -106,6 +106,7 @@ setup_vethPairs() {
 	ip link add ${VETH0} numtxqueues 4 numrxqueues 4 type veth peer name ${VETH1} numtxqueues 4 numrxqueues 4
 	if [ -f /proc/net/if_inet6 ]; then
 		echo 1 > /proc/sys/net/ipv6/conf/${VETH0}/disable_ipv6
+		echo 1 > /proc/sys/net/ipv6/conf/${VETH1}/disable_ipv6
 	fi
 	if [[ $verbose -eq 1 ]]; then
 	        echo "setting up ${VETH1}: namespace: ${NS1}"
diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 8c5fea68ae67..969647228817 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -18,6 +18,7 @@
 #include <grp.h>
 #include <stdbool.h>
 #include <stdarg.h>
+#include <linux/mount.h>
 
 #include "../kselftest_harness.h"
 
diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 68ff856d36f0..0485863a169f 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -244,10 +244,12 @@ int cat_val(struct resctrl_val_param *param)
 	while (1) {
 		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
 			ret = param->setup(1, param);
-			if (ret) {
+			if (ret == END_OF_TESTS) {
 				ret = 0;
 				break;
 			}
+			if (ret < 0)
+				break;
 			ret = reset_enable_llc_perf(bm_pid, param->cpu_no);
 			if (ret)
 				break;
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index cd4f68388e0f..2d3c7c77ab6c 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -40,7 +40,7 @@ static int cat_setup(int num, ...)
 
 	/* Run NUM_OF_RUNS times */
 	if (p->num_of_runs >= NUM_OF_RUNS)
-		return -1;
+		return END_OF_TESTS;
 
 	if (p->num_of_runs == 0) {
 		sprintf(schemata, "%lx", p->mask);
@@ -89,7 +89,7 @@ static int check_results(struct resctrl_val_param *param)
 
 	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span / 64,
 			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
-			       !is_amd, false);
+			       get_vendor() == ARCH_INTEL, false);
 }
 
 void cat_test_cleanup(void)
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 8968e36db99d..3b0454e7fc82 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -32,7 +32,7 @@ static int cmt_setup(int num, ...)
 
 	/* Run NUM_OF_RUNS times */
 	if (p->num_of_runs >= NUM_OF_RUNS)
-		return -1;
+		return END_OF_TESTS;
 
 	p->num_of_runs++;
 
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 56ccbeae0638..c20d0a7ecbe6 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -68,6 +68,8 @@ static void *malloc_and_init_memory(size_t s)
 	size_t s64;
 
 	void *p = memalign(PAGE_SIZE, s);
+	if (!p)
+		return NULL;
 
 	p64 = (uint64_t *)p;
 	s64 = s / sizeof(uint64_t);
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 1a1bdb6180cf..97dc98c0c949 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -28,6 +28,7 @@ static int mba_setup(int num, ...)
 	struct resctrl_val_param *p;
 	char allocation_str[64];
 	va_list param;
+	int ret;
 
 	va_start(param, num);
 	p = va_arg(param, struct resctrl_val_param *);
@@ -41,11 +42,15 @@ static int mba_setup(int num, ...)
 		return 0;
 
 	if (allocation < ALLOCATION_MIN || allocation > ALLOCATION_MAX)
-		return -1;
+		return END_OF_TESTS;
 
 	sprintf(allocation_str, "%d", allocation);
 
-	write_schemata(p->ctrlgrp, allocation_str, p->cpu_no, p->resctrl_val);
+	ret = write_schemata(p->ctrlgrp, allocation_str, p->cpu_no,
+			     p->resctrl_val);
+	if (ret < 0)
+		return ret;
+
 	allocation -= ALLOCATION_STEP;
 
 	return 0;
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 8392e5c55ed0..280187628054 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -95,7 +95,7 @@ static int mbm_setup(int num, ...)
 
 	/* Run NUM_OF_RUNS times */
 	if (num_of_runs++ >= NUM_OF_RUNS)
-		return -1;
+		return END_OF_TESTS;
 
 	va_start(param, num);
 	p = va_arg(param, struct resctrl_val_param *);
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 1ad10c47e31d..f44fa2de4d98 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -34,6 +34,11 @@
 #define L3_MON_PATH		"/sys/fs/resctrl/info/L3_MON"
 #define L3_MON_FEATURES_PATH	"/sys/fs/resctrl/info/L3_MON/mon_features"
 
+#define ARCH_INTEL     1
+#define ARCH_AMD       2
+
+#define END_OF_TESTS	1
+
 #define PARENT_EXIT(err_msg)			\
 	do {					\
 		perror(err_msg);		\
@@ -75,8 +80,8 @@ struct resctrl_val_param {
 extern pid_t bm_pid, ppid;
 
 extern char llc_occup_path[1024];
-extern bool is_amd;
 
+int get_vendor(void);
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
 int remount_resctrlfs(bool mum_resctrlfs);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 973f09a66e1e..3e7cdf1125df 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -13,25 +13,41 @@
 #define BENCHMARK_ARGS		64
 #define BENCHMARK_ARG_SIZE	64
 
-bool is_amd;
-
-void detect_amd(void)
+static int detect_vendor(void)
 {
 	FILE *inf = fopen("/proc/cpuinfo", "r");
+	int vendor_id = 0;
+	char *s = NULL;
 	char *res;
 
 	if (!inf)
-		return;
+		return vendor_id;
 
 	res = fgrep(inf, "vendor_id");
 
-	if (res) {
-		char *s = strchr(res, ':');
+	if (res)
+		s = strchr(res, ':');
+
+	if (s && !strcmp(s, ": GenuineIntel\n"))
+		vendor_id = ARCH_INTEL;
+	else if (s && !strcmp(s, ": AuthenticAMD\n"))
+		vendor_id = ARCH_AMD;
 
-		is_amd = s && !strcmp(s, ": AuthenticAMD\n");
-		free(res);
-	}
 	fclose(inf);
+	free(res);
+	return vendor_id;
+}
+
+int get_vendor(void)
+{
+	static int vendor = -1;
+
+	if (vendor == -1)
+		vendor = detect_vendor();
+	if (vendor == 0)
+		ksft_print_msg("Can not get vendor info...\n");
+
+	return vendor;
 }
 
 static void cmd_help(void)
@@ -207,9 +223,6 @@ int main(int argc, char **argv)
 	if (geteuid() != 0)
 		return ksft_exit_fail_msg("Not running as root, abort testing.\n");
 
-	/* Detect AMD vendor */
-	detect_amd();
-
 	if (has_ben) {
 		/* Extract benchmark command from command line. */
 		for (i = ben_ind; i < argc; i++) {
@@ -241,10 +254,10 @@ int main(int argc, char **argv)
 
 	ksft_set_plan(tests ? : 4);
 
-	if (!is_amd && mbm_test)
+	if ((get_vendor() == ARCH_INTEL) && mbm_test)
 		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
-	if (!is_amd && mba_test)
+	if ((get_vendor() == ARCH_INTEL) && mba_test)
 		run_mba_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
 	if (cmt_test)
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 95224345c78e..02110e7ee636 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -733,29 +733,24 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
+		ret = param->setup(1, param);
+		if (ret == END_OF_TESTS) {
+			ret = 0;
+			break;
+		}
+		if (ret < 0)
+			break;
+
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-			ret = param->setup(1, param);
-			if (ret) {
-				ret = 0;
-				break;
-			}
-
 			ret = measure_vals(param, &bw_resc_start);
 			if (ret)
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-			ret = param->setup(1, param);
-			if (ret) {
-				ret = 0;
-				break;
-			}
 			sleep(1);
 			ret = measure_cache_vals(param, bm_pid);
 			if (ret)
 				break;
-		} else {
-			break;
 		}
 	}
 
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 5f5a166ade60..6f543e470ad4 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -106,7 +106,7 @@ int get_resource_id(int cpu_no, int *resource_id)
 	char phys_pkg_path[1024];
 	FILE *fp;
 
-	if (is_amd)
+	if (get_vendor() == ARCH_AMD)
 		sprintf(phys_pkg_path, "%s%d/cache/index3/id",
 			PHYS_ID_PATH, cpu_no);
 	else
