Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DC46B1E3C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCIIdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCIIcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:32:06 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7B51C586;
        Thu,  9 Mar 2023 00:30:57 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3298Tr3j114065;
        Thu, 9 Mar 2023 02:29:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678350593;
        bh=W4IRqp9fnfqQfK0waN/elvEgtsN6ANjzaWHXJ4TCwuo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EMIWUpSj/HYhFB8Zdu5O0sqSeUIz7X/SKZPlKhMRB2IQKYLC2j9Afw+e94Grhy1Ku
         u2J+0C4QWhkvI2E65TZlvz5/iJRSNxYxYpnIIHQ6xbz0tHfpm88/zwT5NMBsRdjP5r
         Z0tLwirBjH6oG98Edl0+IKp/DacOp7Ptk1CbHS0Y=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3298TriH022748
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Mar 2023 02:29:53 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 9
 Mar 2023 02:29:52 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 9 Mar 2023 02:29:52 -0600
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3298Tf5B063317;
        Thu, 9 Mar 2023 02:29:49 -0600
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <vaishnav.a@ti.com>, <r-gunasekaran@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 2/8] arm64: dts: ti: k3-j721s2-main: Add SERDES and WIZ device tree node
Date:   Thu, 9 Mar 2023 13:59:34 +0530
Message-ID: <20230309082940.31535-3-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230309082940.31535-1-r-gunasekaran@ti.com>
References: <20230309082940.31535-1-r-gunasekaran@ti.com>
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
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
I had reviewed this patch in the v7 series [0].
Since I'm taking over upstreaming this series, I removed the self
Reviewed-by tag.

[0] - https://lore.kernel.org/lkml/4173e0c6-61d9-5b79-44ec-317870de070b@ti.com/

Changes from v12:
* Disabled only nodes that need additional info

Changes from v11:
* Cleaned up comments

Changes from v10:
* Fixed dtbs warnings by adding "reg" property to the mux-controller nodes
* Documented the reason for disabling the nodes by default
* Removed Link tag from commit message

Changes from v9:
* Disabled serdes related nodes by default in common DT file

Changes from v8:
* No change

Changes from v7:
* Updated mux-controller node name

Changes from v6:
* Fixed the incorrect "compatible" property

Changes from v5:
* Removed Cc tag from commit message

Changes from v4:
* No change

Changes from v3:
* No change

Changes from v2:
* Reworked SERDES + WIZ enablement patchset to use properies for clocks
  defines versus entire devicetree nodes. Results in cleaner code that
  doesn't break dt-schema or the driver functionality.

Changes from v1:
* Update mux-controller node name

 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 2ea971dcb3f2..c248cb5a986a 100644
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
@@ -39,6 +50,14 @@
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
 		};
+
+		serdes_ln_ctrl: mux-controller@80 {
+			compatible = "mmio-mux";
+			reg = <0x80 0x10>;
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x80 0x3>, <0x84 0x3>, /* SERDES0 lane0/1 select */
+					<0x88 0x3>, <0x8c 0x3>; /* SERDES0 lane2/3 select */
+		};
 	};
 
 	gic500: interrupt-controller@1800000 {
@@ -790,6 +809,44 @@
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
+
+			status = "disabled"; /* Needs lane config */
+		};
+	};
+
 	main_mcan0: can@2701000 {
 		compatible = "bosch,m_can";
 		reg = <0x00 0x02701000 0x00 0x200>,
-- 
2.17.1

