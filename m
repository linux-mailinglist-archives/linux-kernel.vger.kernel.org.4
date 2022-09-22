Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8097C5E6E52
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiIVVUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiIVVUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:20:05 -0400
X-Greylist: delayed 1797 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Sep 2022 14:20:04 PDT
Received: from mailserv1.kapsi.fi (mailserv1.kapsi.fi [IPv6:2001:67c:1be8::25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0A67392C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O7e54tlWgB76SoCN972Y6YFdmLgXzAJ3uMklXqY+FDw=; b=fFzlMH1MTBIpL7d6WtnKwbXfMs
        tzq5IidGD1XOgGkKStkwqZCHAI9h7M5cXbTbDVKtPaOIeLiDsdH0AXR69rS/+oAHqtuFGjUpm+5oA
        Y+d+pShnxo3eDUUpfQ137yGJYlyRtAjJLQlloM5A9ZeymcopfPkf0n/dWNHyAVS0sS+AV6KDPWH6q
        X9MuUxawtIS9tuDkKktqZOuaX6mUG0KigtWi0H/t3q+4yqdjIRCVcHtXWSLeBI+a44f4k2ALSfYJg
        l5vJFzsLuPBJ0DdzglK+AQVzQvF3jIXNEMWqVb+RuTDLtAfHJ9ECRHGUgvqAuC5XLTigJA2WelT2J
        fSp1Rg8g==;
Received: from a88-85-156-139.mpynet.fi ([88.85.156.139]:50263 helo=localhost)
        by mailserv1.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maukka@ext.kapsi.fi>)
        id 1obSlj-008pZu-1I; Thu, 22 Sep 2022 23:26:00 +0300
Received: by localhost (sSMTP sendmail emulation); Thu, 22 Sep 2022 23:25:56 +0300
From:   Mauri Sandberg <maukka@ext.kapsi.fi>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk
Cc:     pali@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Date:   Thu, 22 Sep 2022 23:24:57 +0300
Message-Id: <20220922202458.7592-3-maukka@ext.kapsi.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922202458.7592-1-maukka@ext.kapsi.fi>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 88.85.156.139
X-SA-Exim-Mail-From: maukka@ext.kapsi.fi
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
Subject: [PATCH v2 2/3] ARM: dts: orion5x: Add D-Link DNS-323 Device Tree
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mailserv1.kapsi.fi)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree for D-Link DNS-323. The device has three different
variants; A1, B1 and C1. Common parts are included in a .dtsi file
and each hardware variant has its own .dts file.

Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
---
changes from v1
 - split patches, this one adds the device tree
 - set pciec and pcie1 nodes to 'okay'
---
 arch/arm/boot/dts/Makefile                   |   3 +
 arch/arm/boot/dts/orion5x-dlink-dns323.dtsi  | 215 +++++++++++++++++++
 arch/arm/boot/dts/orion5x-dlink-dns323a1.dts |  44 ++++
 arch/arm/boot/dts/orion5x-dlink-dns323b1.dts |  39 ++++
 arch/arm/boot/dts/orion5x-dlink-dns323c1.dts |  81 +++++++
 5 files changed, 382 insertions(+)
 create mode 100644 arch/arm/boot/dts/orion5x-dlink-dns323.dtsi
 create mode 100644 arch/arm/boot/dts/orion5x-dlink-dns323a1.dts
 create mode 100644 arch/arm/boot/dts/orion5x-dlink-dns323b1.dts
 create mode 100644 arch/arm/boot/dts/orion5x-dlink-dns323c1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 05d8aef6e5d2..bc41749cd889 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -997,6 +997,9 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
 	dra71-evm.dtb \
 	dra76-evm.dtb
 dtb-$(CONFIG_ARCH_ORION5X) += \
+	orion5x-dlink-dns323a1.dtb \
+	orion5x-dlink-dns323b1.dtb \
+	orion5x-dlink-dns323c1.dtb \
 	orion5x-kuroboxpro.dtb \
 	orion5x-lacie-d2-network.dtb \
 	orion5x-lacie-ethernet-disk-mini-v2.dtb \
