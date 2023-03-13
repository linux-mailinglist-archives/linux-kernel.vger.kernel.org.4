Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE33D6B752D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCMLEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCMLEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:04:30 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B4076BF;
        Mon, 13 Mar 2023 04:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rrbAQntQd9/+/Oc68V0UgO2d39SkRgw42ZzXbIjRsBA=; b=glrOvTnNw8NW1BcdjFjcSOxHvV
        Vg8O8WqCgKsQ9RcUf69SjRkQqU12+C6OLEBnkGWBhGoU2f2oO742mx1B4An5rWUSQbhupfzzwZh2M
        20oUfhs9/LJrkZEnWylPWf7UOSsQRVUGJED1/RByUv7pKwcTwkMA9bgTZ8D01bTrMqvdidHE2laGs
        JJXynYA2dgOc8mXF6BB/8qu7MJCnNCtsIcbD3Giqa2OpLQRfmrJeT1CmKqSpavTQIg3WsYlFUg7/L
        YJFB7xT/DBeySXE2ACe9kP9b76RqDClf6pkwg0NvildXNt6FWEaQTHx9fWKLJRBRIqWlcOYNV3v/P
        V1wcP0Gw==;
Received: from p200300ccff0893001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff08:9300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pbfyO-0005Tl-Bb; Mon, 13 Mar 2023 12:04:12 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pbfyN-009cpH-Mg; Mon, 13 Mar 2023 12:04:11 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bcousson@baylibre.com,
        tony@atomide.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] ARM: dts: omap4: add initial support for Epson Moverio BT-200
Date:   Mon, 13 Mar 2023 12:04:09 +0100
Message-Id: <20230313110409.2294154-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the devices working with current drivers for the
Epson Moverio BT-200 AR glasses consisting of a control unit
and the glasses itself.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
yes, epson,embt2ws is unknown, is the txt->yaml conversion around the
corner? I would then resubmit it includding an addition
to that yaml. If not probably I resubmit the conversion patch with
the compatible added. But that should not stop the rest of this patch from
being reviewed.

 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/omap4-epson-embt2ws.dts | 450 ++++++++++++++++++++++
 2 files changed, 451 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap4-epson-embt2ws.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index efe4152e5846..7dd427523392 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -974,6 +974,7 @@ dtb-$(CONFIG_ARCH_OMAP4) += \
 	omap4-droid-bionic-xt875.dtb \
 	omap4-droid4-xt894.dtb \
 	omap4-duovero-parlor.dtb \
+	omap4-epson-embt2ws.dtb \
 	omap4-kc1.dtb \
 	omap4-panda.dtb \
 	omap4-panda-a4.dtb \
