Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACF36D7AEC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbjDELOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbjDELOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:14:33 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3367B5B8A;
        Wed,  5 Apr 2023 04:14:31 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 335BEJSW019349;
        Wed, 5 Apr 2023 06:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680693259;
        bh=ne/R9/9lcpXYVNtZtDesLZu+LTAyPLuUfK5bBFhGcXs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=U2KD8wmpGD/UfM10e3cB/ETJjIGHifyMykdvb/JRyqZt4RBbA72Hqf8BCl2ZYDSmS
         fAX/i1QIBNXQI25pc5IHkC4hXcnxs49ZnQFQujDV5yvHucoQ0HqQpBJKy3IRzpTgjQ
         nNzUXCLtZZHGlPLLgi2D2rqeUlOgd/DPOqrgidqU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 335BEJsA041827
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Apr 2023 06:14:19 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 5
 Apr 2023 06:14:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 5 Apr 2023 06:14:19 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 335BEISE120287;
        Wed, 5 Apr 2023 06:14:19 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH 4/6] arm64: dts: ti: k3-j784s4-*: Add DSS node
Date:   Wed, 5 Apr 2023 16:44:10 +0530
Message-ID: <20230405111412.151192-5-j-choudhary@ti.com>
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

Add DSS node for J784S4 SoC. DSS IP in J784S4
is same as DSS IP in J721E, so same compatible is
being used.
Also add assigned clks for DSS

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 11 +++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 55 ++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index b1445b7c2aa8..ccbfca76e9ae 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -305,3 +305,14 @@ &main_cpsw1_port1 {
 &serdes_refclk {
 	clock-frequency = <100000000>;
 };
+
+&dss {
+	assigned-clocks = <&k3_clks 218 2>,
+			  <&k3_clks 218 5>,
+			  <&k3_clks 218 14>,
+			  <&k3_clks 218 18>;
+	assigned-clock-parents = <&k3_clks 218 3>,
+				 <&k3_clks 218 7>,
+				 <&k3_clks 218 16>,
+				 <&k3_clks 218 22>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 0cd692bc52e6..86ce6f6d4fc2 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -1373,4 +1373,59 @@ main_spi7: spi@2170000 {
 		clocks = <&k3_clks 383 1>;
 		status = "disabled";
 	};
+
+	dss: dss@4a00000 {
+		compatible = "ti,j721e-dss";
+		reg =
+			<0x00 0x04a00000 0x00 0x10000>,
+			<0x00 0x04a10000 0x00 0x10000>,
+			<0x00 0x04b00000 0x00 0x10000>,
+			<0x00 0x04b10000 0x00 0x10000>,
+
+			<0x00 0x04a20000 0x00 0x10000>,
+			<0x00 0x04a30000 0x00 0x10000>,
+			<0x00 0x04a50000 0x00 0x10000>,
+			<0x00 0x04a60000 0x00 0x10000>,
+
+			<0x00 0x04a70000 0x00 0x10000>,
+			<0x00 0x04a90000 0x00 0x10000>,
+			<0x00 0x04ab0000 0x00 0x10000>,
+			<0x00 0x04ad0000 0x00 0x10000>,
+
+			<0x00 0x04a80000 0x00 0x10000>,
+			<0x00 0x04aa0000 0x00 0x10000>,
+			<0x00 0x04ac0000 0x00 0x10000>,
+			<0x00 0x04ae0000 0x00 0x10000>,
+			<0x00 0x04af0000 0x00 0x10000>;
+
+		reg-names = "common_m", "common_s0",
+			"common_s1", "common_s2",
+			"vidl1", "vidl2","vid1","vid2",
+			"ovr1", "ovr2", "ovr3", "ovr4",
+			"vp1", "vp2", "vp3", "vp4",
+			"wb";
+
+		clocks =	<&k3_clks 218 0>,
+				<&k3_clks 218 2>,
+				<&k3_clks 218 5>,
+				<&k3_clks 218 14>,
+				<&k3_clks 218 18>;
+		clock-names = "fck", "vp1", "vp2", "vp3", "vp4";
+
+		power-domains = <&k3_pds 218 TI_SCI_PD_EXCLUSIVE>;
+
+		interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "common_m",
+				  "common_s0",
+				  "common_s1",
+				  "common_s2";
+
+		status = "disabled";
+
+		dss_ports: ports {
+		};
+	};
 };
-- 
2.25.1

