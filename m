Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B9B6141C9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJaX2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJaX1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:27:31 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5CF1116F;
        Mon, 31 Oct 2022 16:27:30 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRGpt092617;
        Mon, 31 Oct 2022 18:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667258836;
        bh=Le+bXLRPi2PorGOqYWdZ7TXZI7dPM2vRnsQn7M/5zyo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GOIBYdqr5m+M5T6f1wqZMP5mdOqKCZY6Hg89K0JuOkfPO0aYVaM5NyUXXCrpLEoNs
         4mPHio4/Y3W8UwuaHZVyRw9BSMSHv3PGnLuZ5l649Ef8lxY1uz7zEb6yWiXI9MhFX5
         Un7Q+ge5rl0PGlDmihSTuzaqyXUYE569RAoW4dbo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VNRGfL022969
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 18:27:16 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 18:27:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 18:27:16 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRGPV027840;
        Mon, 31 Oct 2022 18:27:16 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Keerthy <j-keerthy@ti.com>, Linux PM <linux-pm@vger.kernel.org>,
        Device Trees <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LKML ARM <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH v3 07/11] arm64: dts: ti: k3-am64-main: add VTM node
Date:   Mon, 31 Oct 2022 18:26:58 -0500
Message-ID: <20221031232702.10339-8-bb@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031232702.10339-1-bb@ti.com>
References: <20221031232702.10339-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3215; h=from:subject; bh=xlJl/GZ0bAid8uJVN8dSqjl+Si5t64KdmpX6Ljuu5Vs=; b=owNCWmg5MUFZJlNZynwIaQAAdH////97T6//m8f3v/pzfMbv/n9/+b3X7luZ/d7sz5Ny5P8wARmY IepoAGhkNAAAA0Bo0NABoAGQAAGgepoA0AADTQA0ND1HqHqNGh5PVPUbU3qhlDQGjQGgDCaGINA0DT RppoaAaaaB6mIBoaNNBphA0aeoZA0ZDQDQDQyNB6jTRph0NPQTaIwhk0AaDQGNTCA00AMQ00BoBpoA aHpABiNAGTTQBoNGTQAAAw+6gG8DUhjxiHCAFEiBPECOGBQ4xckWCYWPCtyr8Ip6twIJPePeLxsWHB g5l1bd71KRhELKNKIRRyFvoCNhjruhaO5h102em/qxlh7evgmoiuQdD7C2hINuUHxzw1wYsfCWHHqj 9v9vNpwTRAs2mGv4MbKY76SXE3JW07ZS/VOXv/RArD/xNKHLVcAEkzwOXk3AOzOG5IT+mtlijwQwPi 7DEkOH7Ed4X04ENExdWLBMa+Y/OplX1IRVimlIODT5CFrjf0IIf5jBwNPEm9lh1LTcxu/wWMl59w2o BeFcQq+lp4slBQqVaHZHArcxHkKfIMA3YygrDOBFvsmb13HR+It99G1aUYvNE/aMY0XSHjcUUS2FJk YnfWCc59cqYSO8Ly75acIl4PZnzOtqz2FQFJuhKuPxIEYQGqoozqWFZTA2DEKD/F3JFOFCQynwIaQ=
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The am64x supports a single VTM module which is located in the main
domain with two associated temperature monitors located at different hot
spots on the die.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi    |  8 +++++
 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi | 33 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am64.dtsi         |  4 +++
 3 files changed, 45 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index d6aa23681bbe5..a31a139127e35 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1356,4 +1356,12 @@ elm0: ecc@25010000 {
 		clocks = <&k3_clks 54 0>;
 		clock-names = "fck";
 	};
+
+	vtm0: temperature-sensor@b00000 {
+		compatible = "ti,j7200-vtm";
+		reg = <0x00 0xb00000 0x00 0x400>,
+		      <0x00 0xb01000 0x00 0x400>;
+		power-domains = <&k3_pds 95 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi
new file mode 100644
index 0000000000000..1819a6948b19d
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+thermal_zones: thermal-zones {
+	main0_thermal: main0-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 0>;
+
+		trips {
+			main0_crit: main0-crit {
+				temperature = <105000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	main1_thermal: main1-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 1>;
+
+		trips {
+			main1_crit: main1-crit {
+				temperature = <105000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
index c858725133af4..a0170605d7b4e 100644
--- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
@@ -69,6 +69,7 @@ cbass_main: bus@f4000 {
 			 <0x00 0x00420000 0x00 0x00420000 0x00 0x00001000>, /* ESM0 */
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
 			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
+			 <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x02330400>, /* First peripheral window */
 			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
 			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x00800000>, /* PCIE_CORE */
@@ -105,6 +106,9 @@ cbass_mcu: bus@4000000 {
 			ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>; /* Peripheral window */
 		};
 	};
+
+	#include "k3-am64-thermal.dtsi"
+
 };
 
 /* Now include the peripherals for each bus segments */
-- 
2.38.1

