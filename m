Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC2A6D7AEE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbjDELOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237768AbjDELOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:14:35 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8106D5BA1;
        Wed,  5 Apr 2023 04:14:33 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 335BELQs019354;
        Wed, 5 Apr 2023 06:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680693261;
        bh=oFvQkBfdjln/WhbfYxZasipH1KQY08uztdM09uYGWpU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=h92fslHtiMrA//l7pz56s305/kDaH+0T+qnCunmYDFK/Mtg4xELkVPSQHM8937RSZ
         ey0eQl875CzUfTKekHjA0pRMGJzARNFzc1fDz2+eGnfuXSrQtsHVFmxe/nOy2DiTeX
         4CNXWMzyrEV/hnrrdd383hPU2dfRsXYBX/PCrqT0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 335BELFV078330
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Apr 2023 06:14:21 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 5
 Apr 2023 06:14:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 5 Apr 2023 06:14:20 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 335BEJ76026160;
        Wed, 5 Apr 2023 06:14:20 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH 5/6] arm64: dts: ti: k3-j784s4-*: add DP & DP PHY
Date:   Wed, 5 Apr 2023 16:44:11 +0530
Message-ID: <20230405111412.151192-6-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405111412.151192-1-j-choudhary@ti.com>
References: <20230405111412.151192-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rahul T R <r-ravikumar@ti.com>

Add DT nodes for DisplayPort and DisplayPort PHY.
The DP is Cadence MHDP 8546 and the PHY is a
Cadence Torrent PHY with TI WIZ wrapper.
Also add pinmux required for DP HPD.

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 24 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 22 ++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index ccbfca76e9ae..2b414fd973d0 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -163,6 +163,12 @@ vdd_sd_dv_pins_default: vdd-sd-dv-pins-default {
 			J784S4_IOPAD(0x020, PIN_INPUT, 7) /* (AJ35) MCAN15_RX.GPIO0_8 */
 		>;
 	};
+
+	dp0_pins_default: dp0-pins-default {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x0cc, PIN_INPUT, 12) /* (AM37) SPI0_CS0.DP0_HPD */
+		>;
+	};
 };
 
 &wkup_pmx0 {
@@ -316,3 +322,21 @@ &dss {
 				 <&k3_clks 218 16>,
 				 <&k3_clks 218 22>;
 };
+
+&serdes4 {
+	serdes4_dp_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <4>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_DP>;
+		resets = <&serdes_wiz4 1>, <&serdes_wiz4 2>,
+			 <&serdes_wiz4 3>, <&serdes_wiz4 4>;
+	};
+};
+
+&mhdp {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp0_pins_default>;
+	phys = <&serdes4_dp_link>;
+	phy-names = "dpphy";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 86ce6f6d4fc2..fc6071c16188 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -1374,6 +1374,28 @@ main_spi7: spi@2170000 {
 		status = "disabled";
 	};
 
+	mhdp: dp-bridge@a000000 {
+		compatible = "ti,j721e-mhdp8546";
+
+		reg = <0x0 0xa000000 0x0 0x30a00>,
+		      <0x0 0x4f40000 0x0 0x20>;
+		reg-names = "mhdptx", "j721e-intg";
+
+		clocks = <&k3_clks 217 11>;
+
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 614 IRQ_TYPE_LEVEL_HIGH>;
+
+		power-domains = <&k3_pds 217 TI_SCI_PD_EXCLUSIVE>;
+
+		status = "disabled";
+
+		dp0_ports: ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
 	dss: dss@4a00000 {
 		compatible = "ti,j721e-dss";
 		reg =
-- 
2.25.1

