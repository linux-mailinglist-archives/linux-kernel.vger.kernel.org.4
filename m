Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3CD73200B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbjFOSaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbjFOS3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:29:51 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70205199D;
        Thu, 15 Jun 2023 11:29:49 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3f736e0c9b1so21814465e9.3;
        Thu, 15 Jun 2023 11:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686853788; x=1689445788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JI1i4EwWoNksCYYpwNaalHERmGfCERT/YIthAdEWfQ4=;
        b=cIBOVcxs0Ukvgj7T8xxlBIb4wiv35LdcBGFTV/Wt5VYY/MwtzK8o5kgw1/Dn2b1KYM
         GWbRjq0YDWwRRHJt9HibU9Bq8xfDnmlKFtIZDd4rzLza26dcHQ8lIg071b33Sa5Rqgcb
         PIs08iRbiQLB0/UZGhrXmA97XC95qlhFUMDhRPqV7a+nmT6LrKH2c1x+A2qHg+fmHs8t
         SHeeo/7mlK5lxKxycbasJcfKr7TUu5k/bDxgQngeQXxBKKZFT608suHyDK/bp00VkILl
         tVDJIZiNE5VpChqVklD1fPtmeFCd2I+oEDpRB6c4T7BZ0wK0P3jfSc3IQCjyg7+7bzd+
         DrMQ==
X-Gm-Message-State: AC+VfDwf6pK9nk3w3NrrEtu4xBbYZIOPskqsvtzdognrlGemUZi9qH3e
        QYR1OZ3bLItflSn2TgiMfLk1poeaGrqNzw==
X-Google-Smtp-Source: ACHHUZ5NQdaGmQ/S8Qlea+4toOAIbbno2kkfxmDxqWo9d8JC7/24a1gAIqMcx2xo7VFSU+E8U5dyqA==
X-Received: by 2002:a5d:40cb:0:b0:311:1dba:ca65 with SMTP id b11-20020a5d40cb000000b003111dbaca65mr36638wrq.51.1686853787832;
        Thu, 15 Jun 2023 11:29:47 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb03000000b0030ab5ebefa8sm21525887wrr.46.2023.06.15.11.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 11:29:47 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Lucas Tanure <tanure@linux.com>
Subject: [PATCH 6/6] arm64: dts: meson-t7-a311d2-khadas-vim4: add initial device-tree
Date:   Thu, 15 Jun 2023 19:29:38 +0100
Message-ID: <20230615182938.18487-7-tanure@linux.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230615182938.18487-1-tanure@linux.com>
References: <20230615182938.18487-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Khadas VIM4 uses the Amlogic A311D2 SoC, based on the Amlogic T7 SoC
family, on a board with the same form factor as the VIM3 models.

