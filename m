Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785C462E79D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiKQWBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241017AbiKQWAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:00:51 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2263888;
        Thu, 17 Nov 2022 14:00:08 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id j4so5163447lfk.0;
        Thu, 17 Nov 2022 14:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxQMoUdtzXrTZxjwrt4AC9tbRn1+8ZssNI0dr5xeyIc=;
        b=jkoDy+NUB/6CxM/gSLBRDAw5spGtK8frZOdLRba7ww9HRTnKcnAfT/vWCN7diJnP2b
         A/wtrJQWco9oVIg9E6KHMeQEeo8GdIb6s10Nf8M22VrPmozPpsgKKn1TrE2gTLR/DuYI
         kyDiZEkVpasNC+b2z3+PpgmDguKamIURuyCK4sSVpxBRyw/3iMyyMzu5DIhKe1vtkmSv
         Fk7PPFapZWcVHKi+wopj2EnCrum+3bln8WbtRQneDgg/ssxnex6YGSVfvbW+So0wi70L
         apf47FwVqaXSvpi40l5fWSLWS5jW7sLnSxRXcEmTKSHScWFAH4lPe3lQEn0y2FAU8UqE
         /1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxQMoUdtzXrTZxjwrt4AC9tbRn1+8ZssNI0dr5xeyIc=;
        b=lqZDdRzo3db3JdXnX6QjZadQwCZPTreNNFr2fE6xSC3cnqjBfj46yKRbCLnTjjm5Zi
         arNv0NN6iyOspullDoUPXbGTbly5d5cCZLrVpQWb+D6pKiUxo5fAL7d1CIQ+Juy0B7tu
         LoynFDQKCtIaYpsg/SiKbb50efTmLzIAsDzufr9zy1mvqk1YWRHGwA/DxP6rgfENh5LB
         EWRNFuW2HAC1jiLo8WJJeYTPuWux9QWvX3QiYQ9AD2IHoY9dNqGttR9TorsMjWgsHxxD
         tCjbblby5x9224qGwVTahV++I+N9z5Ul4e1qWpkmdvkFA6A2PbTIVmF+e1RKonMn8siH
         +VjA==
X-Gm-Message-State: ANoB5plFq7cPKvqBgA3odWAlfeo2R5noMO4gH5t8NObzpe7yDdJPdKsl
        Ybz4nSw6YwRPt38qMAV4zT4=
X-Google-Smtp-Source: AA0mqf7YkF9BFmQxsBh1RQ3NVvU9SgcmQ2u2P0cheb520R9Wo1oAbFeI8hN1lhaTH53mNongYncX+Q==
X-Received: by 2002:a05:6512:6d:b0:4a8:ebec:7143 with SMTP id i13-20020a056512006d00b004a8ebec7143mr1515641lfo.493.1668722406246;
        Thu, 17 Nov 2022 14:00:06 -0800 (PST)
Received: from localhost.localdomain (79.191.9.185.ipv4.supernova.orange.pl. [79.191.9.185])
        by smtp.gmail.com with ESMTPSA id q29-20020ac25a1d000000b00497aa190523sm342985lfn.248.2022.11.17.14.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:00:05 -0800 (PST)
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     =?UTF-8?q?Jo=C3=A3o=20H=20=2E=20Spies?= <jhlspies@gmail.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] arm64: dts: rockchip: Move most of Odroid Go Advance DTS into a DTSI
Date:   Thu, 17 Nov 2022 22:59:50 +0100
Message-Id: <20221117215954.4114202-2-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117215954.4114202-1-maccraft123mc@gmail.com>
References: <20221117215954.4114202-1-maccraft123mc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support more devices that are clones of this device or minor
revisions without duplication move msot of go2's dts into a dtsi file.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 .../boot/dts/rockchip/rk3326-odroid-go.dtsi   | 600 +++++++++++++++++
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   | 620 +-----------------
 2 files changed, 609 insertions(+), 611 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi
