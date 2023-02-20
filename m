Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF8169C970
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjBTLOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjBTLOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:14:40 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBFE1ADC4;
        Mon, 20 Feb 2023 03:14:29 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31KBENWo116606;
        Mon, 20 Feb 2023 05:14:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1676891663;
        bh=YLh6vzk0xYQVhQjGqCVkRBo9Mz+EdLFNx+vqEHcffc4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VqYM2HG+4PzzBww84hu3HhxN9TMRoGnvyzl0opQdqAwOJ7OOcIX0SswazldYHJr8r
         85+K38SP5l00YwseEO3TmBe8LfPxMHhxHu66eytoaX7Ll9BXEilrUUXZJ1ymMgwYnN
         QVyBJC+YEohMbojFtxbhSyZlD7G209qH6Qmv/8DU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31KBENh3032352
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Feb 2023 05:14:23 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Feb 2023 05:14:23 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Feb 2023 05:14:23 -0600
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31KBE984068490;
        Mon, 20 Feb 2023 05:14:20 -0600
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 3/9] arm64: dts: ti: k3-j721s2-main: Add SERDES and WIZ device tree node
Date:   Mon, 20 Feb 2023 16:44:02 +0530
Message-ID: <20230220111408.9476-4-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230220111408.9476-1-r-gunasekaran@ti.com>
References: <20230220111408.9476-1-r-gunasekaran@ti.com>
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

From: Matt Ranostay <mranostay@ti.com>

Add dt node for the single instance of WIZ (SERDES wrapper) and
SERDES module shared by PCIe, eDP and USB.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
Link: https://lore.kernel.org/r/20221122101616.770050-3-mranostay@ti.com
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
I had reviewed this patch in the v7 series [1].
Since I'm taking over upstreaming this series, I removed the self
Reviewed-by tag.

Links:

[1] - https://lore.kernel.org/lkml/4173e0c6-61d9-5b79-44ec-317870de070b@ti.com/

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 56 +++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index c0daa75116f9..2858ba589d54 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -5,6 +5,17 @@
  * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include <dt-bindings/phy/phy-cadence.h>
+#include <dt-bindings/phy/phy-ti.h>
+
+/ {
+	serdes_refclk: clock-cmnrefclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+};
+
 &cbass_main {
 	msmc_ram: sram@70000000 {
 		compatible = "mmio-sram";
@@ -33,11 +44,18 @@
 		#size-cells = <1>;
 		ranges = <0x00 0x00 0x00104000 0x18000>;
 
-		usb_serdes_mux: mux-controller@0 {
+		usb_serdes_mux: mux-controller-0 {
 			compatible = "mmio-mux";
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
 		};
+
+		serdes_ln_ctrl: mux-controller-80 {
+			compatible = "mmio-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x80 0x3>, <0x84 0x3>, /* SERDES0 lane0/1 select */
+					<0x88 0x3>, <0x8c 0x3>; /* SERDES0 lane2/3 select */
+		};
 	};
 
 	gic500: interrupt-controller@1800000 {
@@ -787,6 +805,42 @@
 		};
 	};
 
+	serdes_wiz0: wiz@5060000 {
+		compatible = "ti,j721s2-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 365 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 365 0>, <&k3_clks 365 3>, <&serdes_refclk>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+		ranges = <0x5060000 0x0 0x5060000 0x10000>;
+
+		assigned-clocks = <&k3_clks 365 3>;
+		assigned-clock-parents = <&k3_clks 365 7>;
+
+		serdes0: serdes@5060000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05060000 0x00010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz0 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz0 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz0 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz0 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 365 3>,
+						 <&k3_clks 365 3>,
+						 <&k3_clks 365 3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+		};
+	};
+
 	main_mcan0: can@2701000 {
 		compatible = "bosch,m_can";
 		reg = <0x00 0x02701000 0x00 0x200>,
-- 
2.17.1

