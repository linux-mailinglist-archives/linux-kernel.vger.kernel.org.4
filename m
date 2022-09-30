Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312675F0607
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiI3Hvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiI3Hvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:51:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA7473905;
        Fri, 30 Sep 2022 00:51:30 -0700 (PDT)
X-QQ-mid: bizesmtp64t1664524157twghgn92
Received: from ubuntu.localdomain ( [113.72.146.201])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Sep 2022 15:49:16 +0800 (CST)
X-QQ-SSF: 01000000000000305000000A0000000
X-QQ-FEAT: dcYQFNbI8vF/ZXIzspBCLiWGx6eyLdAUf1gWuSEO7ysHQNV/9IjEcIeS4KKRd
        lalkonPRD5gcTNlomR0FEimLp1F5v54Rm9TkjWBvaoSp4js0LWldVMrqJ8MhzIEa2tjtFvK
        lkEyTSxqBfba3wV+R7/YvA5x5cMT88S2uN+dkxv6uEXaBQAVho45gGuJD7RDhvecbZ/MUNX
        EWlDKtuGQnf42hyGCknR76rPCmAAujz2471cw/aUMY219VF/+C4VaUZj/g7Rx0F4Gc8x4wf
        YPChfwizTe2nZTHGFhQ+kERGNj2g5a9mcG+iYaiYfX7NaqmxMcR9Dblex/TcPYKcFSSsDNr
        UPqZcQ+PoOjwVh28PdBjDP7wGNbT7AUbonMZczOifE73S5YkaEpg2YeHXXWWN5I3JZHgTIO
        MtM+S/rQ0s4=