new file mode 100644
index 000000000000..fbc6bfbaa5c1
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go.dtsi
@@ -0,0 +1,600 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Hardkernel Co., Ltd
+ * Copyright (c) 2020 Theobroma Systems Design und Consulting GmbH
+ * Copyright (c) 2022 Maya Matuszczyk <maccraft123mc@gmail.com>
+ */
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include "rk3326.dtsi"
+
+/ {
+	aliases {
+		mmc0 = &sdmmc;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		power-supply = <&vcc_bl>;
+		pwms = <&pwm1 0 25000 0>;
+	};
+
+	builtin_gamepad: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&btn_pins>;
+
+		button-sw1 {
+			gpios = <&gpio1 RK_PB4 GPIO_ACTIVE_LOW>;
+			label = "DPAD-UP";
+			linux,code = <BTN_DPAD_UP>;
+		};
+		button-sw2 {
+			gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_LOW>;
+			label = "DPAD-DOWN";
+			linux,code = <BTN_DPAD_DOWN>;
+		};
+		button-sw3 {
+			gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_LOW>;
+			label = "DPAD-LEFT";
+			linux,code = <BTN_DPAD_LEFT>;
+		};
+		button-sw4 {
+			gpios = <&gpio1 RK_PB7 GPIO_ACTIVE_LOW>;
+			label = "DPAD-RIGHT";
+			linux,code = <BTN_DPAD_RIGHT>;
+		};
+		button-sw5 {
+			gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_LOW>;
+			label = "BTN-A";
+			linux,code = <BTN_EAST>;
+		};
+		button-sw6 {
+			gpios = <&gpio1 RK_PA5 GPIO_ACTIVE_LOW>;
+			label = "BTN-B";
+			linux,code = <BTN_SOUTH>;
+		};
+		button-sw7 {
+			gpios = <&gpio1 RK_PA6 GPIO_ACTIVE_LOW>;
+			label = "BTN-Y";
+			linux,code = <BTN_WEST>;
+		};
+		button-sw8 {
+			gpios = <&gpio1 RK_PA7 GPIO_ACTIVE_LOW>;
+			label = "BTN-X";
+			linux,code = <BTN_NORTH>;
+		};
+		btn_f1: button-sw9 {
+			gpios = <&gpio2 RK_PA0 GPIO_ACTIVE_LOW>;
+			label = "F1";
+			linux,code = <BTN_TRIGGER_HAPPY1>;
+		};
+		btn_f2: button-sw10 {
+			gpios = <&gpio2 RK_PA1 GPIO_ACTIVE_LOW>;
+			label = "F2";
+			linux,code = <BTN_TRIGGER_HAPPY2>;
+		};
+		btn_f3: button-sw11 {
+			gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_LOW>;
+			label = "F3";
+			linux,code = <BTN_TRIGGER_HAPPY3>;
+		};
+		btn_f4: button-sw12 {
+			gpios = <&gpio2 RK_PA3 GPIO_ACTIVE_LOW>;
+			label = "F4";
+			linux,code = <BTN_TRIGGER_HAPPY4>;
+		};
+		btn_f5: button-sw13 {
+			gpios = <&gpio2 RK_PA4 GPIO_ACTIVE_LOW>;
+			label = "F5";
+			linux,code = <BTN_TRIGGER_HAPPY5>;
+		};
+		btn_f6: button-sw14 {
+			gpios = <&gpio2 RK_PA5 GPIO_ACTIVE_LOW>;
+			label = "F6";
+			linux,code = <BTN_TRIGGER_HAPPY6>;
+		};
+		button-sw15 {
+			gpios = <&gpio2 RK_PA6 GPIO_ACTIVE_LOW>;
+			label = "TOP-LEFT";
+			linux,code = <BTN_TL>;
+		};
+		button-sw16 {
+			gpios = <&gpio2 RK_PA7 GPIO_ACTIVE_LOW>;
+			label = "TOP-RIGHT";
+			linux,code = <BTN_TR>;
+		};
+	};
+
+	leds: gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&blue_led_pin>;
+
+		blue_led: led-0 {
+			label = "blue:heartbeat";
+			gpios = <&gpio0 RK_PC1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	rk817-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "Analog";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,hp-det-gpio = <&gpio2 RK_PC6 GPIO_ACTIVE_HIGH>;
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,widgets =
+			"Microphone", "Mic Jack",
+			"Headphone", "Headphones",
+			"Speaker", "Speaker";
+		simple-audio-card,routing =
+			"MICL", "Mic Jack",
+			"Headphones", "HPOL",
+			"Headphones", "HPOR",
+			"Speaker", "SPKO";
+
+		simple-audio-card,codec {
+			sound-dai = <&rk817>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s1_2ch>;
+		};
+	};
+
+	vccsys: vccsys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v8_sys";
+		regulator-always-on;
+		regulator-min-microvolt = <3800000>;
+		regulator-max-microvolt = <3800000>;
+	};
+
+	vcc_host: vcc_host {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_host";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		gpio = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&usb_midu>;
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
+&cru {
+	assigned-clocks = <&cru PLL_NPLL>,
+		<&cru ACLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
+		<&cru HCLK_BUS_PRE>, <&cru HCLK_PERI_PRE>,
+		<&cru PCLK_BUS_PRE>, <&cru SCLK_GPU>,
+		<&cru PLL_CPLL>;
+
+	assigned-clock-rates = <1188000000>,
+		<200000000>, <200000000>,
+		<150000000>, <150000000>,
+		<100000000>, <200000000>,
+		<17000000>;
+};
+
+&display_subsystem {
+	status = "okay";
+};
+
+&dsi {
+	status = "okay";
+
+	ports {
+		mipi_out: port@1 {
+			reg = <1>;
+
+			mipi_out_panel: endpoint {
+				remote-endpoint = <&mipi_in_panel>;
+			};
+		};
+	};
+
+	internal_display: panel@0 {
+		reg = <0>;
+		backlight = <&backlight>;
+		iovcc-supply = <&vcc_lcd>;
+		reset-gpios = <&gpio3 RK_PC0 GPIO_ACTIVE_LOW>;
+		rotation = <270>;
+		vdd-supply = <&vcc_lcd>;
+
+		port {
+			mipi_in_panel: endpoint {
+				remote-endpoint = <&mipi_out_panel>;
+			};
+		};
+	};
+};
+
+&dsi_dphy {
+	status = "okay";
+};
+
+&gpu {
+	mali-supply = <&vdd_logic>;
+	status = "okay";
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+	i2c-scl-falling-time-ns = <16>;
+	i2c-scl-rising-time-ns = <280>;
+	status = "okay";
+
+	rk817: pmic@20 {
+		compatible = "rockchip,rk817";
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PB2 IRQ_TYPE_LEVEL_LOW>;
+		clock-output-names = "rk808-clkout1", "xin32k";
+		clock-names = "mclk";
+		clocks = <&cru SCLK_I2S1_OUT>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int>, <&i2s1_2ch_mclk>;
+		wakeup-source;
+		#clock-cells = <1>;
+		#sound-dai-cells = <0>;
+
+		vcc1-supply = <&vccsys>;
+		vcc2-supply = <&vccsys>;
+		vcc3-supply = <&vccsys>;
+		vcc4-supply = <&vccsys>;
+		vcc5-supply = <&vccsys>;
+		vcc6-supply = <&vccsys>;
+		vcc7-supply = <&vccsys>;
+		vcc8-supply = <&vccsys>;
+
+		regulators {
+			vdd_logic: DCDC_REG1 {
+				regulator-name = "vdd_logic";
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1150000>;
+				regulator-ramp-delay = <6001>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <950000>;
+				};
+			};
+
+			vdd_arm: DCDC_REG2 {
+				regulator-name = "vdd_arm";
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
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
+			vcc_3v3: DCDC_REG4 {
+				regulator-name = "vcc_3v3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc_1v8: LDO_REG2 {
+				regulator-name = "vcc_1v8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdd_1v0: LDO_REG3 {
+				regulator-name = "vdd_1v0";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1000000>;
+				};
+			};
+
+			vcc3v3_pmu: LDO_REG4 {
+				regulator-name = "vcc3v3_pmu";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-name = "vccio_sd";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc_sd: LDO_REG6 {
+				regulator-name = "vcc_sd";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc_bl: LDO_REG7 {
+				regulator-name = "vcc_bl";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc_lcd: LDO_REG8 {
+				regulator-name = "vcc_lcd";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <2800000>;
+				};
+			};
+
+			LDO_REG9 {
+				/* unused */
+			};
+
+			usb_midu: BOOST {
+				regulator-name = "usb_midu";
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5400000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+
+		rk817_charger: charger {
+			rockchip,resistor-sense-micro-ohms = <10000>;
+			rockchip,sleep-enter-current-microamp = <300000>;
+			rockchip,sleep-filter-current-microamp = <100000>;
+		};
+
+		rk817_codec: codec {
+			rockchip,mic-in-differential;
+		};
+	};
+};
+
+/* EXT Header(P2): 7(SCL:GPIO0.C2), 8(SDA:GPIO0.C3) */
+&i2c1 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+/* I2S 1 Channel Used */
+&i2s1_2ch {
+	status = "okay";
+};
+
+&io_domains {
+	vccio1-supply = <&vcc_3v3>;
+	vccio2-supply = <&vccio_sd>;
+	vccio3-supply = <&vcc_3v3>;
+	vccio4-supply = <&vcc_3v3>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
+&pmu_io_domains {
+	pmuio1-supply = <&vcc3v3_pmu>;
+	pmuio2-supply = <&vcc3v3_pmu>;
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&sdmmc {
+	cap-sd-highspeed;
+	card-detect-delay = <200>;
+	cd-gpios = <&gpio0 RK_PA3 GPIO_ACTIVE_LOW>; /*[> CD GPIO <]*/
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "okay";
+};
+
+&sfc {
+	pinctrl-0 = <&sfc_clk &sfc_cs0 &sfc_bus2>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <108000000>;
+		spi-rx-bus-width = <2>;
+		spi-tx-bus-width = <1>;
+	};
+};
+
+&tsadc {
+	status = "okay";
+};
+
+&u2phy {
+	status = "okay";
+
+	u2phy_host: host-port {
+		status = "okay";
+	};
+
+	u2phy_otg: otg-port {
+		status = "disabled";
+	};
+};
+
+&usb20_otg {
+	status = "okay";
+};
+
+/* EXT Header(P2): 2(RXD:GPIO1.C0),3(TXD:.C1),4(CTS:.C2),5(RTS:.C3) */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_xfer &uart1_cts>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2m1_xfer>;
+	status = "okay";
+};
+
+&vopb {
+	status = "okay";
+};
+
+&vopb_mmu {
+	status = "okay";
+};
+
+&pinctrl {
+	btns {
+		btn_pins: btn-pins {
+			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	headphone {
+		hp_det: hp-det {
+			rockchip,pins = <2 RK_PC6 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	leds {
+		blue_led_pin: blue-led-pin {
+			rockchip,pins = <0 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		dc_det: dc-det {
+			rockchip,pins = <0 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pmic_int: pmic-int {
+			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		soc_slppin_gpio: soc_slppin_gpio {
+			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_output_low>;
+		};
+
+		soc_slppin_rst: soc_slppin_rst {
+			rockchip,pins = <0 RK_PA4 2 &pcfg_pull_none>;
+		};
+
+		soc_slppin_slp: soc_slppin_slp {
+			rockchip,pins = <0 RK_PA4 1 &pcfg_pull_none>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
index 72899a714310..4702183b673c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
@@ -2,30 +2,21 @@
 /*
  * Copyright (c) 2019 Hardkernel Co., Ltd
  * Copyright (c) 2020 Theobroma Systems Design und Consulting GmbH
+ * Copyright (c) 2022 Maya Matuszczyk <maccraft123mc@gmail.com>
  */
 
 /dts-v1/;
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/pinctrl/rockchip.h>
-#include "rk3326.dtsi"
+#include "rk3326-odroid-go.dtsi"
 
 / {
 	model = "ODROID-GO Advance";
 	compatible = "hardkernel,rk3326-odroid-go2", "rockchip,rk3326";
 
-	aliases {
-		mmc0 = &sdmmc;
-	};
-
-	chosen {
-		stdout-path = "serial2:115200n8";
-	};
-
-	adc-joystick {
+	analog_sticks: adc-joystick {
 		compatible = "adc-joystick";
 		io-channels = <&saradc 1>,
 			      <&saradc 2>;
+		poll-interval = <60>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -46,12 +37,6 @@ axis@1 {
 		};
 	};
 
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		power-supply = <&vcc_bl>;
-		pwms = <&pwm1 0 25000 0>;
-	};
-
 	battery: battery {
 		compatible = "simple-battery";
 		charge-full-design-microamp-hours = <3000000>;
@@ -63,606 +48,19 @@ battery: battery {
 		voltage-min-design-microvolt = <3500000>;
 
 		ocv-capacity-celsius = <20>;
-		ocv-capacity-table-0 =	<4046950 100>, <4001920 95>, <3967900 90>, <3919950 85>,
+		ocv-capacity-table-0 =  <4046950 100>, <4001920 95>, <3967900 90>, <3919950 85>,
 					<3888450 80>, <3861850 75>, <3831540 70>, <3799130 65>,
 					<3768190 60>, <3745650 55>, <3726610 50>, <3711630 45>,
 					<3696720 40>, <3685660 35>, <3674950 30>, <3663050 25>,
 					<3649470 20>, <3635260 15>, <3616920 10>, <3592440 5>,
 					<3574170 0>;
 	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&btn_pins>;
-
-		/*
-		 *      *** ODROIDGO2-Advance Switch layout ***
-		 * |------------------------------------------------|
-		 * | sw15                                      sw16 |
-		 * |------------------------------------------------|
-		 * |     sw1      |-------------------|      sw8    |
-		 * |  sw3   sw4   |                   |   sw7   sw5 |
-		 * |     sw2      |    LCD Display    |      sw6    |
-		 * |              |                   |             |
-		 * |              |-------------------|             |
-		 * |         sw9 sw10   sw11 sw12   sw13 sw14       |
-		 * |------------------------------------------------|
-		 */
-
-		button-sw1 {
-			gpios = <&gpio1 RK_PB4 GPIO_ACTIVE_LOW>;
-			label = "DPAD-UP";
-			linux,code = <BTN_DPAD_UP>;
-		};
-		button-sw2 {
-			gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_LOW>;
-			label = "DPAD-DOWN";
-			linux,code = <BTN_DPAD_DOWN>;
-		};
-		button-sw3 {
-			gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_LOW>;
-			label = "DPAD-LEFT";
-			linux,code = <BTN_DPAD_LEFT>;
-		};
-		button-sw4 {
-			gpios = <&gpio1 RK_PB7 GPIO_ACTIVE_LOW>;
-			label = "DPAD-RIGHT";
-			linux,code = <BTN_DPAD_RIGHT>;
-		};
-		button-sw5 {
-			gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_LOW>;
-			label = "BTN-A";
-			linux,code = <BTN_EAST>;
-		};
-		button-sw6 {
-			gpios = <&gpio1 RK_PA5 GPIO_ACTIVE_LOW>;
-			label = "BTN-B";
-			linux,code = <BTN_SOUTH>;
-		};
-		button-sw7 {
-			gpios = <&gpio1 RK_PA6 GPIO_ACTIVE_LOW>;
-			label = "BTN-Y";
-			linux,code = <BTN_WEST>;
-		};
-		button-sw8 {
-			gpios = <&gpio1 RK_PA7 GPIO_ACTIVE_LOW>;
-			label = "BTN-X";
-			linux,code = <BTN_NORTH>;
-		};
-		button-sw9 {
-			gpios = <&gpio2 RK_PA0 GPIO_ACTIVE_LOW>;
-			label = "F1";
-			linux,code = <BTN_TRIGGER_HAPPY1>;
-		};
-		button-sw10 {
-			gpios = <&gpio2 RK_PA1 GPIO_ACTIVE_LOW>;
-			label = "F2";
-			linux,code = <BTN_TRIGGER_HAPPY2>;
-		};
-		button-sw11 {
-			gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_LOW>;
-			label = "F3";
-			linux,code = <BTN_TRIGGER_HAPPY3>;
-		};
-		button-sw12 {
-			gpios = <&gpio2 RK_PA3 GPIO_ACTIVE_LOW>;
-			label = "F4";
-			linux,code = <BTN_TRIGGER_HAPPY4>;
-		};
-		button-sw13 {
-			gpios = <&gpio2 RK_PA4 GPIO_ACTIVE_LOW>;
-			label = "F5";
-			linux,code = <BTN_TRIGGER_HAPPY5>;
-		};
-		button-sw14 {
-			gpios = <&gpio2 RK_PA5 GPIO_ACTIVE_LOW>;
-			label = "F6";
-			linux,code = <BTN_TRIGGER_HAPPY6>;
-		};
-		button-sw15 {
-			gpios = <&gpio2 RK_PA6 GPIO_ACTIVE_LOW>;
-			label = "TOP-LEFT";
-			linux,code = <BTN_TL>;
-		};
-		button-sw16 {
-			gpios = <&gpio2 RK_PA7 GPIO_ACTIVE_LOW>;
-			label = "TOP-RIGHT";
-			linux,code = <BTN_TR>;
-		};
-	};
-
-	leds: gpio-leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&blue_led_pin>;
-
-		blue_led: led-0 {
-			label = "blue:heartbeat";
-			gpios = <&gpio0 RK_PC1 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-		};
-	};
-
-	rk817-sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "Analog";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,hp-det-gpio = <&gpio2 RK_PC6 GPIO_ACTIVE_HIGH>;
-		simple-audio-card,mclk-fs = <256>;
-		simple-audio-card,widgets =
-			"Microphone", "Mic Jack",
-			"Headphone", "Headphones",
-			"Speaker", "Speaker";
-		simple-audio-card,routing =
-			"MICL", "Mic Jack",
-			"Headphones", "HPOL",
-			"Headphones", "HPOR",
-			"Speaker", "SPKO";
-
-		simple-audio-card,codec {
-			sound-dai = <&rk817>;
-		};
-
-		simple-audio-card,cpu {
-			sound-dai = <&i2s1_2ch>;
-		};
-	};
-
-	vccsys: vccsys {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v8_sys";
-		regulator-always-on;
-		regulator-min-microvolt = <3800000>;
-		regulator-max-microvolt = <3800000>;
-	};
-
-	vcc_host: vcc_host {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_host";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-
-		gpio = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&usb_midu>;
-	};
-};
-
-&cpu0 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu1 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu2 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu3 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cru {
-	assigned-clocks = <&cru PLL_NPLL>,
-		<&cru ACLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
-		<&cru HCLK_BUS_PRE>, <&cru HCLK_PERI_PRE>,
-		<&cru PCLK_BUS_PRE>, <&cru SCLK_GPU>,
-		<&cru PLL_CPLL>;
-
-	assigned-clock-rates = <1188000000>,
-		<200000000>, <200000000>,
-		<150000000>, <150000000>,
-		<100000000>, <200000000>,
-		<17000000>;
 };
 
-&display_subsystem {
-	status = "okay";
+&internal_display {
+	compatible = "elida,kd35t133";
 };
 
-&dsi {
-	status = "okay";
-
-	ports {
-		mipi_out: port@1 {
-			reg = <1>;
-
-			mipi_out_panel: endpoint {
-				remote-endpoint = <&mipi_in_panel>;
-			};
-		};
-	};
-
-	panel@0 {
-		compatible = "elida,kd35t133";
-		reg = <0>;
-		backlight = <&backlight>;
-		iovcc-supply = <&vcc_lcd>;
-		reset-gpios = <&gpio3 RK_PC0 GPIO_ACTIVE_LOW>;
-		rotation = <270>;
-		vdd-supply = <&vcc_lcd>;
-
-		port {
-			mipi_in_panel: endpoint {
-				remote-endpoint = <&mipi_out_panel>;
-			};
-		};
-	};
-};
-
-&dsi_dphy {
-	status = "okay";
-};
-
-&gpu {
-	mali-supply = <&vdd_logic>;
-	status = "okay";
-};
-
-&i2c0 {
-	clock-frequency = <400000>;
-	i2c-scl-falling-time-ns = <16>;
-	i2c-scl-rising-time-ns = <280>;
-	status = "okay";
-
-	rk817: pmic@20 {
-		compatible = "rockchip,rk817";
-		reg = <0x20>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PB2 IRQ_TYPE_LEVEL_LOW>;
-		clock-output-names = "rk808-clkout1", "xin32k";
-		clock-names = "mclk";
-		clocks = <&cru SCLK_I2S1_OUT>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int>, <&i2s1_2ch_mclk>;
-		wakeup-source;
-		#clock-cells = <1>;
-		#sound-dai-cells = <0>;
-
-		vcc1-supply = <&vccsys>;
-		vcc2-supply = <&vccsys>;
-		vcc3-supply = <&vccsys>;
-		vcc4-supply = <&vccsys>;
-		vcc5-supply = <&vccsys>;
-		vcc6-supply = <&vccsys>;
-		vcc7-supply = <&vccsys>;
-		vcc8-supply = <&vccsys>;
-
-		regulators {
-			vdd_logic: DCDC_REG1 {
-				regulator-name = "vdd_logic";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1150000>;
-				regulator-ramp-delay = <6001>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <950000>;
-				};
-			};
-
-			vdd_arm: DCDC_REG2 {
-				regulator-name = "vdd_arm";
-				regulator-min-microvolt = <950000>;
-				regulator-max-microvolt = <1350000>;
-				regulator-ramp-delay = <6001>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <950000>;
-				};
-			};
-
-			vcc_ddr: DCDC_REG3 {
-				regulator-name = "vcc_ddr";
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-				};
-			};
-
-			vcc_3v3: DCDC_REG4 {
-				regulator-name = "vcc_3v3";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcc_1v8: LDO_REG2 {
-				regulator-name = "vcc_1v8";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1800000>;
-				};
-			};
-
-			vdd_1v0: LDO_REG3 {
-				regulator-name = "vdd_1v0";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1000000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <1000000>;
-				};
-			};
-
-			vcc3v3_pmu: LDO_REG4 {
-				regulator-name = "vcc3v3_pmu";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vccio_sd: LDO_REG5 {
-				regulator-name = "vccio_sd";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcc_sd: LDO_REG6 {
-				regulator-name = "vcc_sd";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-
-				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcc_bl: LDO_REG7 {
-				regulator-name = "vcc_bl";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
-				};
-			};
-
-			vcc_lcd: LDO_REG8 {
-				regulator-name = "vcc_lcd";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <2800000>;
-				};
-			};
-
-			vcc_cam: LDO_REG9 {
-				regulator-name = "vcc_cam";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
-
-				regulator-state-mem {
-					regulator-off-in-suspend;
-					regulator-suspend-microvolt = <3000000>;
-				};
-			};
-
-			usb_midu: BOOST {
-				regulator-name = "usb_midu";
-				regulator-min-microvolt = <5000000>;
-				regulator-max-microvolt = <5400000>;
-				regulator-always-on;
-				regulator-boot-on;
-			};
-		};
-
-		rk817_charger: charger {
-			monitored-battery = <&battery>;
-			rockchip,resistor-sense-micro-ohms = <10000>;
-			rockchip,sleep-enter-current-microamp = <300000>;
-			rockchip,sleep-filter-current-microamp = <100000>;
-		};
-
-		rk817_codec: codec {
-			rockchip,mic-in-differential;
-		};
-	};
-};
-
-/* EXT Header(P2): 7(SCL:GPIO0.C2), 8(SDA:GPIO0.C3) */
-&i2c1 {
-	clock-frequency = <400000>;
-	status = "okay";
-};
-
-/* I2S 1 Channel Used */
-&i2s1_2ch {
-	status = "okay";
-};
-
-&io_domains {
-	vccio1-supply = <&vcc_3v3>;
-	vccio2-supply = <&vccio_sd>;
-	vccio3-supply = <&vcc_3v3>;
-	vccio4-supply = <&vcc_3v3>;
-	vccio5-supply = <&vcc_3v3>;
-	vccio6-supply = <&vcc_3v3>;
-	status = "okay";
-};
-
-&pmu_io_domains {
-	pmuio1-supply = <&vcc3v3_pmu>;
-	pmuio2-supply = <&vcc3v3_pmu>;
-	status = "okay";
-};
-
-&pwm1 {
-	status = "okay";
-};
-
-&saradc {
-	vref-supply = <&vcc_1v8>;
-	status = "okay";
-};
-
-&sdmmc {
-	cap-sd-highspeed;
-	card-detect-delay = <200>;
-	cd-gpios = <&gpio0 RK_PA3 GPIO_ACTIVE_LOW>; /*[> CD GPIO <]*/
-	sd-uhs-sdr12;
-	sd-uhs-sdr25;
-	sd-uhs-sdr50;
-	sd-uhs-sdr104;
-	vmmc-supply = <&vcc_sd>;
-	vqmmc-supply = <&vccio_sd>;
-	status = "okay";
-};
-
-&sfc {
-	pinctrl-0 = <&sfc_clk &sfc_cs0 &sfc_bus2>;
-	pinctrl-names = "default";
-	#address-cells = <1>;
-	#size-cells = <0>;
-	status = "okay";
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <108000000>;
-		spi-rx-bus-width = <2>;
-		spi-tx-bus-width = <1>;
-	};
-};
-
-&tsadc {
-	status = "okay";
-};
-
-&u2phy {
-	status = "okay";
-
-	u2phy_host: host-port {
-		status = "okay";
-	};
-
-	u2phy_otg: otg-port {
-		status = "disabled";
-	};
-};
-
-&usb20_otg {
-	status = "okay";
-};
-
-/* EXT Header(P2): 2(RXD:GPIO1.C0),3(TXD:.C1),4(CTS:.C2),5(RTS:.C3) */
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_xfer &uart1_cts>;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart2m1_xfer>;
-	status = "okay";
-};
-
-&vopb {
-	status = "okay";
-};
-
-&vopb_mmu {
-	status = "okay";
-};
-
-&pinctrl {
-	btns {
-		btn_pins: btn-pins {
-			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up>,
-					<1 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up>,
-					<2 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>,
-					<2 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>,
-					<2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>,
-					<2 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>,
-					<2 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>,
-					<2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>,
-					<2 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
-					<2 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	headphone {
-		hp_det: hp-det {
-			rockchip,pins = <2 RK_PC6 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
-	};
-
-	leds {
-		blue_led_pin: blue-led-pin {
-			rockchip,pins = <0 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	pmic {
-		dc_det: dc-det {
-			rockchip,pins = <0 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		pmic_int: pmic-int {
-			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		soc_slppin_gpio: soc_slppin_gpio {
-			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_output_low>;
-		};
-
-		soc_slppin_rst: soc_slppin_rst {
-			rockchip,pins = <0 RK_PA4 2 &pcfg_pull_none>;
-		};
-
-		soc_slppin_slp: soc_slppin_slp {
-			rockchip,pins = <0 RK_PA4 1 &pcfg_pull_none>;
-		};
-	};
+&rk817_charger {
+	monitored-battery = <&battery>;
 };
-- 
2.38.1