diff --git a/arch/arm/boot/dts/orion5x-dlink-dns323.dtsi b/arch/arm/boot/dts/orion5x-dlink-dns323.dtsi
new file mode 100644
index 000000000000..05b0b134edb3
--- /dev/null
+++ b/arch/arm/boot/dts/orion5x-dlink-dns323.dtsi
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Mauri Sandberg <maukka@ext.kapsi.fi>
+ *
+ */
+
+/ {
+	model = "D-Link DNS-323";
+	compatible = "dlink,dns323", "marvell,orion5x";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x4000000>; /* 64 MB */
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>,  /* on-chip peripheral registers */
+			 <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>,     /* SRAM for crypto */
+			 <MBUS_ID(0x01, 0x0f) 0 0xf4000000 0x800000>;  /* device bus mapping (boot) */
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&pmx_gpio_keys>;
+		pinctrl-names = "default";
+
+		key-0 {
+			label = "Power button";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio0 9 GPIO_ACTIVE_LOW>;
+		};
+
+		key-1 {
+			label = "Reset button";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio0 10 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_gpio_leds>;
+		pinctrl-names = "default";
+
+		led-0 {
+			label = "amber:right";
+			gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+		};
+
+		led-1 {
+			label = "amber:left";
+			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
+		};
+
+		led-2 {
+			label = "blue:power";
+			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+	};
+
+	gpio-poweroff {
+		compatible = "gpio-poweroff";
+		pinctrl-0 = <&pmx_power_off>;
+		pinctrl-names = "default";
+
+		gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
+		timeout-ms = <3000>;
+	};
+};
+
+&devbus_bootcs {
+	status = "okay";
+	devbus,keep-config;
+
+	flash@0 {
+		compatible = "cfi-flash";
+		reg = <0 0x800000>;
+		bank-width = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "MTD1";
+				reg = <0x000000 0x010000>;
+				read-only;
+			};
+
+			partition@10000 {
+				label = "MTD2";
+				reg = <0x010000 0x010000>;
+				read-only;
+			};
+
+			partition@20000 {
+				label = "Linux Kernel";
+				reg = <0x020000 0x180000>;
+			};
+
+			partition@1a0000 {
+				label = "File System";
+				reg = <0x1a0000 0x630000>;
+			};
+
+			uboot: partition@7d0000 {
+				label = "U-boot";
+				reg = <0x7d0000 0x030000>;
+				read-only;
+			};
+		};
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&i2c {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	/* fan speed PWM */
+	fan@3e {
+		compatible = "g760a";
+		reg = <0x3e>;
+	};
+
+	/* temp sensor and thermal watchdog */
+	temperature-sensor@48 {
+		compatible = "gmt,g751";
+		reg = <0x48>;
+	};
+
+	/* RTC w/ alarm */
+	rtc@68 {
+		compatible = "st,m41t80";
+		reg = <0x68>;
+	};
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy: ethernet-phy {
+		reg = <8>;
+	};
+};
+
+&eth {
+	status = "okay";
+	pinctrl-0 = <&pmx_ge>;
+	pinctrl-names = "default";
+	clocks = <&core_clk 0>;
+};
+
+&ethport {
+	phy-handle = <&ethphy>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&pinctrl {
+	pmx_gpio_leds: pmx-gpio-leds {
+		marvell,pins = "mpp1", "mpp2", "mpp5";
+		marvell,function = "gpio";
+	};
+
+	pmx_gpio_misc: pmx-gpio-misc {
+		/* set marvell,pins in board file */
+		marvell,function = "gpio";
+	};
+
+	pmx_power_off: pmx-power-off {
+		marvell,pins = "mpp8";
+		marvell,function = "gpio";
+	};
+
+	pmx_gpio_keys: pmx-gpio-keys {
+		marvell,pins = "mpp9", "mpp10";
+		marvell,function = "gpio";
+	};
+
+	pmx_ge: pmx-ge {
+		marvell,function = "ge";
+	};
+};
+
+&sata {
+	pinctrl-0 = <&pmx_sata0 &pmx_sata1>;
+	pinctrl-names = "default";
+	status = "okay";
+	nr-ports = <2>;
+};
+
+&pciec {
+	status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/orion5x-dlink-dns323a1.dts b/arch/arm/boot/dts/orion5x-dlink-dns323a1.dts
new file mode 100644
index 000000000000..235cc842f289
--- /dev/null
+++ b/arch/arm/boot/dts/orion5x-dlink-dns323a1.dts
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Mauri Sandberg <maukka@ext.kapsi.fi>
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "orion5x-mv88f5181.dtsi"
+#include "orion5x-dlink-dns323.dtsi"
+
+/ {
+	model = "D-Link DNS-323 rev A1";
+	compatible = "dlink,dns323a1", "dlink,dns323", "marvell,orion5x-88f5181",
+		     "marvell,orion5x";
+};
+
+/delete-node/ &sata;
+
+&gpio0 {
+	pinctrl-0 = <&pmx_gpio_misc>;
+	pinctrl-names = "default";
+
+	/* The DNS323 rev A1 power LED requires GPIO 4 to be low. */
+	pin_gpio0_4 {
+		gpio-hog;
+		gpios = <4 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "Power led enable";
+	};
+};
+
+&pmx_gpio_misc {
+	marvell,pins = "mpp4";
+};
+
+&pmx_ge {
+	marvell,pins = "mpp11", "mpp12", "mpp13", "mpp14", "mpp15",
+		       "mpp16", "mpp17", "mpp18", "mpp19";
+};
diff --git a/arch/arm/boot/dts/orion5x-dlink-dns323b1.dts b/arch/arm/boot/dts/orion5x-dlink-dns323b1.dts
new file mode 100644
index 000000000000..e01ba809ffca
--- /dev/null
+++ b/arch/arm/boot/dts/orion5x-dlink-dns323b1.dts
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Mauri Sandberg <maukka@ext.kapsi.fi>
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include "orion5x-mv88f5182.dtsi"
+#include "orion5x-dlink-dns323.dtsi"
+
+/ {
+	model = "D-Link DNS-323 rev B1";
+	compatible = "dlink,dns323b1", "dlink,dns323", "marvell,orion5x-88f5182",
+		     "marvell,orion5x";
+};
+
+&gpio0 {
+	pinctrl-0 = <&pmx_gpio_misc>;
+	pinctrl-names = "default";
+
+	/* The rev B1 has a flag to indicate the system is up.
+	 * Without this flag set, power LED will flash and cannot be
+	 * controlled via gpio-leds.
+	 */
+	pin_gpio0_3 {
+		gpio-hog;
+		gpios = <3 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "System up";
+	};
+};
+
+&pmx_gpio_misc {
+	marvell,pins = "mpp3";
+};
diff --git a/arch/arm/boot/dts/orion5x-dlink-dns323c1.dts b/arch/arm/boot/dts/orion5x-dlink-dns323c1.dts
new file mode 100644
index 000000000000..c24da08bdc8f
--- /dev/null
+++ b/arch/arm/boot/dts/orion5x-dlink-dns323c1.dts
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Mauri Sandberg <maukka@ext.kapsi.fi>
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include "orion5x-mv88f5182.dtsi"
+#include "orion5x-dlink-dns323.dtsi"
+
+/ {
+	model = "D-Link DNS-323 rev C1";
+	compatible = "dlink,dns323c1", "dlink,dns323", "marvell,orion5x-88f5182",
+		     "marvell,orion5x";
+
+	fan {
+		compatible = "gpio-fan";
+		pinctrl-0 = <&pmx_gpio_fan>;
+		pinctrl-names = "default";
+
+		gpios = <&gpio0 19 GPIO_ACTIVE_LOW
+			 &gpio0 18 GPIO_ACTIVE_LOW>;
+
+		gpio-fan,speed-map = <0    0
+				      1000 1
+				      2000 2>;
+		alarm-gpios = <&gpio0 10 GPIO_ACTIVE_HIGH>;
+	};
+
+	gpio-keys {
+		/delete-node/ key-1;
+
+		key-0 {
+			gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	gpio-leds {
+		led-0 {
+			gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-1 {
+			gpios = <&gpio0 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-2 {
+			gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+};
+
+&i2c {
+	/delete-node/ fan@3e;
+};
+
+&pinctrl {
+	/delete-node/ pmx-gpio-misc;
+
+	pmx_gpio_fan: pmx-gpio-fan {
+		marvell,pins = "mpp10", "mpp18", "mpp19";
+		marvell,function = "gpio";
+	};
+};
+
+&pmx_gpio_leds {
+	marvell,pins = "mpp8", "mpp9", "mpp17";
+};
+
+&pmx_power_off {
+	marvell,pins = "mpp2";
+};
+
+&pmx_gpio_keys {
+	marvell,pins = "mpp1";
+};
-- 
2.25.1

