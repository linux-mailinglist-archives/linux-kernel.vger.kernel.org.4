Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E052965A83E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbiLaXjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiLaXjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:39:01 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C1562E3;
        Sat, 31 Dec 2022 15:38:59 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B9BA5C00B6;
        Sat, 31 Dec 2022 18:38:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 31 Dec 2022 18:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672529939; x=1672616339; bh=Q5
        yCn0/AnkkKZqNMbIBfWyiRg29urCX1F8u9AMQi21k=; b=WBUnGM/Ds0JpOnd3+p
        eVw+YneAIGUtheQpBwcEfvlDNgJdZIAOH4eDE4A5iIMOQ24nK+2Il1Y0eslUJStD
        VQzKjXBUbE3aKysTzcnJ6mTzVLt2XwBUyRGqGnJZwYzr1tnyjo4a4l9ciXMooM8H
        jJxT3+1S4tMmjjqD0HKoUOM1dXrdq/YRoJY6349Jbb6S9z22RLoPw9pBlDZR2YIv
        nj2HHyR6N71a2H3QTBm8FP5JPl0jYkrQbXC2FWGkL6aYmiIzh+t1lAuqqjW4JsBN
        9IKMyZI+sjV6DT1akqJGdMa6KqSK3Ts2UfRhALnbCGFcLQJEkHAdKCg5bIBFt0H6
        pyTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672529939; x=1672616339; bh=Q5yCn0/AnkkKZ
        qNMbIBfWyiRg29urCX1F8u9AMQi21k=; b=LcxUIwp/wIu58JX+jomlVEzijJh5N
        21BIMSNA0v+cUQcOt0Deva1Sguftd56NFagjsvG7RjlixFnNT46rmlMLGzxEQi0a
        xDX4xIP5842SuBnXi0ZbGWm9h5HqsR2QhcZQzesrA5ntj3YHwSxUZo+fKs2F5FYF
        xp5DHvjtmpmr8qNbm81t5uA9ReFeRduWnFD6bmcytU7XM0LZJY6skX7RhuXpXVLq
        oqdaGrzaxMaY62QeDnCGRjj+FWEG2cJ6IT8qLieVE16klvv4n0+k1ojYRTWB8eJ1
        5oaYwczTMm04yxPMNio6BAt3srC/F7YZni61HJJ03NDhzDpbA9Utt1Jmg==
X-ME-Sender: <xms:E8iwYzzgOmrtxCcygiix5-3e0k2SpXGDQoZhKofSG9vb5v2zmMebjg>
    <xme:E8iwY7R9zScvu22ipMjuMo2K766O8FdKIZokLSZ-tVhnYyZ_scvXgxIreVM0Cwgle
    ly1YUJyMruw4Csm-A>
X-ME-Received: <xmr:E8iwY9WVvoLyTLnHBQJu8d2vowh82FGt0ist6YO1IdESIBhpFRtgVNpGSclavQZm5lsuPQk5qMnZ4NknFNv81EpSdgY3RHiJV7jlmE8RJaqdYei2Qm-ALbj7tg5nRRDg_fDIXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:E8iwY9iVAgGL1uydHSdWOi2EEL7S8Oo8cxkoeeBqiuHgX8iDzyi2zQ>
    <xmx:E8iwY1ChHXDchaSuqryr8BK0RB_ucBVclblp1fokkFirUHrmSqoyoQ>
    <xmx:E8iwY2IrMvJwYklwyjd6HrWSoqGkHiesjA-g2A91Gu1YRSl29UPISw>
    <xmx:E8iwY3w-UrBLKBIliDreK25Uj2EjfuCJB39CjZAGxPblAkFvISPxig>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:38:58 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v4 04/12] riscv: dts: allwinner: Add the D1/D1s SoC devicetree
Date:   Sat, 31 Dec 2022 17:38:43 -0600
Message-Id: <20221231233851.24923-5-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231233851.24923-1-samuel@sholland.org>
References: <20221231233851.24923-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 (aka D1-H), D1s (aka F133), R528, and T113 are a family of SoCs based
on a single die, or at a pair of dies derived from the same design.

