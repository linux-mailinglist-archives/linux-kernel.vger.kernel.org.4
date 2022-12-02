Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F75963FF77
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 05:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiLBEZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 23:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiLBEZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 23:25:21 -0500
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D692D20B8;
        Thu,  1 Dec 2022 20:25:13 -0800 (PST)
X-QQ-mid: bizesmtp63t1669955090tuf8veys
Received: from localhost ( [202.85.220.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 02 Dec 2022 12:24:48 +0800 (CST)
X-QQ-SSF: 0140000000200080B000B00A0000000
X-QQ-FEAT: 90EFqYDyPxDst/KhCz5KF2JNxlHDou9nzLOQZym2sABkv9G7icXwrwLUFy2tS
        W9vi9I3CAaU2g9ppHkyaV7gp4X2ezEprt/O+ZdHhpvlcg3vDwynPNPpEjkoPJHxaPOZ/LKY
        0q0ZZFoJKANPNF8zyTPb1Ppa+ODyNJ5OxE3NRxxCjI5wVMw9qNUjGPFPNapPrZNhtZdVWWc
        DbvTvWO3syjJoqUi9RLyqlQJbWaXv0SPaeLhj4iCv7JZuib1xT6O5YRsUHAU3UGTo0wso9B
        X1Bq+U0Hi0K6mI5om1QtnY2qOeCgY9CmdGBb3ZPSiyeE+7hnt5CkilqDHdvBW1xyd6mS1FI
        boGi9Hb1djNU0hL0zZrKpX045Uq3erUQpz6P4bs6GiMQkfIBfZG0CfjRxbcufSCfAQ1CClq
X-QQ-GoodBg: 2
Date:   Fri, 2 Dec 2022 12:24:48 +0800
From:   Wang Honghui <honghui.wang@ucas.com.cn>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Wang Honghui <honghui.wang@ucas.com.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] arm64/boot/dts and arm_scpi: add to support Phytium FT2004
 CPU
Message-ID: <0D48D1B7AC373F2F+Y4l+EOBIC9SmZD2A@TP-P15V>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:ucas.com.cn:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_NONE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64/boot/dts and arm_scpi: add to support Phytium FT2004 CPU.

Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
---
 arch/arm64/Kconfig.platforms                  |   5 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/phytium/Makefile          |   5 +
 .../dts/phytium/ft2004-devboard-d4-dsk.dts    |  73 +++
 .../dts/phytium/ft2004-generic-psci-soc.dtsi  | 469 ++++++++++++++++++
 drivers/firmware/arm_scpi.c                   |   1 +
 6 files changed, 554 insertions(+)
 create mode 100644 arch/arm64/boot/dts/phytium/Makefile
 create mode 100644 arch/arm64/boot/dts/phytium/ft2004-devboard-d4-dsk.dts
 create mode 100644 arch/arm64/boot/dts/phytium/ft2004-generic-psci-soc.dtsi

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 76580b932e44..7e8b17855eb7 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -236,6 +236,11 @@ config ARCH_NPCM
 	  General support for NPCM8xx BMC (Arbel).
 	  Nuvoton NPCM8xx BMC based on the Cortex A35.
 
+config ARCH_PHYTIUM
+        bool "Phytium SoC Family"
+        help
+          This enables support for Phytium ARMv8 SoC family.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 7b107fa7414b..386e74291f32 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -21,6 +21,7 @@ subdir-y += mediatek
 subdir-y += microchip
 subdir-y += nuvoton
 subdir-y += nvidia
+subdir-y += phytium
 subdir-y += qcom
 subdir-y += realtek
 subdir-y += renesas
diff --git a/arch/arm64/boot/dts/phytium/Makefile b/arch/arm64/boot/dts/phytium/Makefile
new file mode 100644
index 000000000000..911190cb1199
--- /dev/null
+++ b/arch/arm64/boot/dts/phytium/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_PHYTIUM) += ft2004-devboard-d4-dsk.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/phytium/ft2004-devboard-d4-dsk.dts b/arch/arm64/boot/dts/phytium/ft2004-devboard-d4-dsk.dts
new file mode 100644
index 000000000000..5bef2e886292
--- /dev/null
+++ b/arch/arm64/boot/dts/phytium/ft2004-devboard-d4-dsk.dts
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DTS file for phytium FT-2000/4 devboard (FT-2000/4-D4-DSK series)
+ *
+ * Copyright (C) 2018-2019, Phytium Technology Co., Ltd.
+ */
+
+/dts-v1/;
+/memreserve/ 0x80000000 0x10000;
+
+#include "ft2004-generic-psci-soc.dtsi"
+
+/{
+	model = "FT-2000/4-D4-DSK Development Board";
+	compatible = "phytium,ft-2004";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen {
+		stdout-path = "uart1:115200n8";
+	};
+
+	memory@00{
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x1 0x00000000>;
+	};
+
+	memory@01{
+		device_type = "memory";
+		reg = <0x20 0x00000000 0x1 0x00000000>;
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+};
+
+&rtc0 {
+	status = "ok";
+};
+
+&uart1 {
+	status = "ok";
+};
+
+&gmac0 {
+	status = "ok";
+	phy-mode = "rgmii-rxid";
+};
+
+&gmac1 {
+	status = "ok";
+	phy-mode = "rgmii-rxid";
+};
+
+&spi0 {
+	status = "ok";
+};
+
+&qspi {
+	status = "ok";
+};
+
+&i2c0 {
+	status = "ok";
+};
+
+&i2c1 {
+	status = "ok";
+};
diff --git a/arch/arm64/boot/dts/phytium/ft2004-generic-psci-soc.dtsi b/arch/arm64/boot/dts/phytium/ft2004-generic-psci-soc.dtsi
new file mode 100644
index 000000000000..80d64e17899b
--- /dev/null
+++ b/arch/arm64/boot/dts/phytium/ft2004-generic-psci-soc.dtsi
@@ -0,0 +1,469 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for FT-2000/4 SoC
+ *
+ * Copyright (C) 2018-2019, Phytium Technology Co., Ltd.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "phytium,ft2004";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+	};
+
+	psci {
+		compatible   = "arm,psci-1.0";
+		method       = "smc";
+		cpu_suspend  = <0xc4000001>;
+		cpu_off      = <0x84000002>;
+		cpu_on       = <0xc4000003>;
+		sys_poweroff = <0x84000008>;
+		sys_reset    = <0x84000009>;
+	};
+
+	cpus {
+		#address-cells = <0x2>;
+		#size-cells = <0x0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			numa-node-id = <0>;
+			clocks = <&scpi_dvfs 0>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			numa-node-id = <0>;
+			clocks = <&scpi_dvfs 0>;
+		};
+
+		cpu2: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			numa-node-id = <0>;
+			clocks = <&scpi_dvfs 1>;
+		};
+
+		cpu3: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+			numa-node-id = <0>;
+			clocks = <&scpi_dvfs 1>;
+		};
+	};
+
+	gic: interrupt-controller@29900000 {
+		compatible = "arm,gic-v3";
+		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		interrupt-controller;
+		reg = <0x0 0x29900000 0 0x20000>,       /* GICD */
+		      <0x0 0x29980000 0 0x80000>,       /* GICR */
+		      <0x0 0x29c00000 0 0x10000>,       /* GICC */
+		      <0x0 0x29c10000 0 0x10000>,       /* GICH */
+		      <0x0 0x29c20000 0 0x10000>;       /* GICV */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+		its: gic-its@29920000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0x29920000 0x0 0x20000>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+		clock-frequency = <48000000>;
+	};
+
+	clocks {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		clk250mhz: clk250mhz {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <250000000>;
+		};
+
+		sysclk_48mhz: clk48mhz {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <48000000>;
+		};
+
+		sysclk_600mhz: clk600mhz {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <600000000>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-coherent;
+		ranges;
+
+		gpio0: gpio@28004000 {
+			compatible = "phytium,gpio";
+			reg = <0x0 0x28004000 0x0 0x1000>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			porta {
+				compatible = "phytium,gpio-port";
+				reg = <0>;
+				nr-gpios = <8>;
+			};
+
+			portb {
+				compatible = "phytium,gpio-port";
+				reg = <1>;
+				nr-gpios = <8>;
+			};
+		};
+
+		gpio1: gpio@28005000 {
+			compatible = "phytium,gpio";
+			reg = <0x0 0x28005000 0x0 0x1000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			porta {
+				compatible = "phytium,gpio-port";
+				reg = <0>;
+				nr-gpios = <8>;
+			};
+
+			portb {
+				compatible = "phytium,gpio-port";
+				reg = <1>;
+				nr-gpios = <8>;
+			};
+		};
+
+		uart0: uart@28000000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0x28000000 0x0 0x1000>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk_48mhz &sysclk_48mhz>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		uart1: uart@28001000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0x28001000 0x0 0x1000>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk_48mhz &sysclk_48mhz>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		uart2: uart@28002000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0x28002000 0x0 0x1000>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk_48mhz &sysclk_48mhz>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		uart3: uart@28003000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0x28003000 0x0 0x1000>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk_48mhz &sysclk_48mhz>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		sdci: sdci@28207c00 {
+			compatible = "phytium,sdci";
+			reg = <0x0 0x28207c00 0x0 0x100>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk_600mhz &sysclk_600mhz>;
+			clock-names = "phytium_sdc_clk";
+			no-sdio;
+			no-mmc;
+			no-dma-coherent;
+		};
+
+		watchdog0: watchdog@2800a000 {
+			compatible = "arm,sbsa-gwdt";
+			reg = <0x0 0x2800b000 0x0 0x1000>,
+			      <0x0 0x2800a000 0x0 0x1000>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			timeout-sec = <30>;
+		};
+
+		watchdog1: watchdog@28016000 {
+			compatible = "arm,sbsa-gwdt";
+			reg = <0x0 0x28017000 0x0 0x1000>,
+			      <0x0 0x28016000 0x0 0x1000>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			timeout-sec = <30>;
+		};
+
+		rtc0: rtc@2800d000 {
+			compatible = "phytium,rtc";
+			reg = <0x0 0x2800d000 0x0 0x1000>;
+			clocks = <&sysclk_48mhz>;
+			clock-names = "rtc_pclk";
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		i2c0: i2c@28006000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0x28006000 0x0 0x1000>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk_48mhz>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@28007000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0x28007000 0x0 0x1000>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk_48mhz>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@28008000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0x28008000 0x0 0x1000>;
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk_48mhz>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@28009000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0x28009000 0x0 0x1000>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk_48mhz>;
+			status = "disabled";
+		};
+
+		spi0: spi@2800c000 {
+			compatible = "phytium,spi";
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x0 0x2800c000 0x0 0x1000>;
+			clocks = <&sysclk_48mhz>;
+			num-cs = <4>;
+		};
+
+		spi1: spi@28013000 {
+			compatible = "phytium,spi";
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x0 0x28013000 0x0 0x1000>;
+			clocks = <&sysclk_48mhz>;
+			num-cs = <4>;
+		};
+
+		qspi: qspi@28014000 {
+			compatible = "phytium,qspi";
+			reg = <0x0 0x28014000 0x0     0x1000>,
+			      <0x0        0x0 0x0 0x02000000>;
+			reg-names = "qspi", "qspi_mm";
+			clocks = <&sysclk_600mhz>;
+
+			flash@0 {
+				spi-rx-bus-width = <1>;
+				spi-max-frequency = <600000000>;
+			};
+		};
+
+		pcie: pcie {
+			compatible = "pci-host-ecam-generic";
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			reg = <0x0 0x40000000 0x0 0x10000000>;
+			msi-parent = <&its>;
+			bus-range = <0x0 0xff>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0x0 GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+					<0x0 0x0 0x0 0x2 &gic 0x0 0x0 GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+					<0x0 0x0 0x0 0x3 &gic 0x0 0x0 GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+					<0x0 0x0 0x0 0x4 &gic 0x0 0x0 GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			ranges = <0x01000000 0x00 0x00000000 0x0  0x50000000  0x0  0x00f00000>,
+				 <0x02000000 0x00 0x58000000 0x0  0x58000000  0x0  0x28000000>,
+				 <0x03000000 0x10 0x00000000 0x10 0x00000000 0x10  0x00000000>;
+		};
+
+		phytium_axi_setup: stmmac-axi-config {
+			snps,wr_osr_lmt = <0>;
+			snps,rd_osr_lmt = <0>;
+			snps,blen = <0 0 0 0 16 8 4>;
+		};
+
+		gmac0: eth@2820c000 {
+			compatible = "snps,dwmac";
+			reg = <0x0 0x2820c000 0x0 0x2000>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&clk250mhz>;
+			clock-names = "stmmaceth";
+			status = "disabled";
+
+			snps,pbl = <16>;
+			snps,fixed-burst;
+			snps,axi-config = <&phytium_axi_setup>;
+			snps,force_sf_dma_mode;
+			snps,multicast-filter-bins = <64>;
+			snps,perfect-filter-entries = <128>;
+			tx-fifo-depth = <4096>;
+			rx-fifo-depth = <4096>;
+			max-frame-size = <9000>;
+		};
+
+		gmac1: eth@28210000 {
+			compatible = "snps,dwmac";
+			reg = <0x0 0x28210000 0x0 0x2000>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&clk250mhz>;
+			clock-names = "stmmaceth";
+			status = "disabled";
+
+			snps,pbl = <16>;
+			snps,fixed-burst;
+			snps,axi-config = <&phytium_axi_setup>;
+			snps,force_sf_dma_mode;
+			snps,multicast-filter-bins = <64>;
+			snps,perfect-filter-entries = <128>;
+			snps,rx-queues-to-use = <2>;
+			tx-fifo-depth = <4096>;
+			rx-fifo-depth = <4096>;
+			max-frame-size = <9000>;
+		};
+
+		can0: can@28207000 {
+			compatible = "phytium,can";
+			reg = <0x0 0x28207000 0x0 0x400>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk_600mhz>;
+			clock-names = "phytium_can_clk";
+			tx-fifo-depth = <0x40>;
+			rx-fifo-depth = <0x40>;
+		};
+
+		can1: can@28207400 {
+			compatible = "phytium,can";
+			reg = <0x0 0x28207400 0x0 0x400>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk_600mhz>;
+			clock-names = "phytium_can_clk";
+			tx-fifo-depth = <0x40>;
+			rx-fifo-depth = <0x40>;
+		};
+
+		can2: can@028207800 {
+			compatible = "phytium,can";
+			reg = <0x0 0x28207800 0x0 0x400>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk_600mhz>;
+			clock-names = "phytium_can_clk";
+			tx-fifo-depth = <0x40>;
+			rx-fifo-depth = <0x40>;
+		};
+
+		hda: hda@28206000 {
+			compatible = "phytium,hda";
+			reg = <0 0x28206000 0x0 0x1000>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sysclk_48mhz>;
+			clock-names = "phytium_hda_clk";
+		};
+
+		mbox: mailbox@2a000000 {
+			compatible = "phytium,mbox";
+			reg = <0x0 0x2a000000 0x0 0x1000>;
+			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+			clocks = <&sysclk_48mhz>;
+			clock-names = "apb_pclk";
+		};
+
+		sram: sram@2a006000 {
+			compatible = "phytium,ft2004-sram-ns","mmio-sram";
+			reg = <0x0 0x2a006000 0x0 0x2000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x2a006000 0x2000>;
+
+			scpi_lpri: scpi-shmem@0 {
+				compatible = "phytium,ft2004-scpi-shmem";
+				reg = <0x1000 0x800>;
+			};
+		};
+
+		scpi_protocol: scpi {
+			compatible = "arm,scpi";
+			mboxes = <&mbox 0>;
+			shmem = <&scpi_lpri>;
+
+			clocks {
+				compatible = "arm,scpi-clocks";
+
+				scpi_dvfs: scpi_clocks@0 {
+					compatible = "arm,scpi-dvfs-clocks";
+					#clock-cells = <1>;
+					clock-indices = <0>, <1>;
+					clock-output-names = "c0", "c1";
+				};
+			};
+
+			scpi_sensors: sensors {
+				compatible = "arm,scpi-sensors";
+				#thermal-sensor-cells = <1>;
+			};
+		};
+	};
+};
diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 435d0e2658a4..876eb2f9ff81 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -904,6 +904,7 @@ static const struct of_device_id shmem_of_match[] __maybe_unused = {
 	{ .compatible = "amlogic,meson-axg-scp-shmem", },
 	{ .compatible = "arm,juno-scp-shmem", },
 	{ .compatible = "arm,scp-shmem", },
+	{ .compatible = "phytium,ft2004-scpi-shmem", },
 	{ }
 };
 
-- 
2.34.1

