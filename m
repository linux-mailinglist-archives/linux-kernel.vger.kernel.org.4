Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D946BE2E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCQIRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCQIRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:17:15 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF4EDC0B0;
        Fri, 17 Mar 2023 01:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OXf9VFGyzGAY5YjfS90pcE4V9C/l10sPZVU/U27RVMs=; b=KhuZ+Qu2q8z66eFShhi099Lab0
        3qqknWODeO4akpdogv3NfA1gIjgu7q7qgHq6nZts98hgB40tvBgWOw9hgyKsJ/XDYt9VuxmIBFiDS
        Q9oI9Vbrpu7LCH7zdEhLjpJt3iRySaf82a2bj+3cDXZQklbA0x1UGEkZXxnj0y3JCCwjaA38xm7xN
        U87kQGzap1BKN3QUKCUPJlwRrBF0lHmlzgRm7ouAPeOtKolSVyA52/+SxTvZgjDdznptXJ+9CI8xT
        t0Lr58ghxuIZO1PGbmgDVj1YURNqcN/A7JEJDTTNoJPOJc66cyqF4cXk7vsGZW4RTKVcNKz9QAjbz
        Bmkn1U8g==;
Received: from p200300ccff1235001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff12:3500:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pd5GE-00073l-PW; Fri, 17 Mar 2023 09:16:27 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pd5GE-00A15W-5E; Fri, 17 Mar 2023 09:16:26 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, marex@denx.de, max.krummenacher@toradex.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 2/2] ARM: dts: imx: Add devicetree for Tolino Vison
Date:   Fri, 17 Mar 2023 09:16:18 +0100
Message-Id: <20230317081618.2387407-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230317081618.2387407-1-andreas@kemnade.info>
References: <20230317081618.2387407-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a devicetree for the Tolino Vision Ebook reader. It is based
on boards marked with "37NB-E60Q30+4A3". It is equipped with an i.MX6SL
SoC.

Expected to work:
 - Buttons
 - Wifi
 - LEDs
 - uSD
 - eMMC
 - USB
 - RTC
 - Touchscreen
 - Backlight

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/imx6sl-tolino-vision.dts | 490 +++++++++++++++++++++
 2 files changed, 491 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6sl-tolino-vision.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index efe4152e5846..159363f46522 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -690,6 +690,7 @@ dtb-$(CONFIG_SOC_IMX6SL) += \
 	imx6sl-kobo-aura2.dtb \
 	imx6sl-tolino-shine2hd.dtb \
 	imx6sl-tolino-shine3.dtb \
+	imx6sl-tolino-vision.dtb \
 	imx6sl-tolino-vision5.dtb \
 	imx6sl-warp.dtb
 dtb-$(CONFIG_SOC_IMX6SLL) += \