diff --git a/arch/arm/boot/dts/omap4-epson-embt2ws.dts b/arch/arm/boot/dts/omap4-epson-embt2ws.dts
new file mode 100644
index 000000000000..e119e2cccc4e
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-epson-embt2ws.dts
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Andreas Kemnade
+ */
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "omap4460.dtsi"
+
+/ {
+	model = "Epson Moverio BT-200";
+	compatible = "epson,embt2ws", "ti,omap4460", "ti,omap4";
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>; /* 1024M */
+	};
+
+	backlight-left {
+		compatible = "pwm-backlight";
+		pwms = <&twl_pwm 1 7812500>;
+		power-supply = <&unknown_supply>;
+	};
+
+	backlight-right {
+		compatible = "pwm-backlight";
+		pwms = <&twl_pwm 0 7812500>;
+		power-supply = <&unknown_supply>;
+	};
+
+	chosen {
+		stdout-path = &uart3;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_pins>;
+
+		key-lock {
+			label = "Lock";
+			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
+			linux,code = <SW_ROTATE_LOCK>; /* SW_TOUCHPAD_LOCK */
+			linux,input-type = <EV_SW>;
+		};
+	};
+
+	unknown_supply: unknown-supply {
+		compatible = "regulator-fixed";
+		regulator-name = "unknown";
+	};
+
+       /* regulator for wl12xx on sdio2 */
+	wl12xx_vmmc: wl12xx-vmmc {
+		pinctrl-names = "default";
+		pinctrl-0 = <&wl12xx_gpio>;
+		compatible = "regulator-fixed";
+		regulator-name = "vwl1271";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio1 24 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
+	clock-frequency = <400000>;
+
+	twl: pmic@48 {
+		compatible = "ti,twl6032";
+		reg = <0x48>;
+		/* IRQ# = 7 */
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		rtc {
+			compatible = "ti,twl4030-rtc";
+			interrupts = <11>;
+		};
+
+		ldo2: regulator-ldo2 {
+			compatible = "ti,twl6032-ldo2";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		ldo4: regulator-ldo4 {
+			compatible = "ti,twl6032-ldo4";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <2800000>;
+		};
+
+		ldo3: regulator-ldo3 {
+			compatible = "ti,twl6032-ldo3";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		ldo5: regulator-ldo5 {
+			compatible = "ti,twl6032-ldo5";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <3000000>;
+			ti,retain-on-reset;
+		};
+
+		ldo1: regulator-ldo1 {
+			compatible = "ti,twl6032-ldo1";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2500000>;
+		};
+
+		ldo7: regulator-ldo7 {
+			compatible = "ti,twl6032-ldo7";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <2900000>;
+		};
+
+		ldoln: regulator-ldoln {
+			compatible = "ti,twl6032-ldoln";
+			regulator-always-on;
+		};
+
+		ldo6: regulator-ldo6 {
+			compatible = "ti,twl6032-ldo6";
+			regulator-always-on;
+		};
+
+		ldousb: regulator-ldousb {
+			compatible = "ti,twl6032-ldousb";
+			regulator-always-on;
+		};
+
+		vio: regulator-vio {
+			compatible = "ti,twl6032-vio";
+			regulator-always-on;
+		};
+
+		twl_usb_comparator: usb-comparator {
+			compatible = "ti,twl6030-usb";
+			interrupts = <4>, <10>;
+		};
+
+		twl_pwm: pwm {
+			/* provides two PWMs (id 0, 1 for PWM1 and PWM2) */
+			compatible = "ti,twl6030-pwm";
+			#pwm-cells = <2>;
+		};
+
+		twl_pwmled: pwmled {
+			/* provides one PWM (id 0 for Charging indicator LED) */
+			compatible = "ti,twl6030-pwmled";
+			#pwm-cells = <2>;
+		};
+
+		gpadc {
+			compatible = "ti,twl6032-gpadc";
+			interrupts = <3>;
+			#io-channel-cells = <1>;
+		};
+
+	};
+};
+
+#include "twl6030_omap4.dtsi"
+
+&twl_usb_comparator {
+	usb-supply = <&ldousb>;
+};
+
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+
+	clock-frequency = <200000>;
+
+	/* at head/glasses */
+	mpu9150h: imu@68 {
+		compatible = "invensense,mpu9150";
+		reg = <0x68>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&mpu9150h_pins>;
+		interrupt-parent = <&gpio2>;
+		interrupt = <19 IRQ_TYPE_LEVEL_HIGH>;
+
+		i2c-gate {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			magnetometer@c {
+				compatible = "asahi-kasei,ak8975";
+				reg = <0x0c>;
+			};
+		};
+	};
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+
+	clock-frequency = <100000>;
+
+	/* TODO: BD2606MVV at 0x66 */
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins>;
+
+	clock-frequency = <360000>;
+
+	/* TODO: KXTI9 at 0xf */
+
+	tlv320aic3x: codec@18 {
+		compatible = "ti,tlv320aic3x";
+		reg = <0x18>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tlv320aic3x_pins>;
+		#sound-dai-cells = <0>;
+
+		reset-gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
+	};
+
+	/* TODO: mpu9150 at control unit, seems to require quirks */
+};
+
+&keypad {
+	pinctrl-names = "default";
+	pinctrl-0 = <&keypad_pins>;
+	keypad,num-rows = <2>;
+	keypad,num-columns = <3>;
+	linux,keymap = <MATRIX_KEY(0, 0, KEY_MENU)
+			MATRIX_KEY(0, 1, KEY_HOME)
+			MATRIX_KEY(0, 2, KEY_BACK)
+			MATRIX_KEY(1, 0, KEY_ESC)
+			MATRIX_KEY(1, 1, KEY_VOLUMEDOWN)
+			MATRIX_KEY(1, 2, KEY_VOLUMEUP)>;
+	linux,input-no-autorepeat;
+};
+
+&mcbsp2 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp2_pins>;
+	status = "okay";
+};
+
+
+&mmc1 {
+	/* sdcard */
+	vmmc-supply = <&ldo5>;
+	broken-cd;
+	bus-width = <4>;
+};
+
+&mmc2 {
+	/* emmc */
+	vmmc-supply = <&ldo2>;
+	bus-width = <8>;
+};
+
+&mmc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&wl12xx_pins>;
+	vmmc-supply = <&wl12xx_vmmc>;
+	interrupts-extended = <&wakeupgen GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core 0x12e>;
+	non-removable;
+	bus-width = <4>;
+	cap-power-off-card;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore@2 {
+		compatible = "ti,wl1283";
+		reg = <2>;
+		interrupts-extended = <&gpio1 23 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "irq";
+		ref-clock-frequency = <26000000>;
+		tcxo-clock-frequency = <26000000>;
+	};
+};
+
+&mmc4 {
+	status = "disabled";
+};
+
+&mmc5 {
+	status = "disabled";
+};
+
+&omap4_pmx_core {
+	bt_pins: pinmux-bt-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x1ca, PIN_OUTPUT | MUX_MODE3) /* gpio25 */
+		>;
+	};
+
+	gpio_keys_pins: pinmux-gpio-key-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x56, PIN_INPUT_PULLUP | MUX_MODE3) /* gpio35 */
+		>;
+	};
+
+	i2c1_pins: pinmux-i2c1-pins {
+		pinctrl-single,pins = <
+			   OMAP4_IOPAD(0x122, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
+			   OMAP4_IOPAD(0x124, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
+		>;
+	};
+
+	i2c2_pins: pinmux-i2c2-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x126, PIN_INPUT | MUX_MODE0)	/* i2c2_scl */
+			OMAP4_IOPAD(0x128, PIN_INPUT | MUX_MODE0)	/* i2c2_sda */
+		>;
+	};
+
+	i2c3_pins: pinmux-i2c3-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x12a, PIN_INPUT | MUX_MODE0)	/* i2c3_scl */
+			OMAP4_IOPAD(0x12c, PIN_INPUT | MUX_MODE0)	/* i2c3_sda */
+		>;
+	};
+
+	i2c4_pins: pinmux-i2c4-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x12e, PIN_INPUT | MUX_MODE0)	/* i2c4_scl */
+			OMAP4_IOPAD(0x130, PIN_INPUT | MUX_MODE0)	/* i2c4_sda */
+		>;
+	};
+
+	keypad_pins: pinmux-keypad-pins {
+		pinctrl-single,pins = <
+			/* kpd_row0 */
+			OMAP4_IOPAD(0x0050, PIN_INPUT_PULLUP | MUX_MODE1)
+			/* kpd_row1 */
+			OMAP4_IOPAD(0x0052, PIN_INPUT_PULLUP | MUX_MODE1)
+			/* kpd_row2 */
+			OMAP4_IOPAD(0x0054, PIN_INPUT_PULLUP | MUX_MODE1)
+			/* kpd_col0 */
+			OMAP4_IOPAD(0x0058, PIN_OUTPUT | MUX_MODE1)
+			/* kpd_col1 */
+			OMAP4_IOPAD(0x005a, PIN_OUTPUT | MUX_MODE1)
+			/* kpd_col2 */
+			OMAP4_IOPAD(0x005c, PIN_OUTPUT | MUX_MODE1)
+		>;
+	};
+
+	mcbsp2_pins: pinmux-mcbsp2-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x0f6, PIN_INPUT | MUX_MODE0)       /* abe_mcbsp2_clkx */
+			OMAP4_IOPAD(0x0f8, PIN_INPUT | MUX_MODE0)       /* abe_mcbsp2_dr */
+			OMAP4_IOPAD(0x0fa, PIN_OUTPUT | MUX_MODE0)      /* abe_mcbsp2_dx */
+			OMAP4_IOPAD(0x0fc, PIN_INPUT | MUX_MODE0)       /* abe_mcbsp2_fsx */
+		>;
+	};
+
+	mpu9150h_pins: pinmux-mpu9150h-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x76, PIN_INPUT_PULLUP | MUX_MODE3)
+		>;
+	};
+
+	tlv320aic3x_pins: pinmux-tlv320aic3x-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x7e, PIN_OUTPUT | MUX_MODE3)
+		>;
+	};
+
+	uart2_pins: pinmux-uart2-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x118, PIN_INPUT_PULLUP | MUX_MODE0) /* uart2_cts.uart2_cts */
+			OMAP4_IOPAD(0x11a, PIN_OUTPUT | MUX_MODE0)	 /* uart2_rts.uart2_rts */
+			OMAP4_IOPAD(0x11c, PIN_INPUT_PULLUP | MUX_MODE0) /* uart2_rx.uart2_rx */
+			OMAP4_IOPAD(0x11e, PIN_OUTPUT | MUX_MODE0)	 /* uart2_tx.uart2_tx */
+		>;
+	};
+
+	uart3_pins: pinmux-uart3-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x144, PIN_INPUT | MUX_MODE0)  /* uart3_rx_irrx */
+			OMAP4_IOPAD(0x146, PIN_OUTPUT | MUX_MODE0) /* uart3_tx_irtx */
+		>;
+	};
+
+	usb_otg_hs_pins: pinmux-usb-otg-hs-pins {
+		 pinctrl-single,pins = <
+			 OMAP4_IOPAD(0x194, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* usba0_otg_ce */
+			 OMAP4_IOPAD(0x196, PIN_INPUT | MUX_MODE0)	     /* usba0_otg_dp */
+			 OMAP4_IOPAD(0x198, PIN_INPUT | MUX_MODE0)	     /* usba0_otg_dm */
+		 >;
+	};
+
+	wl12xx_pins: pinmux-wl12xx-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x1c6, PIN_INPUT | MUX_MODE3) /* gpio_23 / IRQ */
+			OMAP4_IOPAD(0x16c, PIN_INPUT_PULLUP | MUX_MODE2) /* sdmmc3_dat2 */
+			OMAP4_IOPAD(0x16e, PIN_INPUT_PULLUP | MUX_MODE2) /* sdmmc3_dat1 */
+			OMAP4_IOPAD(0x170, PIN_INPUT_PULLUP | MUX_MODE2) /* sdmmc3_dat0 */
+			OMAP4_IOPAD(0x172, PIN_INPUT_PULLUP | MUX_MODE2) /* sdmmc3_dat3 */
+			OMAP4_IOPAD(0x174, PIN_INPUT_PULLUP | MUX_MODE2) /* sdmmc3_cmd */
+			OMAP4_IOPAD(0x176, PIN_INPUT_PULLUP | MUX_MODE2) /* sdmmc3_clk */
+		>;
+	};
+
+	wl12xx_gpio: pinmux-wl12xx-gpio {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x1c8, PIN_OUTPUT | MUX_MODE3)  /* gpio_24 / WLAN_EN */
+		>;
+	};
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins &bt_pins>;
+	interrupts-extended = <&wakeupgen GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core OMAP4_UART2_RX>;
+
+	/*
+	 * BT + GPS in WL1283 in WG7500 requiring CLK32KAUDIO of pmic
+	 * which does not have a driver
+	 */
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+	interrupts-extended = <&wakeupgen GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core OMAP4_UART3_RX>;
+};
+
+&usb_otg_hs {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb_otg_hs_pins>;
+
+	interface-type = <1>;
+	mode = <3>;
+	power = <50>;
+};
+
+&usbhshost {
+	status = "disabled";
+};
-- 
2.30.2

