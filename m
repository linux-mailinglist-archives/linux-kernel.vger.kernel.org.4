Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725066E26A2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjDNPQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDNPQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:16:14 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06309BB9B;
        Fri, 14 Apr 2023 08:16:12 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33EFFvCQ081270;
        Fri, 14 Apr 2023 10:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681485357;
        bh=ZXIT24LwUDoFK65Tx0pvt8BK2CEw61Wgiziw3JaY0Mk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GrxkQnfiT++HEFYR6F/hrzpxgnTFRriUCD/eIpP5SaoPPbKP9Vo5fgb716ULLUbfF
         ZENCS9Jj/EG+0y0CJBYcmwOG2C2mpWAaU+K/5vqdMS3QwKItGVRG3ANx9GeZNeXIWy
         EXAOYX6wYZnGI7BjR75Kub9sHsmRr2rmw60RecOI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33EFFvWu003855
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 10:15:57 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 10:15:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 10:15:57 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33EFFuLJ111031;
        Fri, 14 Apr 2023 10:15:56 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH v2 2/5] arm64: dts: ti: k3-j784s4: Add Main CPSW2G node
Date:   Fri, 14 Apr 2023 20:45:50 +0530
Message-ID: <20230414151553.339599-3-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414151553.339599-1-j-choudhary@ti.com>
References: <20230414151553.339599-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Siddharth Vadapalli <s-vadapalli@ti.com>

J784S4 SoC has a Main CPSW2G instance of the CPSW Ethernet Switch.

Add the device-tree nodes for the Main CPSW2G instance and enable it.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 48 +++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 68 ++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index f33815953e77..aef6f53ae8ac 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -105,6 +105,30 @@ vdd_sd_dv: regulator-TLV71033 {
 };
 
 &main_pmx0 {
+	main_cpsw2g_pins_default: main-cpsw2g-pins-default {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x0b8, PIN_INPUT, 6) /* (AC34) MCASP1_ACLKX.RGMII1_RD0 */
+			J784S4_IOPAD(0x0a0, PIN_INPUT, 6) /* (AD34) MCASP0_AXR12.RGMII1_RD1 */
+			J784S4_IOPAD(0x0a4, PIN_INPUT, 6) /* (AJ36) MCASP0_AXR13.RGMII1_RD2 */
+			J784S4_IOPAD(0x0a8, PIN_INPUT, 6) /* (AF34) MCASP0_AXR14.RGMII1_RD3 */
+			J784S4_IOPAD(0x0b0, PIN_INPUT, 6) /* (AL33) MCASP1_AXR3.RGMII1_RXC */
+			J784S4_IOPAD(0x0ac, PIN_INPUT, 6) /* (AE34) MCASP0_AXR15.RGMII1_RX_CTL */
+			J784S4_IOPAD(0x08c, PIN_INPUT, 6) /* (AE35) MCASP0_AXR7.RGMII1_TD0 */
+			J784S4_IOPAD(0x090, PIN_INPUT, 6) /* (AC35) MCASP0_AXR8.RGMII1_TD1 */
+			J784S4_IOPAD(0x094, PIN_INPUT, 6) /* (AG35) MCASP0_AXR9.RGMII1_TD2 */
+			J784S4_IOPAD(0x098, PIN_INPUT, 6) /* (AH36) MCASP0_AXR10.RGMII1_TD3 */
+			J784S4_IOPAD(0x0b4, PIN_INPUT, 6) /* (AL34) MCASP1_AXR4.RGMII1_TXC */
+			J784S4_IOPAD(0x09c, PIN_INPUT, 6) /* (AF35) MCASP0_AXR11.RGMII1_TX_CTL */
+		>;
+	};
+
+	main_cpsw2g_mdio_pins_default: main-cpsw2g-mdio-pins-default {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x0c0, PIN_INPUT, 6) /* (AD38) MCASP1_AXR0.MDIO0_MDC */
+			J784S4_IOPAD(0x0bc, PIN_INPUT, 6) /* (AD33) MCASP1_AFSX.MDIO0_MDIO */
+		>;
+	};
+
 	main_uart8_pins_default: main-uart8-pins-default {
 		pinctrl-single,pins = <
 			J784S4_IOPAD(0x040, PIN_INPUT, 14) /* (AF37) MCASP0_AXR0.UART8_CTSn */
@@ -253,3 +277,27 @@ &mcu_cpsw_port1 {
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&mcu_phy0>;
 };
+
+&main_cpsw1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_cpsw2g_pins_default>;
+};
+
+&main_cpsw1_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_cpsw2g_mdio_pins_default>;
+
+	main_phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
+
+&main_cpsw1_port1 {
+	status = "okay";
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&main_phy0>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 344f4ffa0b82..35b2ee07549b 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -36,6 +36,12 @@ scm_conf: scm-conf@100000 {
 		#size-cells = <1>;
 		ranges = <0x00 0x00 0x00100000 0x1c000>;
 
+		cpsw1_phy_gmii_sel: phy@4034 {
+			compatible = "ti,am654-phy-gmii-sel";
+			reg = <0x4034 0x4>;
+			#phy-cells = <1>;
+		};
+
 		serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "mmio-mux";
 			#mux-control-cells = <1>;
@@ -777,6 +783,68 @@ cpts@310d0000 {
 		};
 	};
 
+	main_cpsw1: ethernet@c200000 {
+		compatible = "ti,j721e-cpsw-nuss";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x00 0xc200000 0x00 0x200000>;
+		reg-names = "cpsw_nuss";
+		ranges = <0x00 0x00 0x00 0xc200000 0x00 0x200000>;
+		dma-coherent;
+		clocks = <&k3_clks 62 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 62 TI_SCI_PD_EXCLUSIVE>;
+
+		dmas = <&main_udmap 0xc640>,
+		       <&main_udmap 0xc641>,
+		       <&main_udmap 0xc642>,
+		       <&main_udmap 0xc643>,
+		       <&main_udmap 0xc644>,
+		       <&main_udmap 0xc645>,
+		       <&main_udmap 0xc646>,
+		       <&main_udmap 0xc647>,
+		       <&main_udmap 0x4640>;
+		dma-names = "tx0", "tx1", "tx2", "tx3",
+			    "tx4", "tx5", "tx6", "tx7",
+			    "rx";
+
+		status = "disabled";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			main_cpsw1_port1: port@1 {
+				reg = <1>;
+				label = "port1";
+				phys = <&cpsw1_phy_gmii_sel 1>;
+				ti,mac-only;
+				status = "disabled";
+			};
+		};
+
+		main_cpsw1_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio", "ti,davinci_mdio";
+			reg = <0x00 0xf00 0x00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 62 0>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+		};
+
+		cpts@3d000 {
+			compatible = "ti,am65-cpts";
+			reg = <0x00 0x3d000 0x00 0x400>;
+			clocks = <&k3_clks 62 3>;
+			clock-names = "cpts";
+			interrupts-extended = <&gic500 GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
+
 	main_mcan0: can@2701000 {
 		compatible = "bosch,m_can";
 		reg = <0x00 0x02701000 0x00 0x200>,
-- 
2.25.1

