Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEF773F85F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjF0JKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjF0JK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:10:26 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C3510D7;
        Tue, 27 Jun 2023 02:10:16 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3112f5ab0b1so3872634f8f.0;
        Tue, 27 Jun 2023 02:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687857015; x=1690449015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIREuT8WCYLGO8AV4jJbJ2pawv29YXb0EoW8TVpl8gM=;
        b=MLQXkAmqRXKxacNTnZf+ppe0zM+4Ok38tLqrdw8skrdjuh1wqdAIO/8OvuKluGW3D8
         PSDqXYfXGWueT+30HTRXnTCm1e33WQtkqUv0xIFPGzjd/vgB/ljcZrypFVa/+o3dWGEC
         bzLpB2JWo+xlSa12egQnZfWvEqL3lx2/avUT3kMxuR3D+qraAW6SDoGABB75q7SCx7+m
         6kUJ1dV/MHgegZS1Wnb4X8VYZp+BGAq0h1APXUGp1NbMN1qvcg/YL/4ySefg8LdfADCQ
         rjZaOy3AbOL9mcHDjKgc4XL36tOwmHiQksaFKYXASHfeAele6RwPEqJxraK3L4lRdZdg
         cYxg==
X-Gm-Message-State: AC+VfDyQuX1hW+HWfzEwhI43CsDyjBOpx/s5hdDHuLG3n39yOk8xMl+S
        tRaW+KjtwhdSjEUseIAWExQ=
X-Google-Smtp-Source: ACHHUZ6jaJIQnXpAEZc5HrUhOBbNKfvxfUVi1ntKTxQaR52QJJ3TF43hDaG1uHfAblKuL9sRFK/tiQ==
X-Received: by 2002:adf:f80e:0:b0:313:f3b4:ca76 with SMTP id s14-20020adff80e000000b00313f3b4ca76mr3630730wrp.57.1687857015111;
        Tue, 27 Jun 2023 02:10:15 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id c15-20020adffb4f000000b00313e4d02be8sm8880122wrs.55.2023.06.27.02.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 02:10:14 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lucas Tanure <tanure@linux.com>
Subject: [PATCH v6 4/4] arm64: dts: amlogic-t7-a311d2-khadas-vim4: add initial device-tree
Date:   Tue, 27 Jun 2023 10:10:07 +0100
Message-ID: <20230627091007.190958-5-tanure@linux.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627091007.190958-1-tanure@linux.com>
References: <20230627091007.190958-1-tanure@linux.com>
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
 .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts |  52 ++++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 158 ++++++++++++++++++
 3 files changed, 211 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index cd1c5b04890a..166fec1e4229 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j100.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j110-rev-2.dtb
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
new file mode 100644
index 000000000000..5d7fb86a9738
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2022 Wesion, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "amlogic-t7.dtsi"
+
+/ {
+	model = "Khadas vim4";
+	compatible = "khadas,vim4", "amlogic,a311d2", "amlogic,t7";
+
+	aliases {
+		serial0 = &uart_A;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x2 0x0>; /* 8 GB */
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
+};
+
+&uart_A {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
new file mode 100644
index 000000000000..6f3971b4df99
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
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
+		};
+
+		cpu101: cpu@101{
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+		};
+
+		cpu102: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x102>;
+			enable-method = "psci";
+		};
+
+		cpu103: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x103>;
+			enable-method = "psci";
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a73";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
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
+	psci {
+		compatible = "arm,psci-1.0";
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
+		gic: interrupt-controller@fff01000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0xfff01000 0 0x1000>,
+			      <0x0 0xfff02000 0 0x0100>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		apb4: bus@fe000000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xfe000000 0x0 0x480000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
+
+			uart_A: serial@78000 {
+				compatible = "amlogic,t7-uart",
+					     "amlogic,meson-s4-uart";
+				reg = <0x0 0x78000 0x0 0x18>;
+				interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
+				clocks = <&xtal>, <&xtal>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+			};
+		};
+
+	};
+};
-- 
2.41.0

