Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35E36BA7BC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjCOGXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjCOGX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:23:27 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93B25C9D9;
        Tue, 14 Mar 2023 23:23:25 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32F6NFfh090610;
        Wed, 15 Mar 2023 01:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678861395;
        bh=eLo46IzbsOYCRryf+5dtB+lxf//RU+jJSuDqsVB1sH0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hnBYD99WwvlIN/VRenk99jVy0jsHkSctMhHvgyp7jSUb4tg8gle3HNk00EJWQEG+7
         xrUAEY7Z9F2JLbsynxKSPgo6XmmJq9xfmgsXc8Nd6l0nkOPdg0ezG/xbIF/jMGC9G1
         TwdX//BrcTK5/VfdMQom33ZZdDX84xU1z2ymTeWI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32F6NF7C105452
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Mar 2023 01:23:15 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 15
 Mar 2023 01:23:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 15 Mar 2023 01:23:15 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32F6N7bs024744;
        Wed, 15 Mar 2023 01:23:12 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3 1/4] arm64: dts: ti: k3-j721e: Add CPSW9G nodes
Date:   Wed, 15 Mar 2023 11:53:04 +0530
Message-ID: <20230315062307.1612220-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315062307.1612220-1-s-vadapalli@ti.com>
References: <20230315062307.1612220-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI's J721E SoC has a 9 port Ethernet Switch instance with 8 external
ports and 1 host port, referred to as CPSW9G.

Add device-tree nodes for CPSW9G and disable it by default. Device-tree
overlays will be used to enable it.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 116 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi      |   1 +
 2 files changed, 117 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index c935622f0102..44f2833c5187 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -61,6 +61,13 @@ serdes_ln_ctrl: mux-controller@4080 {
 				      <J721E_SERDES4_LANE2_EDP_LANE2>, <J721E_SERDES4_LANE3_EDP_LANE3>;
 		};
 
+		cpsw0_phy_gmii_sel: phy@4044 {
+			compatible = "ti,j721e-cpsw9g-phy-gmii-sel";
+			ti,qsgmii-main-ports = <2>, <2>;
+			reg = <0x4044 0x20>;
+			#phy-cells = <1>;
+		};
+
 		usb_serdes_mux: mux-controller@4000 {
 			compatible = "mmio-mux";
 			#mux-control-cells = <1>;
@@ -404,6 +411,115 @@ cpts@310d0000 {
 		};
 	};
 
+	cpsw0: ethernet@c000000 {
+		compatible = "ti,j721e-cpswxg-nuss";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x0 0xc000000 0x0 0x200000>;
+		reg-names = "cpsw_nuss";
+		ranges = <0x0 0x0 0x0 0x0c000000 0x0 0x200000>;
+		clocks = <&k3_clks 19 89>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 19 TI_SCI_PD_EXCLUSIVE>;
+
+		dmas = <&main_udmap 0xca00>,
+		       <&main_udmap 0xca01>,
+		       <&main_udmap 0xca02>,
+		       <&main_udmap 0xca03>,
+		       <&main_udmap 0xca04>,
+		       <&main_udmap 0xca05>,
+		       <&main_udmap 0xca06>,
+		       <&main_udmap 0xca07>,
+		       <&main_udmap 0x4a00>;
+		dma-names = "tx0", "tx1", "tx2", "tx3",
+			    "tx4", "tx5", "tx6", "tx7",
+			    "rx";
+
+		status = "disabled";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cpsw0_port1: port@1 {
+				reg = <1>;
+				ti,mac-only;
+				label = "port1";
+				status = "disabled";
+			};
+
+			cpsw0_port2: port@2 {
+				reg = <2>;
+				ti,mac-only;
+				label = "port2";
+				status = "disabled";
+			};
+
+			cpsw0_port3: port@3 {
+				reg = <3>;
+				ti,mac-only;
+				label = "port3";
+				status = "disabled";
+			};
+
+			cpsw0_port4: port@4 {
+				reg = <4>;
+				ti,mac-only;
+				label = "port4";
+				status = "disabled";
+			};
+
+			cpsw0_port5: port@5 {
+				reg = <5>;
+				ti,mac-only;
+				label = "port5";
+				status = "disabled";
+			};
+
+			cpsw0_port6: port@6 {
+				reg = <6>;
+				ti,mac-only;
+				label = "port6";
+				status = "disabled";
+			};
+
+			cpsw0_port7: port@7 {
+				reg = <7>;
+				ti,mac-only;
+				label = "port7";
+				status = "disabled";
+			};
+
+			cpsw0_port8: port@8 {
+				reg = <8>;
+				ti,mac-only;
+				label = "port8";
+				status = "disabled";
+			};
+		};
+
+		cpsw9g_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+			reg = <0x0 0xf00 0x0 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 19 89>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+			status = "disabled";
+		};
+
+		cpts@3d000 {
+			compatible = "ti,j721e-cpts";
+			reg = <0x0 0x3d000 0x0 0x400>;
+			clocks = <&k3_clks 19 16>;
+			clock-names = "cpts";
+			interrupts-extended = <&gic500 GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
+
 	main_crypto: crypto@4e00000 {
 		compatible = "ti,j721e-sa2ul";
 		reg = <0x0 0x4e00000 0x0 0x1200>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index 6975cae644d9..ddbaa06e21bd 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
@@ -135,6 +135,7 @@ cbass_main: bus@100000 {
 			 <0x00 0x06000000 0x00 0x06000000 0x00 0x00400000>, /* USBSS0 */
 			 <0x00 0x06400000 0x00 0x06400000 0x00 0x00400000>, /* USBSS1 */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0af02400>, /* Most peripherals */
+			 <0x00 0x0c000000 0x00 0x0c000000 0x00 0x0d000000>, /* CPSW9G */
 			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
 			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x01800000>, /* PCIe Core*/
 			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x01800000>, /* PCIe Core*/
-- 
2.25.1