X-QQ-GoodBg: 0
From:   Hal Feng <hal.feng@linux.starfivetech.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 27/30] RISC-V: Add initial StarFive JH7110 device tree
Date:   Fri, 30 Sep 2022 15:49:14 +0800
Message-Id: <20220930074914.6757-1-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add initial device tree for the JH7110 RISC-V SoC by
StarFive Technology Ltd.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 449 +++++++++++++++++++++++
 1 file changed, 449 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110.dtsi

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
new file mode 100644
index 000000000000..46f418d4198a
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -0,0 +1,449 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+/dts-v1/;
+#include <dt-bindings/clock/starfive-jh7110-sys.h>
+#include <dt-bindings/clock/starfive-jh7110-aon.h>
+#include <dt-bindings/reset/starfive-jh7110.h>
+
+/ {
+	compatible = "starfive,jh7110";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "sifive,u74-mc", "riscv";
+			reg = <0>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <8192>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <40>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <16384>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <40>;
+			mmu-type = "riscv,sv39";
+			next-level-cache = <&ccache>;
+			riscv,isa = "rv64imac";
+			tlb-split;
+			status = "disabled";
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu1: cpu@1 {
+			compatible = "sifive,u74-mc", "riscv";
+			reg = <1>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <40>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <40>;
+			mmu-type = "riscv,sv39";
+			next-level-cache = <&ccache>;
+			riscv,isa = "rv64imafdc";
+			tlb-split;
+
+			cpu1_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu2: cpu@2 {
+			compatible = "sifive,u74-mc", "riscv";
+			reg = <2>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <40>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <40>;
+			mmu-type = "riscv,sv39";
+			next-level-cache = <&ccache>;
+			riscv,isa = "rv64imafdc";
+			tlb-split;
+
+			cpu2_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu3: cpu@3 {
+			compatible = "sifive,u74-mc", "riscv";
+			reg = <3>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <40>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <40>;
+			mmu-type = "riscv,sv39";
+			next-level-cache = <&ccache>;
+			riscv,isa = "rv64imafdc";
+			tlb-split;
+
+			cpu3_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu4: cpu@4 {
+			compatible = "sifive,u74-mc", "riscv";
+			reg = <4>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <40>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <40>;
+			mmu-type = "riscv,sv39";
+			next-level-cache = <&ccache>;
+			riscv,isa = "rv64imafdc";
+			tlb-split;
+
+			cpu4_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+
+				core2 {
+					cpu = <&cpu2>;
+				};
+
+				core3 {
+					cpu = <&cpu3>;
+				};
+
+				core4 {
+					cpu = <&cpu4>;
+				};
+			};
+		};
+	};
+
+	osc: osc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	clk_rtc: clk_rtc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	gmac0_rmii_refin: gmac0_rmii_refin {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
+
+	gmac0_rgmii_rxin: gmac0_rgmii_rxin {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	gmac1_rmii_refin: gmac1_rmii_refin {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
+
+	gmac1_rgmii_rxin: gmac1_rgmii_rxin {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	i2stx_bclk_ext: i2stx_bclk_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12288000>;
+	};
+
+	i2stx_lrck_ext: i2stx_lrck_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <192000>;
+	};
+
+	i2srx_bclk_ext: i2srx_bclk_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12288000>;
+	};
+
+	i2srx_lrck_ext: i2srx_lrck_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <192000>;
+	};
+
+	tdm_ext: tdm_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <49152000>;
+	};
+
+	mclk_ext: mclk_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <49152000>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&plic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		clint: clint@2000000 {
+			compatible = "starfive,jh7110-clint", "sifive,clint0";
+			reg = <0x0 0x2000000 0x0 0x10000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
+					      <&cpu1_intc 3>, <&cpu1_intc 7>,
+					      <&cpu2_intc 3>, <&cpu2_intc 7>,
+					      <&cpu3_intc 3>, <&cpu3_intc 7>,
+					      <&cpu4_intc 3>, <&cpu4_intc 7>;
+		};
+
+		plic: plic@c000000 {
+			compatible = "starfive,jh7110-plic", "sifive,plic-1.0.0";
+			reg = <0x0 0xc000000 0x0 0x4000000>;
+			interrupts-extended = <&cpu0_intc 11>,
+					      <&cpu1_intc 11>, <&cpu1_intc 9>,
+					      <&cpu2_intc 11>, <&cpu2_intc 9>,
+					      <&cpu3_intc 11>, <&cpu3_intc 9>,
+					      <&cpu4_intc 11>, <&cpu4_intc 9>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			riscv,ndev = <136>;
+		};
+
+		ccache: cache-controller@2010000 {
+			compatible = "starfive,jh7110-ccache", "cache";
+			reg = <0x0 0x2010000 0x0 0x4000>;
+			interrupts = <1>, <3>, <4>, <2>;
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-sets = <2048>;
+			cache-size = <2097152>;
+			cache-unified;
+		};
+
+		syscrg: syscrg@13020000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x0 0x13020000 0x0 0x10000>;
+
+			syscrg_clk: clock-controller@13020000 {
+				compatible = "starfive,jh7110-clkgen-sys";
+				clocks = <&osc>, <&gmac1_rmii_refin>,
+					 <&gmac1_rgmii_rxin>,
+					 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
+					 <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
+					 <&tdm_ext>, <&mclk_ext>;
+				clock-names = "osc", "gmac1_rmii_refin",
+					"gmac1_rgmii_rxin",
+					"i2stx_bclk_ext", "i2stx_lrck_ext",
+					"i2srx_bclk_ext", "i2srx_lrck_ext",
+					"tdm_ext", "mclk_ext";
+				#clock-cells = <1>;
+			};
+
+			syscrg_rst: reset-controller@13020000 {
+				compatible = "starfive,jh7110-reset";
+				#reset-cells = <1>;
+				starfive,assert-offset = <0x2F8>;
+				starfive,status-offset= <0x308>;
+				starfive,nr-resets = <JH7110_SYSRST_END>;
+			};
+		};
+
+		aoncrg: aoncrg@17000000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x0 0x17000000 0x0 0x10000>;
+
+			aoncrg_clk: clock-controller@17000000 {
+				compatible = "starfive,jh7110-clkgen-aon";
+				clocks = <&osc>, <&clk_rtc>,
+					 <&gmac0_rmii_refin>, <&gmac0_rgmii_rxin>,
+					 <&syscrg_clk JH7110_SYSCLK_STG_AXIAHB>,
+					 <&syscrg_clk JH7110_SYSCLK_APB_BUS_FUNC>;
+				clock-names = "osc", "clk_rtc",
+					"gmac0_rmii_refin", "gmac0_rgmii_rxin",
+					"stg_axiahb", "apb_bus_func";
+				#clock-cells = <1>;
+			};
+
+			aoncrg_rst: reset-controller@17000000 {
+				compatible = "starfive,jh7110-reset";
+				#reset-cells = <1>;
+				starfive,assert-offset = <0x38>;
+				starfive,status-offset= <0x3C>;
+				starfive,nr-resets = <JH7110_AONRST_END>;
+			};
+		};
+
+		gpio: gpio@13040000 {
+			compatible = "starfive,jh7110-sys-pinctrl";
+			reg = <0x0 0x13040000 0x0 0x10000>;
+			reg-names = "control";
+			clocks = <&syscrg_clk JH7110_SYSCLK_IOMUX>;
+			resets = <&syscrg_rst JH7110_SYSRST_IOMUX>;
+			interrupts = <86>;
+			interrupt-controller;
+			#gpio-cells = <2>;
+			ngpios = <64>;
+		};
+
+		gpioa: gpio@17020000 {
+			compatible = "starfive,jh7110-aon-pinctrl";
+			reg = <0x0 0x17020000 0x0 0x10000>;
+			reg-names = "control";
+			resets = <&aoncrg_rst JH7110_AONRST_AON_IOMUX>;
+			interrupts = <85>;
+			interrupt-controller;
+			#gpio-cells = <2>;
+			ngpios = <4>;
+		};
+
+		uart0: serial@10000000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x10000000 0x0 0x10000>;
+			clocks = <&syscrg_clk JH7110_SYSCLK_UART0_CORE>,
+				 <&syscrg_clk JH7110_SYSCLK_UART0_APB>;
+			clock-names = "baudclk", "apb_pclk";
+			resets = <&syscrg_rst JH7110_SYSRST_UART0_APB>,
+				 <&syscrg_rst JH7110_SYSRST_UART0_CORE>;
+			interrupts = <32>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart1: serial@10010000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x10010000 0x0 0x10000>;
+			clocks = <&syscrg_clk JH7110_SYSCLK_UART1_CORE>,
+				 <&syscrg_clk JH7110_SYSCLK_UART1_APB>;
+			clock-names = "baudclk", "apb_pclk";
+			resets = <&syscrg_rst JH7110_SYSRST_UART1_APB>,
+				 <&syscrg_rst JH7110_SYSRST_UART1_CORE>;
+			interrupts = <33>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart2: serial@10020000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x10020000 0x0 0x10000>;
+			clocks = <&syscrg_clk JH7110_SYSCLK_UART2_CORE>,
+				 <&syscrg_clk JH7110_SYSCLK_UART2_APB>;
+			clock-names = "baudclk", "apb_pclk";
+			resets = <&syscrg_rst JH7110_SYSRST_UART2_APB>,
+				 <&syscrg_rst JH7110_SYSRST_UART2_CORE>;
+			interrupts = <34>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart3: serial@12000000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x12000000 0x0 0x10000>;
+			clocks = <&syscrg_clk JH7110_SYSCLK_UART3_CORE>,
+				 <&syscrg_clk JH7110_SYSCLK_UART3_APB>;
+			clock-names = "baudclk", "apb_pclk";
+			resets = <&syscrg_rst JH7110_SYSRST_UART3_APB>,
+				 <&syscrg_rst JH7110_SYSRST_UART3_CORE>;
+			interrupts = <45>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart4: serial@12010000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x12010000 0x0 0x10000>;
+			clocks = <&syscrg_clk JH7110_SYSCLK_UART4_CORE>,
+				 <&syscrg_clk JH7110_SYSCLK_UART4_APB>;
+			clock-names = "baudclk", "apb_pclk";
+			resets = <&syscrg_rst JH7110_SYSRST_UART4_APB>,
+				 <&syscrg_rst JH7110_SYSRST_UART4_CORE>;
+			interrupts = <46>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart5: serial@12020000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x12020000 0x0 0x10000>;
+			clocks = <&syscrg_clk JH7110_SYSCLK_UART5_CORE>,
+				 <&syscrg_clk JH7110_SYSCLK_UART5_APB>;
+			clock-names = "baudclk", "apb_pclk";
+			resets = <&syscrg_rst JH7110_SYSRST_UART5_APB>,
+				 <&syscrg_rst JH7110_SYSRST_UART5_CORE>;
+			interrupts = <47>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.17.1