D1 and D1s contain a single T-HEAD Xuantie C906 CPU, whereas R528 and
T113 contain a pair of Cortex-A7's. D1 and R528 are the full version of
the chip with a BGA package, whereas D1s and T113 are low-pin-count QFP
variants.

Because the original design supported both ARM and RISC-V CPUs, some
peripherals are duplicated. In addition, all variants except D1s contain
a HiFi 4 DSP with its own set of peripherals.

The devicetrees are organized to minimize duplication:
 - Common perhiperals are described in sunxi-d1s-t113.dtsi
 - DSP-related peripherals are described in sunxi-d1-t113.dtsi
 - RISC-V specific hardware is described in sun20i-d1s.dtsi
 - Functionality unique to the D1 variant is described in sun20i-d1.dtsi

The SOC_PERIPHERAL_IRQ macro handles the different #interrupt-cells
values between the ARM (GIC) and RISC-V (PLIC) versions of the SoC.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Tested-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v3)

Changes in v3:
 - Drop dummy DCXO clock-frequency property
 - Decrease the PLIC's riscv,ndev property to 175
 - Fix `make W=1 dtbs` warnings (unnecessary #address/#size-cells)

Changes in v2:
 - Split into separate files for sharing with D1s/R528/T113
 - Use SOC_PERIPHERAL_IRQ macro for interrupts
 - Rename osc24M to dcxo and move the frequency to the board DTs
 - Drop analog LDOs due to the missing binding
 - Correct tcon_top DSI clock reference
 - Add DMIC, DSI controller, and DPHY (bindings are in linux-next)
 - Add CPU OPP table

 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi  |  66 ++
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi |  76 ++
 .../boot/dts/allwinner/sunxi-d1-t113.dtsi     |  15 +
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 837 ++++++++++++++++++
 4 files changed, 994 insertions(+)
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
 create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
 create mode 100644 arch/riscv/boot/dts/allwinner/sunxi-d1-t113.dtsi
 create mode 100644 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
new file mode 100644
index 000000000000..97e7cbb32597
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
+
+#include "sun20i-d1s.dtsi"
+#include "sunxi-d1-t113.dtsi"
+
+/ {
+	soc {
+		lradc: keys@2009800 {
+			compatible = "allwinner,sun20i-d1-lradc",
+				     "allwinner,sun50i-r329-lradc";
+			reg = <0x2009800 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(61) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_LRADC>;
+			resets = <&ccu RST_BUS_LRADC>;
+			status = "disabled";
+		};
+
+		i2s0: i2s@2032000 {
+			compatible = "allwinner,sun20i-d1-i2s",
+				     "allwinner,sun50i-r329-i2s";
+			reg = <0x2032000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(26) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S0>,
+				 <&ccu CLK_I2S0>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_I2S0>;
+			dmas = <&dma 3>, <&dma 3>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#sound-dai-cells = <0>;
+		};
+	};
+};
+
+&pio {
+	/omit-if-no-ref/
+	dmic_pb11_d0_pin: dmic-pb11-d0-pin {
+		pins = "PB11";
+		function = "dmic";
+	};
+
+	/omit-if-no-ref/
+	dmic_pe17_clk_pin: dmic-pe17-clk-pin {
+		pins = "PE17";
+		function = "dmic";
+	};
+
+	/omit-if-no-ref/
+	i2c0_pb10_pins: i2c0-pb10-pins {
+		pins = "PB10", "PB11";
+		function = "i2c0";
+	};
+
+	/omit-if-no-ref/
+	i2c2_pb0_pins: i2c2-pb0-pins {
+		pins = "PB0", "PB1";
+		function = "i2c2";
+	};
+
+	/omit-if-no-ref/
+	uart0_pb8_pins: uart0-pb8-pins {
+		pins = "PB8", "PB9";
+		function = "uart0";
+	};
+};
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
new file mode 100644
index 000000000000..8275630af977
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
+
+#define SOC_PERIPHERAL_IRQ(nr)	(nr + 16)
+
+#include "sunxi-d1s-t113.dtsi"
+
+/ {
+	cpus {
+		timebase-frequency = <24000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "thead,c906", "riscv";
+			device_type = "cpu";
+			reg = <0>;
+			clocks = <&ccu CLK_RISCV>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <256>;
+			d-cache-size = <32768>;
+			i-cache-block-size = <64>;
+			i-cache-sets = <128>;
+			i-cache-size = <32768>;
+			mmu-type = "riscv,sv39";
+			operating-points-v2 = <&opp_table_cpu>;
+			riscv,isa = "rv64imafdc";
+			#cooling-cells = <2>;
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
+
+	opp_table_cpu: opp-table-cpu {
+		compatible = "operating-points-v2";
+
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <900000 900000 1100000>;
+		};
+
+		opp-1080000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <900000 900000 1100000>;
+		};
+	};
+
+	soc {
+		interrupt-parent = <&plic>;
+
+		riscv_wdt: watchdog@6011000 {
+			compatible = "allwinner,sun20i-d1-wdt";
+			reg = <0x6011000 0x20>;
+			interrupts = <SOC_PERIPHERAL_IRQ(131) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&dcxo>, <&rtc CLK_OSC32K>;
+			clock-names = "hosc", "losc";
+		};
+
+		plic: interrupt-controller@10000000 {
+			compatible = "allwinner,sun20i-d1-plic",
+				     "thead,c900-plic";
+			reg = <0x10000000 0x4000000>;
+			interrupts-extended = <&cpu0_intc 11>,
+					      <&cpu0_intc 9>;
+			interrupt-controller;
+			riscv,ndev = <175>;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+		};
+	};
+};
diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1-t113.dtsi
new file mode 100644
index 000000000000..b7156123df54
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1-t113.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
+
+/ {
+	soc {
+		dsp_wdt: watchdog@1700400 {
+			compatible = "allwinner,sun20i-d1-wdt";
+			reg = <0x1700400 0x20>;
+			interrupts = <SOC_PERIPHERAL_IRQ(122) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&dcxo>, <&rtc CLK_OSC32K>;
+			clock-names = "hosc", "losc";
+			status = "reserved";
+		};
+	};
+};
diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
new file mode 100644
index 000000000000..dff363a3c934
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -0,0 +1,837 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
+
+#include <dt-bindings/clock/sun6i-rtc.h>
+#include <dt-bindings/clock/sun8i-de2.h>
+#include <dt-bindings/clock/sun8i-tcon-top.h>
+#include <dt-bindings/clock/sun20i-d1-ccu.h>
+#include <dt-bindings/clock/sun20i-d1-r-ccu.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/reset/sun8i-de2.h>
+#include <dt-bindings/reset/sun20i-d1-ccu.h>
+#include <dt-bindings/reset/sun20i-d1-r-ccu.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	dcxo: dcxo-clk {
+		compatible = "fixed-clock";
+		clock-output-names = "dcxo";
+		#clock-cells = <0>;
+	};
+
+	de: display-engine {
+		compatible = "allwinner,sun20i-d1-display-engine";
+		allwinner,pipelines = <&mixer0>, <&mixer1>;
+		status = "disabled";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		ranges;
+		dma-noncoherent;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		pio: pinctrl@2000000 {
+			compatible = "allwinner,sun20i-d1-pinctrl";
+			reg = <0x2000000 0x800>;
+			interrupts = <SOC_PERIPHERAL_IRQ(69) IRQ_TYPE_LEVEL_HIGH>,
+				     <SOC_PERIPHERAL_IRQ(71) IRQ_TYPE_LEVEL_HIGH>,
+				     <SOC_PERIPHERAL_IRQ(73) IRQ_TYPE_LEVEL_HIGH>,
+				     <SOC_PERIPHERAL_IRQ(75) IRQ_TYPE_LEVEL_HIGH>,
+				     <SOC_PERIPHERAL_IRQ(77) IRQ_TYPE_LEVEL_HIGH>,
+				     <SOC_PERIPHERAL_IRQ(79) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_APB0>,
+				 <&dcxo>,
+				 <&rtc CLK_OSC32K>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			interrupt-controller;
+			#gpio-cells = <3>;
+			#interrupt-cells = <3>;
+
+			/omit-if-no-ref/
+			clk_pg11_pin: clk-pg11-pin {
+				pins = "PG11";
+				function = "clk";
+			};
+
+			/omit-if-no-ref/
+			dsi_4lane_pins: dsi-4lane-pins {
+				pins = "PD0", "PD1", "PD2", "PD3", "PD4", "PD5",
+				       "PD6", "PD7", "PD8", "PD9";
+				drive-strength = <30>;
+				function = "dsi";
+			};
+
+			/omit-if-no-ref/
+			lcd_rgb666_pins: lcd-rgb666-pins {
+				pins = "PD0", "PD1", "PD2", "PD3", "PD4", "PD5",
+				       "PD6", "PD7", "PD8", "PD9", "PD10", "PD11",
+				       "PD12", "PD13", "PD14", "PD15", "PD16", "PD17",
+				       "PD18", "PD19", "PD20", "PD21";
+				function = "lcd0";
+			};
+
+			/omit-if-no-ref/
+			mmc0_pins: mmc0-pins {
+				pins = "PF0", "PF1", "PF2", "PF3", "PF4", "PF5";
+				function = "mmc0";
+			};
+
+			/omit-if-no-ref/
+			mmc1_pins: mmc1-pins {
+				pins = "PG0", "PG1", "PG2", "PG3", "PG4", "PG5";
+				function = "mmc1";
+			};
+
+			/omit-if-no-ref/
+			mmc2_pins: mmc2-pins {
+				pins = "PC2", "PC3", "PC4", "PC5", "PC6", "PC7";
+				function = "mmc2";
+			};
+
+			/omit-if-no-ref/
+			rgmii_pe_pins: rgmii-pe-pins {
+				pins = "PE0", "PE1", "PE2", "PE3", "PE4",
+				       "PE5", "PE6", "PE7", "PE8", "PE9",
+				       "PE11", "PE12", "PE13", "PE14", "PE15";
+				function = "emac";
+			};
+
+			/omit-if-no-ref/
+			rmii_pe_pins: rmii-pe-pins {
+				pins = "PE0", "PE1", "PE2", "PE3", "PE4",
+				       "PE5", "PE6", "PE7", "PE8", "PE9";
+				function = "emac";
+			};
+
+			/omit-if-no-ref/
+			uart1_pg6_pins: uart1-pg6-pins {
+				pins = "PG6", "PG7";
+				function = "uart1";
+			};
+
+			/omit-if-no-ref/
+			uart1_pg8_rts_cts_pins: uart1-pg8-rts-cts-pins {
+				pins = "PG8", "PG9";
+				function = "uart1";
+			};
+
+			/omit-if-no-ref/
+			uart3_pb_pins: uart3-pb-pins {
+				pins = "PB6", "PB7";
+				function = "uart3";
+			};
+		};
+
+		ccu: clock-controller@2001000 {
+			compatible = "allwinner,sun20i-d1-ccu";
+			reg = <0x2001000 0x1000>;
+			clocks = <&dcxo>,
+				 <&rtc CLK_OSC32K>,
+				 <&rtc CLK_IOSC>;
+			clock-names = "hosc", "losc", "iosc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		dmic: dmic@2031000 {
+			compatible = "allwinner,sun20i-d1-dmic",
+				     "allwinner,sun50i-h6-dmic";
+			reg = <0x2031000 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(24) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DMIC>,
+				 <&ccu CLK_DMIC>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_DMIC>;
+			dmas = <&dma 8>;
+			dma-names = "rx";
+			status = "disabled";
+			#sound-dai-cells = <0>;
+		};
+
+		i2s1: i2s@2033000 {
+			compatible = "allwinner,sun20i-d1-i2s",
+				     "allwinner,sun50i-r329-i2s";
+			reg = <0x2033000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(27) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S1>,
+				 <&ccu CLK_I2S1>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_I2S1>;
+			dmas = <&dma 4>, <&dma 4>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#sound-dai-cells = <0>;
+		};
+
+		i2s2: i2s@2034000 {
+			compatible = "allwinner,sun20i-d1-i2s",
+				     "allwinner,sun50i-r329-i2s";
+			reg = <0x2034000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(28) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S2>,
+				 <&ccu CLK_I2S2>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_I2S2>;
+			dmas = <&dma 5>, <&dma 5>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#sound-dai-cells = <0>;
+		};
+
+		timer: timer@2050000 {
+			compatible = "allwinner,sun20i-d1-timer",
+				     "allwinner,sun8i-a23-timer";
+			reg = <0x2050000 0xa0>;
+			interrupts = <SOC_PERIPHERAL_IRQ(59) IRQ_TYPE_LEVEL_HIGH>,
+				     <SOC_PERIPHERAL_IRQ(60) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&dcxo>;
+		};
+
+		wdt: watchdog@20500a0 {
+			compatible = "allwinner,sun20i-d1-wdt-reset",
+				     "allwinner,sun20i-d1-wdt";
+			reg = <0x20500a0 0x20>;
+			interrupts = <SOC_PERIPHERAL_IRQ(63) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&dcxo>, <&rtc CLK_OSC32K>;
+			clock-names = "hosc", "losc";
+			status = "reserved";
+		};
+
+		uart0: serial@2500000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x2500000 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <SOC_PERIPHERAL_IRQ(2) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_UART0>;
+			resets = <&ccu RST_BUS_UART0>;
+			dmas = <&dma 14>, <&dma 14>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uart1: serial@2500400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x2500400 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <SOC_PERIPHERAL_IRQ(3) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_UART1>;
+			resets = <&ccu RST_BUS_UART1>;
+			dmas = <&dma 15>, <&dma 15>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uart2: serial@2500800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x2500800 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <SOC_PERIPHERAL_IRQ(4) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_UART2>;
+			resets = <&ccu RST_BUS_UART2>;
+			dmas = <&dma 16>, <&dma 16>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uart3: serial@2500c00 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x2500c00 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <SOC_PERIPHERAL_IRQ(5) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_UART3>;
+			resets = <&ccu RST_BUS_UART3>;
+			dmas = <&dma 17>, <&dma 17>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uart4: serial@2501000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x2501000 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <SOC_PERIPHERAL_IRQ(6) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_UART4>;
+			resets = <&ccu RST_BUS_UART4>;
+			dmas = <&dma 18>, <&dma 18>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uart5: serial@2501400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x2501400 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <SOC_PERIPHERAL_IRQ(7) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_UART5>;
+			resets = <&ccu RST_BUS_UART5>;
+			dmas = <&dma 19>, <&dma 19>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		i2c0: i2c@2502000 {
+			compatible = "allwinner,sun20i-d1-i2c",
+				     "allwinner,sun8i-v536-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x2502000 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(9) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C0>;
+			resets = <&ccu RST_BUS_I2C0>;
+			dmas = <&dma 43>, <&dma 43>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1: i2c@2502400 {
+			compatible = "allwinner,sun20i-d1-i2c",
+				     "allwinner,sun8i-v536-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x2502400 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(10) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C1>;
+			resets = <&ccu RST_BUS_I2C1>;
+			dmas = <&dma 44>, <&dma 44>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c2: i2c@2502800 {
+			compatible = "allwinner,sun20i-d1-i2c",
+				     "allwinner,sun8i-v536-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x2502800 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(11) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C2>;
+			resets = <&ccu RST_BUS_I2C2>;
+			dmas = <&dma 45>, <&dma 45>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c3: i2c@2502c00 {
+			compatible = "allwinner,sun20i-d1-i2c",
+				     "allwinner,sun8i-v536-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x2502c00 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(12) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C3>;
+			resets = <&ccu RST_BUS_I2C3>;
+			dmas = <&dma 46>, <&dma 46>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		syscon: syscon@3000000 {
+			compatible = "allwinner,sun20i-d1-system-control";
+			reg = <0x3000000 0x1000>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			regulators@3000150 {
+				compatible = "allwinner,sun20i-d1-system-ldos";
+				reg = <0x3000150 0x4>;
+
+				reg_ldoa: ldoa {
+				};
+
+				reg_ldob: ldob {
+				};
+			};
+		};
+
+		dma: dma-controller@3002000 {
+			compatible = "allwinner,sun20i-d1-dma";
+			reg = <0x3002000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(50) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DMA>, <&ccu CLK_MBUS_DMA>;
+			clock-names = "bus", "mbus";
+			resets = <&ccu RST_BUS_DMA>;
+			dma-channels = <16>;
+			dma-requests = <48>;
+			#dma-cells = <1>;
+		};
+
+		sid: efuse@3006000 {
+			compatible = "allwinner,sun20i-d1-sid";
+			reg = <0x3006000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
+		mbus: dram-controller@3102000 {
+			compatible = "allwinner,sun20i-d1-mbus";
+			reg = <0x3102000 0x1000>,
+			      <0x3103000 0x1000>;
+			reg-names = "mbus", "dram";
+			interrupts = <SOC_PERIPHERAL_IRQ(43) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_MBUS>,
+				 <&ccu CLK_DRAM>,
+				 <&ccu CLK_BUS_DRAM>;
+			clock-names = "mbus", "dram", "bus";
+			dma-ranges = <0 0x40000000 0x80000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interconnect-cells = <1>;
+		};
+
+		mmc0: mmc@4020000 {
+			compatible = "allwinner,sun20i-d1-mmc";
+			reg = <0x4020000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(40) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC0>;
+			reset-names = "ahb";
+			cap-sd-highspeed;
+			max-frequency = <150000000>;
+			no-mmc;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc1: mmc@4021000 {
+			compatible = "allwinner,sun20i-d1-mmc";
+			reg = <0x4021000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(41) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC1>;
+			reset-names = "ahb";
+			cap-sd-highspeed;
+			max-frequency = <150000000>;
+			no-mmc;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc2: mmc@4022000 {
+			compatible = "allwinner,sun20i-d1-emmc",
+				     "allwinner,sun50i-a100-emmc";
+			reg = <0x4022000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(42) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC2>;
+			reset-names = "ahb";
+			cap-mmc-highspeed;
+			max-frequency = <150000000>;
+			mmc-ddr-1_8v;
+			mmc-ddr-3_3v;
+			no-sd;
+			no-sdio;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		usb_otg: usb@4100000 {
+			compatible = "allwinner,sun20i-d1-musb",
+				     "allwinner,sun8i-a33-musb";
+			reg = <0x4100000 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(29) IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mc";
+			clocks = <&ccu CLK_BUS_OTG>;
+			resets = <&ccu RST_BUS_OTG>;
+			extcon = <&usbphy 0>;
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		usbphy: phy@4100400 {
+			compatible = "allwinner,sun20i-d1-usb-phy";
+			reg = <0x4100400 0x100>,
+			      <0x4101800 0x100>,
+			      <0x4200800 0x100>;
+			reg-names = "phy_ctrl",
+				    "pmu0",
+				    "pmu1";
+			clocks = <&dcxo>,
+				 <&dcxo>;
+			clock-names = "usb0_phy",
+				      "usb1_phy";
+			resets = <&ccu RST_USB_PHY0>,
+				 <&ccu RST_USB_PHY1>;
+			reset-names = "usb0_reset",
+				      "usb1_reset";
+			status = "disabled";
+			#phy-cells = <1>;
+		};
+
+		ehci0: usb@4101000 {
+			compatible = "allwinner,sun20i-d1-ehci",
+				     "generic-ehci";
+			reg = <0x4101000 0x100>;
+			interrupts = <SOC_PERIPHERAL_IRQ(30) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI0>,
+				 <&ccu CLK_BUS_EHCI0>,
+				 <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_OHCI0>,
+				 <&ccu RST_BUS_EHCI0>;
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci0: usb@4101400 {
+			compatible = "allwinner,sun20i-d1-ohci",
+				     "generic-ohci";
+			reg = <0x4101400 0x100>;
+			interrupts = <SOC_PERIPHERAL_IRQ(31) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI0>,
+				 <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_OHCI0>;
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ehci1: usb@4200000 {
+			compatible = "allwinner,sun20i-d1-ehci",
+				     "generic-ehci";
+			reg = <0x4200000 0x100>;
+			interrupts = <SOC_PERIPHERAL_IRQ(33) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI1>,
+				 <&ccu CLK_BUS_EHCI1>,
+				 <&ccu CLK_USB_OHCI1>;
+			resets = <&ccu RST_BUS_OHCI1>,
+				 <&ccu RST_BUS_EHCI1>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci1: usb@4200400 {
+			compatible = "allwinner,sun20i-d1-ohci",
+				     "generic-ohci";
+			reg = <0x4200400 0x100>;
+			interrupts = <SOC_PERIPHERAL_IRQ(34) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI1>,
+				 <&ccu CLK_USB_OHCI1>;
+			resets = <&ccu RST_BUS_OHCI1>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		emac: ethernet@4500000 {
+			compatible = "allwinner,sun20i-d1-emac",
+				     "allwinner,sun50i-a64-emac";
+			reg = <0x4500000 0x10000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(46) IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&ccu CLK_BUS_EMAC>;
+			clock-names = "stmmaceth";
+			resets = <&ccu RST_BUS_EMAC>;
+			reset-names = "stmmaceth";
+			syscon = <&syscon>;
+			status = "disabled";
+
+			mdio: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		display_clocks: clock-controller@5000000 {
+			compatible = "allwinner,sun20i-d1-de2-clk",
+				     "allwinner,sun50i-h5-de2-clk";
+			reg = <0x5000000 0x10000>;
+			clocks = <&ccu CLK_BUS_DE>, <&ccu CLK_DE>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_DE>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		mixer0: mixer@5100000 {
+			compatible = "allwinner,sun20i-d1-de2-mixer-0";
+			reg = <0x5100000 0x100000>;
+			clocks = <&display_clocks CLK_BUS_MIXER0>,
+				 <&display_clocks CLK_MIXER0>;
+			clock-names = "bus", "mod";
+			resets = <&display_clocks RST_MIXER0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mixer0_out: port@1 {
+					reg = <1>;
+
+					mixer0_out_tcon_top_mixer0: endpoint {
+						remote-endpoint = <&tcon_top_mixer0_in_mixer0>;
+					};
+				};
+			};
+		};
+
+		mixer1: mixer@5200000 {
+			compatible = "allwinner,sun20i-d1-de2-mixer-1";
+			reg = <0x5200000 0x100000>;
+			clocks = <&display_clocks CLK_BUS_MIXER1>,
+				 <&display_clocks CLK_MIXER1>;
+			clock-names = "bus", "mod";
+			resets = <&display_clocks RST_MIXER1>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mixer1_out: port@1 {
+					reg = <1>;
+
+					mixer1_out_tcon_top_mixer1: endpoint {
+						remote-endpoint = <&tcon_top_mixer1_in_mixer1>;
+					};
+				};
+			};
+		};
+
+		dsi: dsi@5450000 {
+			compatible = "allwinner,sun20i-d1-mipi-dsi",
+				     "allwinner,sun50i-a100-mipi-dsi";
+			reg = <0x5450000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(92) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MIPI_DSI>,
+				 <&tcon_top CLK_TCON_TOP_DSI>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_MIPI_DSI>;
+			phys = <&dphy>;
+			phy-names = "dphy";
+			status = "disabled";
+
+			port {
+				dsi_in_tcon_lcd0: endpoint {
+					remote-endpoint = <&tcon_lcd0_out_dsi>;
+				};
+			};
+		};
+
+		dphy: phy@5451000 {
+			compatible = "allwinner,sun20i-d1-mipi-dphy",
+				     "allwinner,sun50i-a100-mipi-dphy";
+			reg = <0x5451000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(92) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MIPI_DSI>,
+				 <&ccu CLK_MIPI_DSI>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_MIPI_DSI>;
+			#phy-cells = <0>;
+		};
+
+		tcon_top: tcon-top@5460000 {
+			compatible = "allwinner,sun20i-d1-tcon-top";
+			reg = <0x5460000 0x1000>;
+			clocks = <&ccu CLK_BUS_DPSS_TOP>,
+				 <&ccu CLK_TCON_TV>,
+				 <&ccu CLK_TVE>,
+				 <&ccu CLK_TCON_LCD0>;
+			clock-names = "bus", "tcon-tv0", "tve0", "dsi";
+			clock-output-names = "tcon-top-tv0", "tcon-top-dsi";
+			resets = <&ccu RST_BUS_DPSS_TOP>;
+			#clock-cells = <1>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon_top_mixer0_in: port@0 {
+					reg = <0>;
+
+					tcon_top_mixer0_in_mixer0: endpoint {
+						remote-endpoint = <&mixer0_out_tcon_top_mixer0>;
+					};
+				};
+
+				tcon_top_mixer0_out: port@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					tcon_top_mixer0_out_tcon_lcd0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&tcon_lcd0_in_tcon_top_mixer0>;
+					};
+
+					tcon_top_mixer0_out_tcon_tv0: endpoint@2 {
+						reg = <2>;
+						remote-endpoint = <&tcon_tv0_in_tcon_top_mixer0>;
+					};
+				};
+
+				tcon_top_mixer1_in: port@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					tcon_top_mixer1_in_mixer1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&mixer1_out_tcon_top_mixer1>;
+					};
+				};
+
+				tcon_top_mixer1_out: port@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					tcon_top_mixer1_out_tcon_lcd0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&tcon_lcd0_in_tcon_top_mixer1>;
+					};
+
+					tcon_top_mixer1_out_tcon_tv0: endpoint@2 {
+						reg = <2>;
+						remote-endpoint = <&tcon_tv0_in_tcon_top_mixer1>;
+					};
+				};
+
+				tcon_top_hdmi_in: port@4 {
+					reg = <4>;
+
+					tcon_top_hdmi_in_tcon_tv0: endpoint {
+						remote-endpoint = <&tcon_tv0_out_tcon_top_hdmi>;
+					};
+				};
+
+				tcon_top_hdmi_out: port@5 {
+					reg = <5>;
+				};
+			};
+		};
+
+		tcon_lcd0: lcd-controller@5461000 {
+			compatible = "allwinner,sun20i-d1-tcon-lcd";
+			reg = <0x5461000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(90) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_TCON_LCD0>,
+				 <&ccu CLK_TCON_LCD0>;
+			clock-names = "ahb", "tcon-ch0";
+			clock-output-names = "tcon-pixel-clock";
+			resets = <&ccu RST_BUS_TCON_LCD0>,
+				 <&ccu RST_BUS_LVDS0>;
+			reset-names = "lcd", "lvds";
+			#clock-cells = <0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon_lcd0_in: port@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					tcon_lcd0_in_tcon_top_mixer0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&tcon_top_mixer0_out_tcon_lcd0>;
+					};
+
+					tcon_lcd0_in_tcon_top_mixer1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&tcon_top_mixer1_out_tcon_lcd0>;
+					};
+				};
+
+				tcon_lcd0_out: port@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					tcon_lcd0_out_dsi: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&dsi_in_tcon_lcd0>;
+					};
+				};
+			};
+		};
+
+		tcon_tv0: lcd-controller@5470000 {
+			compatible = "allwinner,sun20i-d1-tcon-tv";
+			reg = <0x5470000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(91) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_TCON_TV>,
+				 <&tcon_top CLK_TCON_TOP_TV0>;
+			clock-names = "ahb", "tcon-ch1";
+			resets = <&ccu RST_BUS_TCON_TV>;
+			reset-names = "lcd";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon_tv0_in: port@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					tcon_tv0_in_tcon_top_mixer0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&tcon_top_mixer0_out_tcon_tv0>;
+					};
+
+					tcon_tv0_in_tcon_top_mixer1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&tcon_top_mixer1_out_tcon_tv0>;
+					};
+				};
+
+				tcon_tv0_out: port@1 {
+					reg = <1>;
+
+					tcon_tv0_out_tcon_top_hdmi: endpoint {
+						remote-endpoint = <&tcon_top_hdmi_in_tcon_tv0>;
+					};
+				};
+			};
+		};
+
+		r_ccu: clock-controller@7010000 {
+			compatible = "allwinner,sun20i-d1-r-ccu";
+			reg = <0x7010000 0x400>;
+			clocks = <&dcxo>,
+				 <&rtc CLK_OSC32K>,
+				 <&rtc CLK_IOSC>,
+				 <&ccu CLK_PLL_PERIPH0_DIV3>;
+			clock-names = "hosc", "losc", "iosc", "pll-periph";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		rtc: rtc@7090000 {
+			compatible = "allwinner,sun20i-d1-rtc",
+				     "allwinner,sun50i-r329-rtc";
+			reg = <0x7090000 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(144) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_BUS_R_RTC>,
+				 <&dcxo>,
+				 <&r_ccu CLK_R_AHB>;
+			clock-names = "bus", "hosc", "ahb";
+			#clock-cells = <1>;
+		};
+	};
+};
-- 
2.37.4