- 8GB LPDDR4X 2016MHz
- 32GB eMMC 5.1 storage
- 32MB SPI flash
- 10/100/1000 Base-T Ethernet
- AP6275S Wireless (802.11 a/b/g/n/ac/ax, BT5.1)
- HDMI 2.1 video
- HDMI Input
- 1x USB 2.0 + 1x USB 3.0 ports
- 1x USB-C (power) with USB 2.0 OTG
- 3x LED's (1x red, 1x blue, 1x white)
- 3x buttons (power, function, reset)
- M2 socket with PCIe, USB, ADC & I2C
- 40pin GPIO Header
- 1x micro SD card slot

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../amlogic/meson-t7-a311d2-khadas-vim4.dts   | 112 ++++++++++
 arch/arm64/boot/dts/amlogic/meson-t7.dtsi     | 202 ++++++++++++++++++
 3 files changed, 315 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-t7-a311d2-khadas-vim4.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-t7.dtsi

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index cd1c5b04890a..1c5846bd1ca0 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -74,3 +74,4 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air-gbit.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-t7-a311d2-khadas-vim4.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/meson-t7-a311d2-khadas-vim4.dts
new file mode 100644
index 000000000000..46e175536edf
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-t7-a311d2-khadas-vim4.dts
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2022 Wesion, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "meson-t7.dtsi"
+
+/ {
+	model = "Khadas VIM4";
+
+	aliases {
+		serial0 = &uart_A;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 3 MiB reserved for ARM Trusted Firmware (BL31) */
+		secmon_reserved: secmon@5000000 {
+			reg = <0x0 0x05000000 0x0 0x300000>;
+			no-map;
+		};
+
+		/* 32 MiB reserved for ARM Trusted Firmware (BL32) */
+		secmon_reserved_bl32: secmon@5300000 {
+			reg = <0x0 0x05300000 0x0 0x2000000>;
+			no-map;
+		};
+	};
+
+	xtal: xtal-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "xtal";
+		#clock-cells = <0>;
+	};
+
+	vddcpu_a: regulator-vddcpu-a {
+		/*
+		 * MP8756GD Regulator.
+		 */
+		compatible = "pwm-regulator";
+
+		regulator-name = "VDDCPU_A";
+		regulator-min-microvolt = <689000>;
+		regulator-max-microvolt = <1049000>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vddcpu_b: regulator-vddcpu-a {
+		/*
+		 * MP8756GD Regulator.
+		 */
+		compatible = "pwm-regulator";
+
+		regulator-name = "VDDCPU_B";
+		regulator-min-microvolt = <689000>;
+		regulator-max-microvolt = <1049000>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&clkc{
+	clocks = <&xtal>;
+	clock-names = "xtal";
+	status = "okay";
+};
+
+&uart_A {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&vddcpu_a>;
+};
+
+&cpu1 {
+	cpu-supply = <&vddcpu_a>;
+};
+
+&cpu2 {
+	cpu-supply = <&vddcpu_a>;
+};
+
+&cpu3 {
+	cpu-supply = <&vddcpu_a>;
+};
+
+&cpu100 {
+	cpu-supply = <&vddcpu_b>;
+};
+
+&cpu101 {
+	cpu-supply = <&vddcpu_b>;
+};
+
+&cpu102 {
+	cpu-supply = <&vddcpu_b>;
+};
+
+&cpu103 {
+	cpu-supply = <&vddcpu_b>;
+};
+
diff --git a/arch/arm64/boot/dts/amlogic/meson-t7.dtsi b/arch/arm64/boot/dts/amlogic/meson-t7.dtsi
new file mode 100644
index 000000000000..453b3d9cb9d8
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-t7.dtsi
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/clock/mesont7-clkc.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "amlogic,t7";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <0x2>;
+		#size-cells = <0x0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu100>;
+				};
+				core1 {
+					cpu = <&cpu101>;
+				};
+				core2 {
+					cpu = <&cpu102>;
+				};
+				core3 {
+					cpu = <&cpu103>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+		};
+
+		cpu100: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <632>;
+			dynamic-power-coefficient = <110>;
+			#cooling-cells = <2>;
+		};
+
+		cpu101: cpu@101{
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <632>;
+			dynamic-power-coefficient = <110>;
+			#cooling-cells = <2>;
+		};
+
+		cpu102: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x102>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <632>;
+			dynamic-power-coefficient = <110>;
+			#cooling-cells = <2>;
+		};
+
+		cpu103: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x103>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <632>;
+			dynamic-power-coefficient = <110>;
+			#cooling-cells = <2>;
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <550>;
+			#cooling-cells = <2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <550>;
+			#cooling-cells = <2>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <550>;
+			#cooling-cells = <2>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <550>;
+			#cooling-cells = <2>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 0xff08>,
+			     <GIC_PPI 14 0xff08>,
+			     <GIC_PPI 11 0xff08>,
+			     <GIC_PPI 10 0xff08>;
+	};
+
+	gic: interrupt-controller@fff01000 {
+		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x0 0xfff01000 0 0x1000>,
+		      <0x0 0xfff02000 0 0x0100>;
+		interrupts = <GIC_PPI 9 0xf04>;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	sm: secure-monitor {
+		compatible = "amlogic,meson-gxbb-sm";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		apb4: apb4@fe000000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xfe000000 0x0 0x480000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
+
+			clkc: clock-controller {
+				compatible = "amlogic,t7-clkc";
+				#clock-cells = <1>;
+				reg = <0x0 0x0 0x0 0x49c>,
+				      <0x0 0x8000 0x0 0x320>,
+				      <0x0 0xe040 0x0 0xbc>;
+				reg-names = "basic",
+					    "pll",
+					    "cpu_clk";
+			};
+
+			ao-secure@140 {
+				compatible = "amlogic,meson-gx-ao-secure", "syscon";
+				reg=<0x0 0x10220 0x0 0x140>;
+				amlogic,has-chip-id;
+			};
+		};
+
+		uart_A: serial@fe078000 {
+			compatible = "amlogic,meson-t7-uart";
+			reg = <0x0 0xfe078000 0x0 0x18>;
+			interrupts = <0 168 1>;
+			status = "disabled";
+			clocks = <&xtal>, <&clkc CLKID_UART_A>, <&xtal>;
+			clock-names = "xtal", "pclk", "baud";
+			fifo-size = < 64 >;
+			pinctrl-names = "default";
+		};
+	};
+};
+
--
2.41.0

