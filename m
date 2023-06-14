Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518F8718D38
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjEaVgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjEaVfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:35:46 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE06A1BCC;
        Wed, 31 May 2023 14:33:45 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34VLWMxZ082977;
        Wed, 31 May 2023 16:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685568742;
        bh=zh9zWtQecEo6yFid7OjDe3UYa1oZQXg5QFl+umKAJuE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QunqD70G53SYDLHkISP9PrFIrOX9ieJoruP737mXA+MSPKWAVQ+kTGYQOETZgdedQ
         wEqGVVX2WcSpeeEWfjd1Fi2cQZDomfwfsEj1bJVyoyOIDi8cpN/rIgcWiiYnJIyo8s
         LuD+r1lXD8OlfFLL7k/0nBDhSnpL4GFfCnt0lUGk=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34VLWM66101259
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 May 2023 16:32:22 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 May 2023 16:32:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 May 2023 16:32:21 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34VLWLRb029058;
        Wed, 31 May 2023 16:32:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Nitin Yadav <n-yadav@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/6] arm64: dts: ti: k3-j721e: Add general purpose timers
Date:   Wed, 31 May 2023 16:32:10 -0500
Message-ID: <20230531213215.602395-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230531213215.602395-1-nm@ti.com>
References: <20230531213215.602395-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 20 general purpose timers on j721e that can be used for
things like PWM using pwm-omap-dmtimer driver. There are also
additional ten timers in the MCU domain which are meant for MCU
firmware usage and hence marked reserved by default.

The odd numbered timers have the option of being cascaded to even
timers to create a 64 bit non-atomic counter which is racy in simple
usage, hence the clock muxes are explicitly setup to individual 32 bit
counters driven off system crystal (HFOSC) as default.

These instantiation differs from J7200 and other SoCs with the device
IDs and clocks involved for muxing.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 240 ++++++++++++++++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 139 ++++++++++
 2 files changed, 379 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 91f7e5d03440..57f888c9353e 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1023,6 +1023,246 @@ serdes4: serdes@5050000 {
 		};
 	};
 
+	main_timer0: timer@2400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2400000 0x00 0x400>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 49 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 49 1>;
+		assigned-clock-parents = <&k3_clks 49 2>;
+		power-domains = <&k3_pds 49 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer1: timer@2410000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2410000 0x00 0x400>;
+		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 50 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 50 1>, <&k3_clks 327 0>;
+		assigned-clock-parents = <&k3_clks 50 2>, <&k3_clks 327 1>;
+		power-domains = <&k3_pds 50 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer2: timer@2420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2420000 0x00 0x400>;
+		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 51 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 51 1>;
+		assigned-clock-parents = <&k3_clks 51 2>;
+		power-domains = <&k3_pds 51 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer3: timer@2430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2430000 0x00 0x400>;
+		interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 52 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 52 1>, <&k3_clks 328 0>;
+		assigned-clock-parents = <&k3_clks 52 2>, <&k3_clks 328 1>;
+		power-domains = <&k3_pds 52 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer4: timer@2440000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2440000 0x00 0x400>;
+		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 53 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 53 1>;
+		assigned-clock-parents = <&k3_clks 53 2>;
+		power-domains = <&k3_pds 53 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer5: timer@2450000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2450000 0x00 0x400>;
+		interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 54 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 54 1>, <&k3_clks 329 0>;
+		assigned-clock-parents = <&k3_clks 54 2>, <&k3_clks 329 1>;
+		power-domains = <&k3_pds 54 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer6: timer@2460000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2460000 0x00 0x400>;
+		interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 55 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 55 1>;
+		assigned-clock-parents = <&k3_clks 55 2>;
+		power-domains = <&k3_pds 55 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer7: timer@2470000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2470000 0x00 0x400>;
+		interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 57 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 57 1>, <&k3_clks 330 0>;
+		assigned-clock-parents = <&k3_clks 57 2>, <&k3_clks 330 1>;
+		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer8: timer@2480000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2480000 0x00 0x400>;
+		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 58 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 58 1>;
+		assigned-clock-parents = <&k3_clks 58 2>;
+		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer9: timer@2490000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2490000 0x00 0x400>;
+		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 59 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 59 1>, <&k3_clks 331 0>;
+		assigned-clock-parents = <&k3_clks 59 2>, <&k3_clks 331 1>;
+		power-domains = <&k3_pds 59 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer10: timer@24a0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24a0000 0x00 0x400>;
+		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 60 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 60 1>;
+		assigned-clock-parents = <&k3_clks 60 2>;
+		power-domains = <&k3_pds 60 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer11: timer@24b0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24b0000 0x00 0x400>;
+		interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 62 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 62 1>, <&k3_clks 332 0>;
+		assigned-clock-parents = <&k3_clks 62 2>, <&k3_clks 332 1>;
+		power-domains = <&k3_pds 62 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer12: timer@24c0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24c0000 0x00 0x400>;
+		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 63 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 63 1>;
+		assigned-clock-parents = <&k3_clks 63 2>;
+		power-domains = <&k3_pds 63 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer13: timer@24d0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24d0000 0x00 0x400>;
+		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 64 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 64 1>, <&k3_clks 333 0>;
+		assigned-clock-parents = <&k3_clks 64 2>, <&k3_clks 333 1>;
+		power-domains = <&k3_pds 64 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer14: timer@24e0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24e0000 0x00 0x400>;
+		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 65 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 65 1>;
+		assigned-clock-parents = <&k3_clks 65 2>;
+		power-domains = <&k3_pds 65 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer15: timer@24f0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24f0000 0x00 0x400>;
+		interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 66 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 66 1>, <&k3_clks 334 0>;
+		assigned-clock-parents = <&k3_clks 66 2>, <&k3_clks 334 1>;
+		power-domains = <&k3_pds 66 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer16: timer@2500000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2500000 0x00 0x400>;
+		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 67 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 67 1>;
+		assigned-clock-parents = <&k3_clks 67 2>;
+		power-domains = <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer17: timer@2510000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2510000 0x00 0x400>;
+		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 68 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 68 1>, <&k3_clks 335 0>;
+		assigned-clock-parents = <&k3_clks 68 2>, <&k3_clks 335 1>;
+		power-domains = <&k3_pds 68 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer18: timer@2520000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2520000 0x00 0x400>;
+		interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 69 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 69 1>;
+		assigned-clock-parents = <&k3_clks 69 2>;
+		power-domains = <&k3_pds 69 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer19: timer@2530000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2530000 0x00 0x400>;
+		interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 70 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 70 1>, <&k3_clks 336 0>;
+		assigned-clock-parents = <&k3_clks 70 2>, <&k3_clks 336 1>;
+		power-domains = <&k3_pds 70 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
 	main_uart0: serial@2800000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x100>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 4ea95ed5d12c..053c771129d6 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -70,6 +70,145 @@ mcu_ram: sram@41c00000 {
 		#size-cells = <1>;
 	};
 
