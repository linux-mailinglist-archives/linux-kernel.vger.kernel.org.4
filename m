Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBBF6B3BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjCJKOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjCJKOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:14:25 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB768BB88;
        Fri, 10 Mar 2023 02:14:22 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32AAEF29108499;
        Fri, 10 Mar 2023 04:14:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678443255;
        bh=6GvAZyFMKg90w9HQG1XFTYiQhZzeMjsaONLRoCSnOqQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KIIrT6j8EtaBTbkbsgtZeBdzUV3f6UYLtRuivmNm8/az+MGtwrz1S+gXAsZm79nPd
         +eW47YCMLg13S/1gbg9QC2TCthESaHrMUfQ+7hyan0yo1hfm+rj7hHRYHmbK3bJdhB
         6CY0q/f9MkVlZdwYLlrjqwrMUxE373eq8N4S3npo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32AAEFjD063461
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Mar 2023 04:14:15 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 10
 Mar 2023 04:14:14 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 10 Mar 2023 04:14:15 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32AAE8f8024145;
        Fri, 10 Mar 2023 04:14:12 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: j7200-main: Add CPSW5G nodes
Date:   Fri, 10 Mar 2023 15:44:06 +0530
Message-ID: <20230310101407.722334-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310101407.722334-1-s-vadapalli@ti.com>
References: <20230310101407.722334-1-s-vadapalli@ti.com>
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

TI's J7200 SoC has a 5 port Ethernet Switch instance with 4 external
ports and 1 host port, referred to as CPSW5G.

Add device-tree nodes for CPSW5G and disable it by default. Device-tree
overlays will be used to enable it.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 83 +++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 138381f43ce4..e9d42ae4ed09 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -39,6 +39,13 @@ serdes_ln_ctrl: mux-controller@4080 {
 					<0x4088 0x3>, <0x408c 0x3>; /* SERDES0 lane2/3 select */
 		};
 
+		cpsw0_phy_gmii_sel: phy@4044 {
+			compatible = "ti,j7200-cpsw5g-phy-gmii-sel";
+			ti,qsgmii-main-ports = <1>;
+			reg = <0x4044 0x10>;
+			#phy-cells = <1>;
+		};
+
 		usb_serdes_mux: mux-controller@4000 {
 			compatible = "mmio-mux";
 			#mux-control-cells = <1>;
@@ -304,6 +311,82 @@ cpts@310d0000 {
 		};
 	};
 
+	cpsw0: ethernet@c000000 {
+		compatible = "ti,j7200-cpswxg-nuss";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x00 0xc000000 0x00 0x200000>;
+		reg-names = "cpsw_nuss";
+		ranges = <0x00 0x00 0x00 0xc000000 0x00 0x200000>;
+		clocks = <&k3_clks 19 33>;
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
+		};
+
+		cpsw5g_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+			reg = <0x00 0xf00 0x00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 19 33>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+		};
+
+		cpts@3d000 {
+			compatible = "ti,j721e-cpts";
+			reg = <0x00 0x3d000 0x00 0x400>;
+			clocks = <&k3_clks 19 16>;
+			clock-names = "cpts";
+			interrupts-extended = <&gic500 GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
+
 	main_pmx0: pinctrl@11c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
-- 
2.25.1

