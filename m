Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A1F6E72FD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjDSGR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjDSGR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:17:27 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5C8E5;
        Tue, 18 Apr 2023 23:17:25 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33J6HHXS124891;
        Wed, 19 Apr 2023 01:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681885037;
        bh=piX+ON1Oiun6W8lCeERO4CEWEgtwAYMuZNvQcGbvzxk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LHKv2s6QcDR3PIcsXgoUNWrVD/h48vzlvLYILL79cGQ0TlyUQypQauyEDiz/6H+/y
         u2FzcxO/SBASTCoEM6Qg+U0SJCBNKztPTPKTuVys/0I2pHh85giSckAEn9GMnSHj3h
         t5Ef5GpbXm9F+QDuq9Jz8yCmzynbGtYvZrT4fNuM=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33J6HHc9001920
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Apr 2023 01:17:17 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 19
 Apr 2023 01:17:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 19 Apr 2023 01:17:16 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33J6HGO4040914;
        Wed, 19 Apr 2023 01:17:16 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>
CC:     <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <a-bhatia1@ti.com>, <j-choudhary@ti.com>
Subject: [PATCH v3 4/5] arm64: dts: ti: k3-j784s4-main: Add DSS and DP-bridge node
Date:   Wed, 19 Apr 2023 11:47:09 +0530
Message-ID: <20230419061710.290068-5-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419061710.290068-1-j-choudhary@ti.com>
References: <20230419061710.290068-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rahul T R <r-ravikumar@ti.com>

Add DSS and DP-bridge node for J784S4 SoC. DSS IP in J784S4 is
same as DSS IP in J721E, so same compatible is being used.
The DP is Cadence MHDP8546.

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
[j-choudhary@ti.com: move all k3-j784s4-main.dtsi changes together]
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 51aa476dedba..739741e93bc1 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -1373,4 +1373,81 @@ main_spi7: spi@2170000 {
 		clocks = <&k3_clks 383 1>;
 		status = "disabled";
 	};
+
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