diff --git a/arch/arm/boot/dts/imx6sl-tolino-vision.dts b/arch/arm/boot/dts/imx6sl-tolino-vision.dts
new file mode 100644
index 000000000000..035d1dea42c4
--- /dev/null
+++ b/arch/arm/boot/dts/imx6sl-tolino-vision.dts
@@ -0,0 +1,490 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device tree for the Tolino Vison ebook reader
+ *
+ * Name on mainboard is: 37NB-E60Q30+4A3
+ * Serials start with: 6032
+ *
+ * Copyright 2023 Andreas Kemnade
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "imx6sl.dtsi"
+
+/ {
+	model = "Tolino Vision";
+	compatible = "kobo,tolino-vision", "fsl,imx6sl";
+
+	aliases {
+		mmc0 = &usdhc4;
+		mmc1 = &usdhc2;
+	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&ec 0 50000>;
+		power-supply = <&backlight_regulator>;
+	};
+
+	backlight_regulator: regulator-backlight {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_backlight_power>;
+		regulator-name = "backlight";
+		gpio = <&gpio2 10 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		key-cover {
+			/* magnetic sensor in the corner next to the uSD slot */
+			label = "Cover";
+			gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
+			linux,code = <SW_LID>;
+			linux,input-type = <EV_SW>;
+			wakeup-source;
+		};
+
+		key-fl {
+			label = "Frontlight";
+			gpios = <&gpio3 26 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BRIGHTNESS_CYCLE>;
+		};
+
+		key-power {
+			label = "Power";
+			gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+	};
+
+	leds: leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds>;
+
+		led-0 {
+			/* LED on home button */
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio5 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-1 {
+			/* LED on power button */
+			color = <LED_COLOR_ID_WHITE>;
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio5 7 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "timer";
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	reg_wifi: regulator-wifi {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wifi_power>;
+		regulator-name = "SD3_SPWR";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		gpio = <&gpio4 29 GPIO_ACTIVE_LOW>;
+	};
+
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wifi_reset>;
+		post-power-on-delay-ms = <20>;
+		reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default","sleep";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_sleep>;
+	status = "okay";
+
+	touchscreen@15 {
+		compatible = "elan,ektf2132";
+		reg = <0x15>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ts>;
+		power-gpios = <&gpio5 13 GPIO_ACTIVE_HIGH>;
+		interrupts-extended = <&gpio5 6 IRQ_TYPE_EDGE_FALLING>;
+	};
+
+	accelerometer@1d {
+		reg = <0x1d>;
+		compatible = "fsl,mma8652";
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default","sleep";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_sleep>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	clock-frequency = <100000>;
+	status = "okay";
+
+	ec: embedded-controller@43 {
+		compatible = "netronix,ntxec";
+		reg = <0x43>;
+		#pwm-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ec>;
+		interrupts-extended = <&gpio5 11 IRQ_TYPE_EDGE_FALLING>;
+		system-power-controller;
+	};
+};
+
+&snvs_rtc {
+	/*
+	 * We are using the RTC in the PMIC, but this one is not disabled
+	 * in imx6sl.dtsi.
+	 */
+	status = "disabled";
+};
+
+&uart1 {
+	/* J4 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart4 {
+	/* J9 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc2_sleep>;
+	cd-gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	/* removable uSD card */
+};
+
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc3_sleep>;
+	vmmc-supply = <&reg_wifi>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	cap-power-off-card;
+	non-removable;
+	status = "okay";
+
+	/* CyberTan WC121 (BCM43362) SDIO WiFi */
+};
+
+&usdhc4 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc4>;
+	pinctrl-1 = <&pinctrl_usdhc4_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc4_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc4_sleep>;
+	bus-width = <8>;
+	no-1-8-v;
+	non-removable;
+	status = "okay";
+
+	/* internal eMMC */
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	disable-over-current;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_backlight_power: backlight-powergrp {
+		fsl,pins = <
+			MX6SL_PAD_EPDC_PWRCTRL3__GPIO2_IO10 0x10059
+		>;
+	};
+
+	pinctrl_ec: ecgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD1_DAT0__GPIO5_IO11  0x17000
+		>;
+	};
+
+	pinctrl_gpio_keys: gpio-keysgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD1_DAT1__GPIO5_IO08  0x110B0
+			MX6SL_PAD_SD1_DAT4__GPIO5_IO12  0x110B0
+			MX6SL_PAD_KEY_COL1__GPIO3_IO26  0x11030
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6SL_PAD_I2C1_SCL__I2C1_SCL	 0x4001f8b1
+			MX6SL_PAD_I2C1_SDA__I2C1_SDA	 0x4001f8b1
+		>;
+	};
+
+	pinctrl_i2c1_sleep: i2c1-sleepgrp {
+		fsl,pins = <
+			MX6SL_PAD_I2C1_SCL__I2C1_SCL	 0x400108b1
+			MX6SL_PAD_I2C1_SDA__I2C1_SDA	 0x400108b1
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6SL_PAD_I2C2_SCL__I2C2_SCL	 0x4001f8b1
+			MX6SL_PAD_I2C2_SDA__I2C2_SDA	 0x4001f8b1
+		>;
+	};
+
+	pinctrl_i2c2_sleep: i2c2-sleepgrp {
+		fsl,pins = <
+			MX6SL_PAD_I2C2_SCL__I2C2_SCL	 0x400108b1
+			MX6SL_PAD_I2C2_SDA__I2C2_SDA	 0x400108b1
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6SL_PAD_REF_CLK_24M__I2C3_SCL  0x4001f8b1
+			MX6SL_PAD_REF_CLK_32K__I2C3_SDA  0x4001f8b1
+		>;
+	};
+
+	pinctrl_leds: ledsgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD1_DAT6__GPIO5_IO07    0x17059
+			MX6SL_PAD_SD1_DAT7__GPIO5_IO10    0x17059
+			MX6SL_PAD_EPDC_SDCE2__GPIO1_IO29  0x17059
+		>;
+	};
+
+	pinctrl_ts: tsgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD1_DAT2__GPIO5_IO13	0x110B0
+			MX6SL_PAD_SD1_DAT3__GPIO5_IO06	0x1B0B1
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6SL_PAD_UART1_TXD__UART1_TX_DATA 0x1b0b1
+			MX6SL_PAD_UART1_RXD__UART1_RX_DATA 0x1b0b1
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX6SL_PAD_KEY_ROW6__UART4_TX_DATA 0x1b0b1
+			MX6SL_PAD_KEY_COL6__UART4_RX_DATA 0x1b0b1
+		>;
+	};
+
+	pinctrl_usbotg1: usbotg1grp {
+		fsl,pins = <
+			MX6SL_PAD_EPDC_PWRCOM__USB_OTG1_ID 0x17059
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6SL_PAD_SD2_CMD__SD2_CMD		0x17059
+			MX6SL_PAD_SD2_CLK__SD2_CLK		0x13059
+			MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x17059
+			MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x17059
+			MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x17059
+			MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x17059
+			MX6SL_PAD_SD2_DAT4__GPIO5_IO02		0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD2_CMD__SD2_CMD		0x170b9
+			MX6SL_PAD_SD2_CLK__SD2_CLK		0x130b9
+			MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x170b9
+			MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x170b9
+			MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x170b9
+			MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x170b9
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD2_CMD__SD2_CMD		0x170f9
+			MX6SL_PAD_SD2_CLK__SD2_CLK		0x130f9
+			MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x170f9
+			MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x170f9
+			MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x170f9
+			MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x170f9
+		>;
+	};
+
+	pinctrl_usdhc2_sleep: usdhc2-sleepgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD2_CMD__GPIO5_IO04		0x100f9
+			MX6SL_PAD_SD2_CLK__GPIO5_IO05		0x100f9
+			MX6SL_PAD_SD2_DAT0__GPIO5_IO01		0x100f9
+			MX6SL_PAD_SD2_DAT1__GPIO4_IO30		0x100f9
+			MX6SL_PAD_SD2_DAT2__GPIO5_IO03		0x100f9
+			MX6SL_PAD_SD2_DAT3__GPIO4_IO28		0x100f9
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX6SL_PAD_SD3_CMD__SD3_CMD	0x11059
+			MX6SL_PAD_SD3_CLK__SD3_CLK	0x11059
+			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x11059
+			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x11059
+			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x11059
+			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x11059
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD3_CMD__SD3_CMD	0x170b9
+			MX6SL_PAD_SD3_CLK__SD3_CLK	0x170b9
+			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x170b9
+			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x170b9
+			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x170b9
+			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD3_CMD__SD3_CMD	0x170f9
+			MX6SL_PAD_SD3_CLK__SD3_CLK	0x170f9
+			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x170f9
+			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x170f9
+			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x170f9
+			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x170f9
+		>;
+	};
+
+	pinctrl_usdhc3_sleep: usdhc3-sleepgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD3_CMD__GPIO5_IO21	0x100c1
+			MX6SL_PAD_SD3_CLK__GPIO5_IO18	0x100c1
+			MX6SL_PAD_SD3_DAT0__GPIO5_IO19	0x100c1
+			MX6SL_PAD_SD3_DAT1__GPIO5_IO20	0x100c1
+			MX6SL_PAD_SD3_DAT2__GPIO5_IO16	0x100c1
+			MX6SL_PAD_SD3_DAT3__GPIO5_IO17	0x100c1
+		>;
+	};
+
+	pinctrl_usdhc4: usdhc4grp {
+		fsl,pins = <
+			MX6SL_PAD_FEC_TX_CLK__SD4_CMD		0x17059
+			MX6SL_PAD_FEC_MDIO__SD4_CLK		0x13059
+			MX6SL_PAD_FEC_RX_ER__SD4_DATA0		0x17059
+			MX6SL_PAD_FEC_CRS_DV__SD4_DATA1		0x17059
+			MX6SL_PAD_FEC_RXD1__SD4_DATA2		0x17059
+			MX6SL_PAD_FEC_TXD0__SD4_DATA3		0x17059
+			MX6SL_PAD_FEC_MDC__SD4_DATA4		0x17059
+			MX6SL_PAD_FEC_RXD0__SD4_DATA5		0x17059
+			MX6SL_PAD_FEC_TX_EN__SD4_DATA6		0x17059
+			MX6SL_PAD_FEC_TXD1__SD4_DATA7		0x17059
+			MX6SL_PAD_FEC_REF_CLK__SD4_RESET	0x17068
+		>;
+	};
+
+	pinctrl_usdhc4_100mhz: usdhc4-100mhzgrp {
+		fsl,pins = <
+			MX6SL_PAD_FEC_TX_CLK__SD4_CMD		0x170b9
+			MX6SL_PAD_FEC_MDIO__SD4_CLK		0x130b9
+			MX6SL_PAD_FEC_RX_ER__SD4_DATA0		0x170b9
+			MX6SL_PAD_FEC_CRS_DV__SD4_DATA1		0x170b9
+			MX6SL_PAD_FEC_RXD1__SD4_DATA2		0x170b9
+			MX6SL_PAD_FEC_TXD0__SD4_DATA3		0x170b9
+			MX6SL_PAD_FEC_MDC__SD4_DATA4		0x170b9
+			MX6SL_PAD_FEC_RXD0__SD4_DATA5		0x170b9
+			MX6SL_PAD_FEC_TX_EN__SD4_DATA6		0x170b9
+			MX6SL_PAD_FEC_TXD1__SD4_DATA7		0x170b9
+		>;
+	};
+
+	pinctrl_usdhc4_200mhz: usdhc4-200mhzgrp {
+		fsl,pins = <
+			MX6SL_PAD_FEC_TX_CLK__SD4_CMD		0x170f9
+			MX6SL_PAD_FEC_MDIO__SD4_CLK		0x130f9
+			MX6SL_PAD_FEC_RX_ER__SD4_DATA0		0x170f9
+			MX6SL_PAD_FEC_CRS_DV__SD4_DATA1		0x170f9
+			MX6SL_PAD_FEC_RXD1__SD4_DATA2		0x170f9
+			MX6SL_PAD_FEC_TXD0__SD4_DATA3		0x170f9
+			MX6SL_PAD_FEC_MDC__SD4_DATA4		0x170f9
+			MX6SL_PAD_FEC_RXD0__SD4_DATA5		0x170f9
+			MX6SL_PAD_FEC_TX_EN__SD4_DATA6		0x170f9
+			MX6SL_PAD_FEC_TXD1__SD4_DATA7		0x170f9
+		>;
+	};
+
+	pinctrl_usdhc4_sleep: usdhc4-sleepgrp {
+		fsl,pins = <
+			MX6SL_PAD_FEC_TX_CLK__GPIO4_IO21	0x100c1
+			MX6SL_PAD_FEC_MDIO__GPIO4_IO20		0x100c1
+			MX6SL_PAD_FEC_RX_ER__GPIO4_IO19		0x100c1
+			MX6SL_PAD_FEC_CRS_DV__GPIO4_IO25	0x100c1
+			MX6SL_PAD_FEC_RXD1__GPIO4_IO18		0x100c1
+			MX6SL_PAD_FEC_TXD0__GPIO4_IO24		0x100c1
+			MX6SL_PAD_FEC_MDC__GPIO4_IO23		0x100c1
+			MX6SL_PAD_FEC_RXD0__GPIO4_IO17		0x100c1
+			MX6SL_PAD_FEC_TX_EN__GPIO4_IO22		0x100c1
+			MX6SL_PAD_FEC_TXD1__GPIO4_IO16		0x100c1
+		>;
+	};
+
+	pinctrl_wifi_power: wifi-powergrp {
+		fsl,pins = <
+			MX6SL_PAD_SD2_DAT6__GPIO4_IO29	0x10059	/* WIFI_3V3_ON */
+		>;
+	};
+
+	pinctrl_wifi_reset: wifi-resetgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD2_DAT7__GPIO5_IO00	0x10059	/* WIFI_RST */
+		>;
+	};
+};
-- 
2.30.2

