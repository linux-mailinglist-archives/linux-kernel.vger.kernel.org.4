Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF26660E77
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 12:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjAGLyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 06:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjAGLx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 06:53:58 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52102564F2;
        Sat,  7 Jan 2023 03:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zT18H
        b+FMfc3XPoU0Ct/bhcvIR0S7ONF8IONZjGtayk=; b=TxX8KY3plx6gNiZ/VGTIz
        6GbIEZ/4YRBYY8cSK6/x6yF6wvSwkkZSAoOti3kksqFSStYnnWBYkwTfwvuDveVK
        bSUxrQlWIbA0etkaYkRr86yXgOjPBu0kDmnGtVvX2MTLRikUkLJAXRQcZhNdq3Xi
        ECLtLxiPTu0X2elkYeXyZU=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wBHT9MyXbljlABeAA--.33288S2;
        Sat, 07 Jan 2023 19:53:26 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     lasstp5011@gmail.com, Andy Yan <andyshrk@163.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: Add dts for EmbedFire rk3568 lubancat 2
Date:   Sat,  7 Jan 2023 19:53:20 +0800
Message-Id: <20230107115320.2125479-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230107115159.2125308-1-andyshrk@163.com>
References: <20230107115159.2125308-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHT9MyXbljlABeAA--.33288S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3KFWkZry8GryUJF4fAw45Awb_yoW8Ar4UZo
        ZFvFWFva1FgF1fGr1ktFWDCw1xXrW8WanakF4YgFyxWr4rJ3ZIyrWYkayUWF17Gr10kr1k
        Z3W3JFy5Cw1xA3s5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RUPEaDUUUU
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiTBzvXmI0XOe3tAAAsP
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lubancat 2 is a rk3568 based SBC from EmbedFire.

Specification:
- Rockchip rk3568
- LPDDR4/4X 1/2/4/8 GB
- TF scard slot
- eMMC 8/32/64/128 GB
- Gigabit ethernet x 2
- HDMI out
- USB 2.0 Host x 1
- USB 2.0 Type-C OTG x 1
- USB 3.0 Host x 1
- Mini PCIE interface for WIFI/BT module
- M.2 key for 2280 NVME
- 40 pin header

Signed-off-by: Andy Yan <andyshrk@163.com>
---

 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-lubancat-2.dts   | 734 ++++++++++++++++++
 2 files changed, 735 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index e52bda04d45a..3223d8ecca12 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -81,5 +81,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-box-demo.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-lubancat-1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-lubancat-2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-odroid-m1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3a.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts b/arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts
new file mode 100644
index 000000000000..30db6f2a65c2
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts
@@ -0,0 +1,734 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/*
+ * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
+ * Copyright (c) 2022 EmbedFire <embedfire@embedfire.com>
+ */
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
+#include "rk3568.dtsi"
+
+/ {
+	model = "EmbedFire LubanCat 2";
+	compatible = "embedfire,lubancat-2", "rockchip,rk3568";
+
+	aliases {
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		mmc0 = &sdmmc0;
+		mmc1 = &sdhci;
+	};
+
+	chosen: chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		user_led: user-led {
+			label = "user_led";
+			linux,default-trigger = "heartbeat";
+			default-state = "on";
+			gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_LOW>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&user_led_pin>;
+		};
+	};
+
+	hdmi-con {
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
+	dc_5v: dc-5v-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_5v";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vcc3v3_sys: vcc3v3-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc5v0_sys: vcc5v0-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_5v>;
+	};
+
+	vcc3v3_m2_pcie: vcc3v3-m2-pcie-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "m2_pcie_3v3";
+		enable-active-high;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&vcc3v3_m2_pcie_en>;
+		pinctrl-names = "default";
+		startup-delay-us = <200000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc3v3_mini_pcie: vcc3v3-mini-pcie-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "minipcie_3v3";
+		enable-active-high;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&vcc3v3_mini_pcie_en>;
+		pinctrl-names = "default";
+		startup-delay-us = <5000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc5v0_usb20_host: vcc5v0-usb20-host-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb20_host";
+		enable-active-high;
+		gpio = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&vcc5v0_usb20_host_en>;
+		pinctrl-names = "default";
+	};
+
+	vcc5v0_usb30_host: vcc5v0-usb30-host-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb30_host";
+		enable-active-high;
+		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&vcc5v0_usb30_host_en>;
+		pinctrl-names = "default";
+	};
+
+	vcc5v0_otg_vbus: vcc5v0-otg-vbus-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_otg_vbus";
+		enable-active-high;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio0 RK_PD3 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&vcc5v0_otg_vbus_en>;
+		pinctrl-names = "default";
+	};
+};
+
+&combphy0 {
+	status = "okay";
+};
+
+&combphy1 {
+	status = "okay";
+};
+
+&combphy2 {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
+&hdmi {
+	avdd-0v9-supply = <&vdda0v9_image>;
+	avdd-1v8-supply = <&vcca1v8_image>;
+	status = "okay";
+};
+
+&hdmi_in {
+	hdmi_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi>;
+	};
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	vdd_cpu: regulator@1c {
+		compatible = "tcs,tcs4525";
+		reg = <0x1c>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1150000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	rk809: pmic@20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
+		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
+		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
+		#clock-cells = <1>;
+		clock-names = "mclk";
+		clocks = <&cru I2S1_MCLKOUT_TX>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int>;
+		rockchip,system-power-controller;
+		#sound-dai-cells = <0>;
+		vcc1-supply = <&vcc3v3_sys>;
+		vcc2-supply = <&vcc3v3_sys>;
+		vcc3-supply = <&vcc3v3_sys>;
+		vcc4-supply = <&vcc3v3_sys>;
+		vcc5-supply = <&vcc3v3_sys>;
+		vcc6-supply = <&vcc3v3_sys>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc3v3_sys>;
+		wakeup-source;
+
+		regulators {
+			vdd_logic: DCDC_REG1 {
+				regulator-name = "vdd_logic";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-init-microvolt = <900000>;
+				regulator-ramp-delay = <6001>;
+				regulator-initial-mode = <0x2>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_gpu: DCDC_REG2 {
+				regulator-name = "vdd_gpu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-init-microvolt = <900000>;
+				regulator-ramp-delay = <6001>;
+				regulator-initial-mode = <0x2>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vdd_npu: DCDC_REG4 {
+				regulator-name = "vdd_npu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-init-microvolt = <900000>;
+				regulator-ramp-delay = <6001>;
+				regulator-initial-mode = <0x2>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8: DCDC_REG5 {
+				regulator-name = "vcc_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v9_image: LDO_REG1 {
+				regulator-name = "vdda0v9_image";
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_0v9: LDO_REG2 {
+				regulator-name = "vdda_0v9";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda0v9_pmu: LDO_REG3 {
+				regulator-name = "vdda0v9_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
+				};
+			};
+
+			vccio_acodec: LDO_REG4 {
+				regulator-name = "vccio_acodec";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-name = "vccio_sd";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_pmu: LDO_REG6 {
+				regulator-name = "vcc3v3_pmu";
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
+			vcca_1v8: LDO_REG7 {
+				regulator-name = "vcca_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca1v8_pmu: LDO_REG8 {
+				regulator-name = "vcca1v8_pmu";
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
+			vcca1v8_image: LDO_REG9 {
+				regulator-name = "vcca1v8_image";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_3v3: SWITCH_REG1 {
+				regulator-name = "vcc_3v3";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_sd: SWITCH_REG2 {
+				regulator-name = "vcc3v3_sd";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&i2s1_8ch {
+	rockchip,trcm-sync-tx-only;
+	status = "okay";
+};
+
+&gmac0 {
+	phy-mode = "rgmii";
+	clock_in_out = "output";
+
+	snps,reset-gpio = <&gpio2 RK_PD3 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	/* Reset time is 20ms, 100ms for rtl8211f */
+	snps,reset-delays-us = <0 20000 100000>;
+
+	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
+	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>, <&cru CLK_MAC0_2TOP>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac0_miim
+		     &gmac0_tx_bus2
+		     &gmac0_rx_bus2
+		     &gmac0_rgmii_clk
+		     &gmac0_rgmii_bus>;
+
+	tx_delay = <0x22>;
+	rx_delay = <0x0e>;
+
+	phy-handle = <&rgmii_phy0>;
+	status = "okay";
+};
+
+&mdio0 {
+	rgmii_phy0: phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x0>;
+	};
+};
+
+&gmac1 {
+	phy-mode = "rgmii";
+	clock_in_out = "output";
+
+	snps,reset-gpio = <&gpio3 RK_PA2 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	/* Reset time is 20ms, 100ms for rtl8211f */
+	snps,reset-delays-us = <0 20000 100000>;
+
+	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru CLK_MAC1_2TOP>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1m1_miim
+		     &gmac1m1_tx_bus2
+		     &gmac1m1_rx_bus2
+		     &gmac1m1_rgmii_clk
+		     &gmac1m1_rgmii_bus>;
+
+	tx_delay = <0x21>;
+	rx_delay = <0x0e>;
+
+	phy-handle = <&rgmii_phy1>;
+	status = "okay";
+};
+
+&mdio1 {
+	rgmii_phy1: phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x0>;
+	};
+};
+
+&gic {
+	mbi-ranges = <94 31>, <229 31>, <289 31>;
+};
+
+&pcie30phy {
+	status = "okay";
+};
+
+&pcie3x2 {
+	reset-gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_m2_pcie>;
+	status = "okay";
+};
+
+&pcie2x1 {
+	reset-gpios = <&gpio3 RK_PC1 GPIO_ACTIVE_HIGH>;
+	disable-gpios = <&gpio3 RK_PC2 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_mini_pcie>;
+	status = "okay";
+};
+
+&pmu_io_domains {
+	pmuio2-supply = <&vcc3v3_pmu>;
+	vccio1-supply = <&vccio_acodec>;
+	vccio3-supply = <&vccio_sd>;
+	vccio4-supply = <&vcc_1v8>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc_1v8>;
+	vccio7-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
+&pwm8 {
+	status = "okay";
+};
+
+&pwm9 {
+	status = "disabled";
+};
+
+&pwm10 {
+	status = "disabled";
+};
+
+&pwm14 {
+	status = "disabled";
+};
+
+&spi3 {
+	pinctrl-0 = <&spi3m1_pins>;
+	status = "disabled";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3m1_xfer>;
+	status = "disabled";
+};
+
+&saradc {
+	vref-supply = <&vcca_1v8>;
+	status = "okay";
+};
+
+&tsadc {
+	rockchip,hw-tshut-mode = <1>;
+	rockchip,hw-tshut-polarity = <0>;
+	status = "okay";
+};
+
+&sdhci {
+	assigned-clocks = <&cru BCLK_EMMC>, <&cru TCLK_EMMC>, <&cru CCLK_EMMC>;
+	assigned-clock-rates = <200000000>, <24000000>, <200000000>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	mmc-hs200-1_8v;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd>;
+	supports-emmc;
+	status = "okay";
+};
+
+&sdmmc0 {
+	max-frequency = <150000000>;
+	no-sdio;
+	no-mmc;
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
+	status = "okay";
+};
+
+/* USB OTG/USB Host_1 USB 2.0 Comb */
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_host {
+	phy-supply = <&vcc5v0_usb30_host>;
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	phy-supply = <&vcc5v0_otg_vbus>;
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+/* USB Host_2/USB Host_3 USB 2.0 Comb */
+&usb2phy1 {
+	status = "okay";
+};
+
+&usb2phy1_host {
+	status = "okay";
+};
+
+&usb2phy1_otg {
+	phy-supply = <&vcc5v0_usb20_host>;
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+/* MULTI_PHY0 For SATA0, USB3.0 OTG Only USB2.0 */
+&usb_host0_xhci {
+	phys = <&usb2phy0_otg>;
+	phy-names = "usb2-phy";
+	extcon = <&usb2phy0>;
+	maximum-speed = "high-speed";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&sata0 {
+	status = "okay";
+};
+
+/* USB3.0 Host */
+&usb_host1_xhci {
+	status = "okay";
+};
+
+&vop {
+	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
+	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi_in_vp0>;
+	};
+};
+
+&pinctrl {
+	leds {
+		user_led_pin: user-status-led-pin {
+			rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb {
+		vcc5v0_usb20_host_en: vcc5v0-usb20-host-en {
+			rockchip,pins = <0 RK_PD5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		vcc5v0_usb30_host_en: vcc5v0-usb30-host-en {
+			rockchip,pins = <0 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		vcc5v0_otg_vbus_en: vcc5v0-otg-vbus-en {
+			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pcie {
+		vcc3v3_m2_pcie_en: vcc3v3-m2-pcie-en {
+			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		vcc3v3_mini_pcie_en: vcc3v3-mini-pcie-en {
+			rockchip,pins = <3 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		pmic_int: pmic_int {
+			rockchip,pins =
+				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
-- 
2.34.1

