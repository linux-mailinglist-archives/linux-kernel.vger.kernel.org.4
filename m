Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD07718D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjEaVgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjEaVfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:35:52 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5181704;
        Wed, 31 May 2023 14:33:55 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34VLWMmC099108;
        Wed, 31 May 2023 16:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685568742;
        bh=WS+jPUIxhy7RA3NaV6CY9E8VLR8KfuIU1vEmUNOSQRY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=H7kAwMZM9niB8yAnjVQofoHGmmO2kwxZSQy+FsdO0h+ymraWpaxEA8xYbDhQp6VrC
         qiz1DaAKFnQU/neU3q51WCUhnuEdVIRvmaaphaJZnxwIK28Chf/M3eZ1mAkl5CjEDD
         xySTW9I40tGao2HznFEJJH4/8RyNnJ8+sPoboK0Q=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34VLWMAS101266
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 May 2023 16:32:22 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 May 2023 16:32:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 May 2023 16:32:22 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34VLWML2027038;
        Wed, 31 May 2023 16:32:22 -0500
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
Subject: [PATCH 5/6] arm64: dts: ti: k3-j784s4: Add general purpose timers
Date:   Wed, 31 May 2023 16:32:14 -0500
Message-ID: <20230531213215.602395-6-nm@ti.com>
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

There are 20 general purpose timers on j784s4 that can be used for
things like PWM using pwm-omap-dmtimer driver. There are also
additional ten timers in the MCU domain which are meant for MCU
firmware usage and hence marked reserved by default.

Though the count is similar to J721e/J7200/j721s2, the device IDs
and clocks used in j784s4 are different with the option of certain
clocks having options of additional clock muxes. Since there is very
minimal reuse, it is cleaner to integrate as part of SoC files itself.
The defaults are configured for clocking the timers from system
clock(HFOSC0).

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 240 ++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 140 ++++++++++
 2 files changed, 380 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index e9169eb358c1..f2ddd79f748d 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -91,6 +91,246 @@ rng: rng@4e10000 {
 		};
 	};
 
+	main_timer0: timer@2400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2400000 0x00 0x400>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 97 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 97 2>;
+		assigned-clock-parents = <&k3_clks 97 3>;
+		power-domains = <&k3_pds 97 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer1: timer@2410000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2410000 0x00 0x400>;
+		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 98 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 98 2>;
+		assigned-clock-parents = <&k3_clks 98 3>;
+		power-domains = <&k3_pds 98 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer2: timer@2420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2420000 0x00 0x400>;
+		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 99 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 99 2>;
+		assigned-clock-parents = <&k3_clks 99 3>;
+		power-domains = <&k3_pds 99 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer3: timer@2430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2430000 0x00 0x400>;
+		interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 100 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 100 2>;
+		assigned-clock-parents = <&k3_clks 100 3>;
+		power-domains = <&k3_pds 100 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer4: timer@2440000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2440000 0x00 0x400>;
+		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 101 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 101 2>;
+		assigned-clock-parents = <&k3_clks 101 3>;
+		power-domains = <&k3_pds 101 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer5: timer@2450000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2450000 0x00 0x400>;
+		interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 102 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 102 2>;
+		assigned-clock-parents = <&k3_clks 102 3>;
+		power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer6: timer@2460000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2460000 0x00 0x400>;
+		interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 103 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 103 2>;
+		assigned-clock-parents = <&k3_clks 103 3>;
+		power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer7: timer@2470000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2470000 0x00 0x400>;
+		interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 104 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 104 2>;
+		assigned-clock-parents = <&k3_clks 104 3>;
+		power-domains = <&k3_pds 104 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer8: timer@2480000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2480000 0x00 0x400>;
+		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 105 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 105 2>;
+		assigned-clock-parents = <&k3_clks 105 3>;
+		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer9: timer@2490000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2490000 0x00 0x400>;
+		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 106 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 106 2>;
+		assigned-clock-parents = <&k3_clks 106 3>;
+		power-domains = <&k3_pds 106 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer10: timer@24a0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24a0000 0x00 0x400>;
+		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 107 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 107 2>;
+		assigned-clock-parents = <&k3_clks 107 3>;
+		power-domains = <&k3_pds 107 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer11: timer@24b0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24b0000 0x00 0x400>;
+		interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 108 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 108 2>;
+		assigned-clock-parents = <&k3_clks 108 3>;
+		power-domains = <&k3_pds 108 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer12: timer@24c0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24c0000 0x00 0x400>;
+		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 109 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 109 2>;
+		assigned-clock-parents = <&k3_clks 109 3>;
+		power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer13: timer@24d0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24d0000 0x00 0x400>;
+		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 110 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 110 2>;
+		assigned-clock-parents = <&k3_clks 110 3>;
+		power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer14: timer@24e0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24e0000 0x00 0x400>;
+		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 111 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 111 2>;
+		assigned-clock-parents = <&k3_clks 111 3>;
+		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer15: timer@24f0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24f0000 0x00 0x400>;
+		interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 112 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 112 2>;
+		assigned-clock-parents = <&k3_clks 112 3>;
+		power-domains = <&k3_pds 112 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer16: timer@2500000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2500000 0x00 0x400>;
+		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 113 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 113 2>;
+		assigned-clock-parents = <&k3_clks 113 3>;
+		power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer17: timer@2510000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2510000 0x00 0x400>;
+		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 114 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 114 2>;
+		assigned-clock-parents = <&k3_clks 114 3>;
+		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer18: timer@2520000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2520000 0x00 0x400>;
+		interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 115 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 115 2>;
+		assigned-clock-parents = <&k3_clks 115 3>;
+		power-domains = <&k3_pds 115 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer19: timer@2530000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2530000 0x00 0x400>;
+		interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 116 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 116 2>;
+		assigned-clock-parents = <&k3_clks 116 3>;
+		power-domains = <&k3_pds 116 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
 	main_uart0: serial@2800000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x200>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 0dc957e989fb..8623937e9506 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -97,6 +97,146 @@ phy_gmii_sel: phy@4040 {
 		};
 	};
 
