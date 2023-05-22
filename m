Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B6B70B8C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjEVJWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjEVJWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:22:24 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F7F192;
        Mon, 22 May 2023 02:22:18 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34M9MAfi124013;
        Mon, 22 May 2023 04:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684747330;
        bh=UtrsHBNnfAjYIe2btTd6NaWBODkqO/htf4QsCBufoco=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FRl5lxQAMRbsEImOazKHroTay5Nrk8qZy1aD/o5BdXhQJVYoT9rBzxDbiLRRP3Afv
         KVUwCE0ezAVBWXeXRM7odB7XcCUe41kbi83iSErR8m6bzNuV9Y5dBnBvBfMVEPOHmm
         OfV0eQP1MskVcTNmV7TAm3MapbJgbI3jJlvPt/XM=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34M9M9GS016611
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 May 2023 04:22:09 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 May 2023 04:22:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 May 2023 04:22:09 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34M9M2e5127198;
        Mon, 22 May 2023 04:22:06 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: k3-j784s4-main: Add CPSW9G nodes
Date:   Mon, 22 May 2023 14:51:59 +0530
Message-ID: <20230522092201.127598-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230522092201.127598-1-s-vadapalli@ti.com>
References: <20230522092201.127598-1-s-vadapalli@ti.com>
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

J784S4 SoC has a 9 port Ethernet Switch instance with 8 external ports
and 1 host port, referred to as CPSW9G.

Add device-tree nodes for CPSW9G and disable it by default. Device-tree
overlays will be used to enable it.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 114 +++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index fc3ffb252fa4..be065091eebc 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -51,6 +51,13 @@ cpsw1_phy_gmii_sel: phy@4034 {
 			#phy-cells = <1>;
 		};
 
+		cpsw0_phy_gmii_sel: phy@4044 {
+			compatible = "ti,j784s4-cpsw9g-phy-gmii-sel";
+			ti,qsgmii-main-ports = <7>, <7>;
+			reg = <0x4044 0x20>;
+			#phy-cells = <1>;
+		};
+
 		serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "mmio-mux";
 			reg = <0x00004080 0x30>;
@@ -955,6 +962,113 @@ cpts@310d0000 {
 		};
 	};
 
+	main_cpsw0: ethernet@c000000 {
+		compatible = "ti,j784s4-cpswxg-nuss";
+		reg = <0x00 0xc000000 0x00 0x200000>;
+		reg-names = "cpsw_nuss";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x00 0x00 0xc000000 0x00 0x200000>;
+		dma-coherent;
+		clocks = <&k3_clks 64 0>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 64 TI_SCI_PD_EXCLUSIVE>;
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
+
+			main_cpsw0_port1: port@1 {
+				reg = <1>;
+				label = "port1";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port2: port@2 {
+				reg = <2>;
+				label = "port2";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port3: port@3 {
+				reg = <3>;
+				label = "port3";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port4: port@4 {
+				reg = <4>;
+				label = "port4";
+				ti,mac-only;
+				status = "disabled";
+			};
+
+			main_cpsw0_port5: port@5 {
+				reg = <5>;
+				label = "port5";
+				status = "disabled";
+			};
+
+			main_cpsw0_port6: port@6 {
+				reg = <6>;
+				label = "port6";
+				status = "disabled";
+			};
+
+			main_cpsw0_port7: port@7 {
+				reg = <7>;
+				label = "port7";
+				status = "disabled";
+			};
+
+			main_cpsw0_port8: port@8 {
+				reg = <8>;
+				label = "port8";
+				status = "disabled";
+			};
+		};
+
+		main_cpsw0_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+			reg = <0x00 0xf00 0x00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 64 0>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+			status = "disabled";
+		};
+
+		cpts@3d000 {
+			compatible = "ti,am65-cpts";
+			reg = <0x00 0x3d000 0x00 0x400>;
+			clocks = <&k3_clks 64 3>;
+			clock-names = "cpts";
+			interrupts-extended = <&gic500 GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
+
 	main_cpsw1: ethernet@c200000 {
 		compatible = "ti,j721e-cpsw-nuss";
 		reg = <0x00 0xc200000 0x00 0x200000>;
-- 
2.25.1

