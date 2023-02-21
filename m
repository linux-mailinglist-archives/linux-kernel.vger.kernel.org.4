Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AAF69DFF0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbjBUMIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbjBUMI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:08:27 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FF35B86;
        Tue, 21 Feb 2023 04:07:50 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31LC6OcI053088;
        Tue, 21 Feb 2023 06:06:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1676981184;
        bh=cExpIumSTLuVMmqSbxDSSZTlNuqqHrIuMxc8UKNUbgU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CZ0GZrGXjkFwxpcIhXkI/mCGB5cxd80oO6wBZEvLaTH/ZyolnSiLUYlbUEi6s4zgO
         zTjwJWxfvB5mBNV63JLQ/7Sz1aUM/G444+7QRiCNH2x9yrY0OnrGiSUAyvlOG8Toiv
         7pXb3T0ORt2985j7Wm1OgRxIwFKJqUr3bxGsYjoY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31LC6O4J125754
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Feb 2023 06:06:24 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 21
 Feb 2023 06:06:24 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 21 Feb 2023 06:06:23 -0600
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31LC6CbP030829;
        Tue, 21 Feb 2023 06:06:20 -0600
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 2/9] arm64: dts: ti: k3-j721s2-main: Add support for USB
Date:   Tue, 21 Feb 2023 17:36:05 +0530
Message-ID: <20230221120612.27366-3-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230221120612.27366-1-r-gunasekaran@ti.com>
References: <20230221120612.27366-1-r-gunasekaran@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswath Govindraju <a-govindraju@ti.com>

Add support for single instance of USB 3.0 controller in J721S2 SoC.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
Link: https://lore.kernel.org/r/20221122101616.770050-2-mranostay@ti.com
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
I had reviewed this patch in the v5 series [1].
Since I'm taking over upstreaming this series, I removed the self
Reviewed-by tag.

Links:

[1] - https://lore.kernel.org/all/134c28a0-2d49-549c-dc8d-0887d8fd29c3@ti.com/

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 8915132efcc1..84e5689fff9f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -26,6 +26,20 @@
 		};
 	};
 
+	scm_conf: syscon@104000 {
+		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
+		reg = <0x00 0x00104000 0x00 0x18000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x00104000 0x18000>;
+
+		usb_serdes_mux: mux-controller@0 {
+			compatible = "mmio-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
+		};
+	};
+
 	gic500: interrupt-controller@1800000 {
 		compatible = "arm,gic-v3";
 		#address-cells = <2>;
@@ -745,6 +759,38 @@
 		};
 	};
 
+	usbss0: cdns-usb@4104000 {
+		compatible = "ti,j721e-usb";
+		reg = <0x00 0x04104000 0x00 0x100>;
+		clocks = <&k3_clks 360 16>, <&k3_clks 360 15>;
+		clock-names = "ref", "lpm";
+		assigned-clocks = <&k3_clks 360 16>; /* USB2_REFCLK */
+		assigned-clock-parents = <&k3_clks 360 17>;
+		power-domains = <&k3_pds 360 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		dma-coherent;
+
+		status = "disabled";
+
+		usb0: usb@6000000 {
+			compatible = "cdns,usb3";
+			reg = <0x00 0x06000000 0x00 0x10000>,
+			      <0x00 0x06010000 0x00 0x10000>,
+			      <0x00 0x06020000 0x00 0x10000>;
+			reg-names = "otg", "xhci", "dev";
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "host", "peripheral", "otg";
+			maximum-speed = "super-speed";
+			dr_mode = "otg";
+
+			status = "disabled";
+		};
+	};
+
 	main_mcan0: can@2701000 {
 		compatible = "bosch,m_can";
 		reg = <0x00 0x02701000 0x00 0x200>,
-- 
2.17.1

