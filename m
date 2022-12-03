Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EB66414CC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 08:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiLCHmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 02:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiLCHmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 02:42:15 -0500
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2722D1570E;
        Fri,  2 Dec 2022 23:42:11 -0800 (PST)
Received: from amadeus-VLT-WX0.lan (unknown [218.85.118.194])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id C93C98000B0;
        Sat,  3 Dec 2022 15:42:08 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 2/2] arm64: dts: rockchip: rk3328: Add Orange Pi R1 Plus
Date:   Sat,  3 Dec 2022 15:41:49 +0800
Message-Id: <20221203074149.11543-3-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221203074149.11543-1-amadeus@jmu.edu.cn>
References: <20221203074149.11543-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDT0NOVh4dSh5MSEIZHktNGlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlKQ1VDTlVKSkNVSkJPWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NDI6OSo6LT0eOAo4PStRAx8z
        C0swCipVSlVKTUxLS05ISElCT0JLVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlK
        Q1VDTlVKSkNVSkJPWVdZCAFZQUpLTE5ONwY+
X-HM-Tid: 0a84d6ef786cb03akuuuc93c98000b0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Orange Pi R1 Plus is a Rockchip RK3328 based SBC by Xunlong.

This device is similar to the NanoPi R2S, and has a 16MB
SPI NOR (mx25l12805d). The reset button is changed to
directly reset the power supply, another detail is that
both network ports have independent MAC addresses.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3328-orangepi-r1-plus.dts  | 373 ++++++++++++++++++
 2 files changed, 374 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 0a76a2ebb5f6..27e00f4f3c86 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go3.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-a1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2s.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-orangepi-r1-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock64.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock-pi-e.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-roc-cc.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
new file mode 100644
index 000000000000..dc83d74045a3
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Based on rk3328-nanopi-r2s.dts, which is:
+ *   Copyright (c) 2020 David Bauer <mail@david-bauer.net>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include "rk3328.dtsi"
+
+/ {
+	model = "Xunlong Orange Pi R1 Plus";
+	compatible = "xunlong,orangepi-r1-plus", "rockchip,rk3328";
+
+	aliases {
+		ethernet1 = &rtl8153;
+		mmc0 = &sdmmc;
+	};
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	gmac_clk: gmac-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "gmac_clkin";
+		#clock-cells = <0>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&lan_led_pin>, <&sys_led_pin>, <&wan_led_pin>;
+		pinctrl-names = "default";
+
+		led-0 {
+			function = LED_FUNCTION_LAN;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio2 RK_PB7 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-1 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio3 RK_PC5 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-2 {
+			function = LED_FUNCTION_WAN;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio2 RK_PC2 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	vcc_sd: sdmmc-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&sdmmc0m1_pin>;
+		pinctrl-names = "default";
+		regulator-name = "vcc_sd";
+		regulator-boot-on;
+		vin-supply = <&vcc_io>;
+	};
+
+	vcc_sys: vcc-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vdd_5v_lan: vdd-5v-lan-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 RK_PC6 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&lan_vdd_pin>;
+		pinctrl-names = "default";
+		regulator-name = "vdd_5v_lan";
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc_sys>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&display_subsystem {
+	status = "disabled";
+};
+
+&gmac2io {
+	assigned-clocks = <&cru SCLK_MAC2IO>, <&cru SCLK_MAC2IO_EXT>;
+	assigned-clock-parents = <&gmac_clk>, <&gmac_clk>;
+	clock_in_out = "input";
+	phy-handle = <&rtl8211e>;
+	phy-mode = "rgmii";
+	phy-supply = <&vcc_io>;
+	pinctrl-0 = <&rgmiim1_pins>;
+	pinctrl-names = "default";
+	snps,aal;
+	rx_delay = <0x18>;
+	tx_delay = <0x24>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rtl8211e: ethernet-phy@1 {
+			reg = <1>;
+			pinctrl-0 = <&eth_phy_reset_pin>;
+			pinctrl-names = "default";
+			reset-assert-us = <10000>;
+			reset-deassert-us = <50000>;
+			reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	rk805: pmic@18 {
+		compatible = "rockchip,rk805";
+		reg = <0x18>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
+		#clock-cells = <1>;
+		clock-output-names = "xin32k", "rk805-clkout2";
+		gpio-controller;
+		#gpio-cells = <2>;
+		pinctrl-0 = <&pmic_int_l>;
+		pinctrl-names = "default";
+		rockchip,system-power-controller;
+		wakeup-source;
+
+		vcc1-supply = <&vcc_sys>;
+		vcc2-supply = <&vcc_sys>;
+		vcc3-supply = <&vcc_sys>;
+		vcc4-supply = <&vcc_sys>;
+		vcc5-supply = <&vcc_io>;
+		vcc6-supply = <&vcc_sys>;
+
+		regulators {
+			vdd_log: DCDC_REG1 {
+				regulator-name = "vdd_log";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <712500>;
+				regulator-max-microvolt = <1450000>;
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+
+			vdd_arm: DCDC_REG2 {
+				regulator-name = "vdd_arm";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <712500>;
+				regulator-max-microvolt = <1450000>;
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <950000>;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_io: DCDC_REG4 {
+				regulator-name = "vcc_io";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc_18: LDO_REG1 {
+				regulator-name = "vcc_18";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcc18_emmc: LDO_REG2 {
+				regulator-name = "vcc18_emmc";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdd_10: LDO_REG3 {
+				regulator-name = "vdd_10";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+		};
+	};
+};
+
+&io_domains {
+	pmuio-supply = <&vcc_io>;
+	vccio1-supply = <&vcc_io>;
+	vccio2-supply = <&vcc18_emmc>;
+	vccio3-supply = <&vcc_io>;
+	vccio4-supply = <&vcc_io>;
+	vccio5-supply = <&vcc_io>;
+	vccio6-supply = <&vcc_io>;
+	status = "okay";
+};
+
+&pinctrl {
+	gmac2io {
+		eth_phy_reset_pin: eth-phy-reset-pin {
+			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	leds {
+		lan_led_pin: lan-led-pin {
+			rockchip,pins = <2 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		sys_led_pin: sys-led-pin {
+			rockchip,pins = <3 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wan_led_pin: wan-led-pin {
+			rockchip,pins = <2 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	lan {
+		lan_vdd_pin: lan-vdd-pin {
+			rockchip,pins = <2 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins = <1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	pinctrl-0 = <&sdmmc0_clk>, <&sdmmc0_cmd>, <&sdmmc0_dectn>, <&sdmmc0_bus4>;
+	pinctrl-names = "default";
+	vmmc-supply = <&vcc_sd>;
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+	};
+};
+
+&tsadc {
+	rockchip,hw-tshut-mode = <0>;
+	rockchip,hw-tshut-polarity = <0>;
+	status = "okay";
+};
+
+&u2phy {
+	status = "okay";
+};
+
+&u2phy_host {
+	status = "okay";
+};
+
+&u2phy_otg {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb20_otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbdrd3 {
+	dr_mode = "host";
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* Second port is for USB 3.0 */
+	rtl8153: device@2 {
+		compatible = "usbbda,8153";
+		reg = <2>;
+	};
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
-- 
2.25.1

