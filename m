Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356AB6B3C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjCJKgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjCJKg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:36:29 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C61111B28;
        Fri, 10 Mar 2023 02:36:06 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32AAZC3E112570;
        Fri, 10 Mar 2023 04:35:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678444512;
        bh=zecu4Dkj1NP+2bK5nhx0QaP/I0pwX+MjJTmA50/nH+o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=x2bAdcAVYN8qmLuQ8R3ix3AzXpa7PzvJ6prbrNiau2FB9IIzSN+p2IbDq8p16vCiH
         7km6BHOz0W9RZIoCsYkAV4oSTohMRHgAPsH/srP5wpX4KEMFH0LQ7sjE2Y4X15WwaE
         41ObNMg1fvX0KwF7eOHkbgaizOdA+KBiSZ+u5MgY=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32AAZCMA075920
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Mar 2023 04:35:12 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 10
 Mar 2023 04:35:11 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 10 Mar 2023 04:35:11 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32AAZ4Pg088652;
        Fri, 10 Mar 2023 04:35:08 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-j721e: Add CPSW9G nodes
Date:   Fri, 10 Mar 2023 16:05:03 +0530
Message-ID: <20230310103504.731845-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310103504.731845-1-s-vadapalli@ti.com>
References: <20230310103504.731845-1-s-vadapalli@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 107 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi      |   1 +
 2 files changed, 108 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index c935622f0102..1ac7a47fc437 100644
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
@@ -404,6 +411,106 @@ cpts@310d0000 {
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
+			};
+
+			cpsw0_port2: port@2 {
+				reg = <2>;
+				ti,mac-only;
+				label = "port2";
+			};
+
+			cpsw0_port3: port@3 {
+				reg = <3>;
+				ti,mac-only;
+				label = "port3";
+			};
+
+			cpsw0_port4: port@4 {
+				reg = <4>;
+				ti,mac-only;
+				label = "port4";
+			};
+
+			cpsw0_port5: port@5 {
+				reg = <5>;
+				ti,mac-only;
+				label = "port5";
+			};
+
+			cpsw0_port6: port@6 {
+				reg = <6>;
+				ti,mac-only;
+				label = "port6";
+			};
+
+			cpsw0_port7: port@7 {
+				reg = <7>;
+				ti,mac-only;
+				label = "port7";
+			};
+
+			cpsw0_port8: port@8 {
+				reg = <8>;
+				ti,mac-only;
+				label = "port8";
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