+	mcu_timer0: timer@40400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40400000 0x00 0x400>;
+		interrupts = <GIC_SPI 816 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 35 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 35 2>;
+		assigned-clock-parents = <&k3_clks 35 3>;
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
+		clocks = <&k3_clks 117 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 117 2>;
+		assigned-clock-parents = <&k3_clks 117 3>;
+		power-domains = <&k3_pds 117 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer2: timer@40420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40420000 0x00 0x400>;
+		interrupts = <GIC_SPI 818 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 118 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 118 2>;
+		assigned-clock-parents = <&k3_clks 118 3>;
+		power-domains = <&k3_pds 118 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer3: timer@40430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40430000 0x00 0x400>;
+		interrupts = <GIC_SPI 819 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 119 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 119 2>;
+		assigned-clock-parents = <&k3_clks 119 3>;
+		power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer4: timer@40440000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40440000 0x00 0x400>;
+		interrupts = <GIC_SPI 820 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 120 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 120 2>;
+		assigned-clock-parents = <&k3_clks 120 3>;
+		power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer5: timer@40450000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40450000 0x00 0x400>;
+		interrupts = <GIC_SPI 821 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 121 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 121 2>;
+		assigned-clock-parents = <&k3_clks 121 3>;
+		power-domains = <&k3_pds 121 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer6: timer@40460000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40460000 0x00 0x400>;
+		interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 122 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 122 2>;
+		assigned-clock-parents = <&k3_clks 122 3>;
+		power-domains = <&k3_pds 122 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer7: timer@40470000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40470000 0x00 0x400>;
+		interrupts = <GIC_SPI 823 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 123 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 123 2>;
+		assigned-clock-parents = <&k3_clks 123 3>;
+		power-domains = <&k3_pds 123 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer8: timer@40480000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40480000 0x00 0x400>;
+		interrupts = <GIC_SPI 824 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 124 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 124 2>;
+		assigned-clock-parents = <&k3_clks 124 3>;
+		power-domains = <&k3_pds 124 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
+	mcu_timer9: timer@40490000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40490000 0x00 0x400>;
+		interrupts = <GIC_SPI 825 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 125 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 125 2>;
+		assigned-clock-parents = <&k3_clks 125 3>;
+		power-domains = <&k3_pds 125 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		/* Non-MPU Firmware usage */
+		status = "reserved";
+	};
+
 	wkup_uart0: serial@42300000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x42300000 0x00 0x200>;
-- 
2.40.0

