Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE56A65F888
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbjAFBEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236564AbjAFBEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:04:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DCE471FE1;
        Thu,  5 Jan 2023 17:04:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D397611FB;
        Thu,  5 Jan 2023 17:04:41 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EF243F23F;
        Thu,  5 Jan 2023 17:03:57 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Icenowy Zheng <uwu@icenowy.me>,
        =?UTF-8?q?Andr=C3=A1s=20Szemz=C3=B6?= <szemzo.andras@gmail.com>,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org
Subject: [PATCH 4/4] ARM: dts: sunxi: add MangoPi MQ-R board
Date:   Fri,  6 Jan 2023 01:01:55 +0000
Message-Id: <20230106010155.26868-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.5
In-Reply-To: <20230106010155.26868-1-andre.przywara@arm.com>
References: <20230106010155.26868-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MangoPi MQ-R is a small SBC with the Allwinner T113-s3 SoC.
The SoC features two Arm Cortex-A7 cores and 128 MB of co-packaged DDR3
DRAM. The board adds mostly connectors and the required regulators, plus
a Realtek RTL8189FTV WiFi chip.
Power comes in via a USB-C connector wired as a peripheral, and there is
a second USB-C connector usable as a host port.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../arm/boot/dts/sun8i-t113s-mangopi-mq-r.dts | 160 ++++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-t113s-mangopi-mq-r.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d08a3c450ce72..39fd893682924 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1390,6 +1390,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-s3-elimo-initium.dtb \
 	sun8i-s3-lichee-zero-plus.dtb \
 	sun8i-s3-pinecube.dtb \
+	sun8i-t113s-mangopi-mq-r.dtb \
 	sun8i-t3-cqa3t-bv3.dtb \
 	sun8i-v3-sl631-imx179.dtb \
 	sun8i-v3s-licheepi-zero.dtb \
diff --git a/arch/arm/boot/dts/sun8i-t113s-mangopi-mq-r.dts b/arch/arm/boot/dts/sun8i-t113s-mangopi-mq-r.dts
new file mode 100644
index 0000000000000..ed4d5217d7b0d
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-t113s-mangopi-mq-r.dts
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2022 Arm Ltd.
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/dts-v1/;
+
+#include "sun8i-t113s.dtsi"
+
+/ {
+	model = "MangoPi MQ-R";
+	compatible = "widora,mangopi-mq-r", "allwinner,sun8i-t113s";
+
+	aliases {
+		ethernet0 = &rtl8189ftv;
+		serial3 = &uart3;
+	};
+
+	chosen {
+		stdout-path = "serial3:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&pio 3 22 GPIO_ACTIVE_LOW>; /* PD22 */
+		};
+	};
+
+	/* board wide 5V supply directly from the USB-C socket */
+	reg_vcc5v: vcc5v {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	/* SY8008 DC/DC regulator on the board */
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_vcc5v>;
+	};
+
+	/* SY8008 DC/DC regulator on the board, also supplying VDD-SYS */
+	reg_vcc_core: regulator-core {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-core";
+		regulator-min-microvolt = <880000>;
+		regulator-max-microvolt = <880000>;
+		vin-supply = <&reg_vcc5v>;
+	};
+
+	/* XC6206 LDO on the board */
+	reg_avdd2v8: regulator-avdd {
+		compatible = "regulator-fixed";
+		regulator-name = "avdd2v8";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&reg_3v3>;
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&pio 6 12 GPIO_ACTIVE_LOW>; /* PG12 */
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_vcc_core>;
+};
+
+&cpu1 {
+	cpu-supply = <&reg_vcc_core>;
+};
+
+&dcxo {
+	clock-frequency = <24000000>;
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-0 = <&mmc0_pins>;
+	pinctrl-names = "default";
+	vmmc-supply = <&reg_3v3>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc1 {
+	pinctrl-0 = <&mmc1_pins>;
+	pinctrl-names = "default";
+	vmmc-supply = <&reg_3v3>;
+	non-removable;
+	bus-width = <4>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	status = "okay";
+
+	rtl8189ftv: wifi@1 {
+		reg = <1>;
+		interrupt-parent = <&pio>;
+		interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 = WL_WAKE_AP */
+		interrupt-names = "host-wake";
+	};
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&pio {
+	vcc-pb-supply = <&reg_3v3>;
+	vcc-pd-supply = <&reg_3v3>;
+	vcc-pe-supply = <&reg_avdd2v8>;
+	vcc-pf-supply = <&reg_3v3>;
+	vcc-pg-supply = <&reg_3v3>;
+};
+
+&reg_ldoa {
+	regulator-always-on;
+	regulator-name = "vcc-1v8";
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	ldo-in-supply = <&reg_3v3>;
+};
+
+&reg_ldob {
+	regulator-name = "vcc-dram";
+	regulator-always-on;
+	ldo-in-supply = <&reg_3v3>;
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pb_pins>;
+	status = "okay";
+};
+
+/* The USB-C socket has its CC pins pulled to GND, so is hardwired as a UFP. */
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_vcc5v>;
+	status = "okay";
+};
-- 
2.35.5