+	mcu_timer0: timer@40400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40400000 0x00 0x400>;
+		interrupts = <GIC_SPI 816 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 35 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 35 1>;
+		assigned-clock-parents = <&k3_clks 35 2>;
+		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer1: timer@40410000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40410000 0x00 0x400>;
+		interrupts = <GIC_SPI 817 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 71 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 71 1>, <&k3_clks 322 0>;
+		assigned-clock-parents = <&k3_clks 71 2>, <&k3_clks 322 1>;
+		power-domains = <&k3_pds 71 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer2: timer@40420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40420000 0x00 0x400>;
+		interrupts = <GIC_SPI 818 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 72 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 72 1>;
+		assigned-clock-parents = <&k3_clks 72 2>;
+		power-domains = <&k3_pds 72 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer3: timer@40430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40430000 0x00 0x400>;
+		interrupts = <GIC_SPI 819 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 73 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 73 1>, <&k3_clks 323 0>;
+		assigned-clock-parents = <&k3_clks 73 2>, <&k3_clks 323 1>;
+		power-domains = <&k3_pds 73 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer4: timer@40440000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40440000 0x00 0x400>;
+		interrupts = <GIC_SPI 820 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 74 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 74 1>;
+		assigned-clock-parents = <&k3_clks 74 2>;
+		power-domains = <&k3_pds 74 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer5: timer@40450000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40450000 0x00 0x400>;
+		interrupts = <GIC_SPI 821 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 75 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 75 1>, <&k3_clks 324 0>;
+		assigned-clock-parents = <&k3_clks 75 2>, <&k3_clks 324 1>;
+		power-domains = <&k3_pds 75 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer6: timer@40460000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40460000 0x00 0x400>;
+		interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 76 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 76 1>;
+		assigned-clock-parents = <&k3_clks 76 2>;
+		power-domains = <&k3_pds 76 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer7: timer@40470000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40470000 0x00 0x400>;
+		interrupts = <GIC_SPI 823 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 77 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 77 1>, <&k3_clks 325 0>;
+		assigned-clock-parents = <&k3_clks 77 2>, <&k3_clks 325 1>;
+		power-domains = <&k3_pds 77 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer8: timer@40480000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40480000 0x00 0x400>;
+		interrupts = <GIC_SPI 824 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 78 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 78 1>;
+		assigned-clock-parents = <&k3_clks 78 2>;
+		power-domains = <&k3_pds 78 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer9: timer@40490000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40490000 0x00 0x400>;
+		interrupts = <GIC_SPI 825 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 79 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 79 1>, <&k3_clks 326 0>;
+		assigned-clock-parents = <&k3_clks 79 2>, <&k3_clks 326 1>;
+		power-domains = <&k3_pds 79 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
 	wkup_uart0: serial@42300000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x42300000 0x00 0x100>;
-- 
2.40.0

