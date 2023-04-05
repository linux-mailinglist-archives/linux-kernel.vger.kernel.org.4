Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7A56D89E1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjDEVyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjDEVyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:54:10 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88E27AAC;
        Wed,  5 Apr 2023 14:54:08 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 335LrpoV051045;
        Wed, 5 Apr 2023 16:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680731631;
        bh=OGQgP81QELG7B6BAJCyPAAmPFSowSXoe1rc96FWoh1E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eOPDJaJd7eGizM4lebT9VNPSFhw/2r/iePcV0alhUT3x6xKLXr2NnfsweHtuHGVXM
         1C+EIF+BZ/h3i+/p3c8LY2VxwshlF6/6sXOARIZmD0fLhGU6Ld6Q2Sg2lHmEKehQuO
         loHQIbh2mdM7559+20s63BZEhCQ8B/X1j4FbDHTg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 335Lrp0F031338
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Apr 2023 16:53:51 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 5
 Apr 2023 16:53:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 5 Apr 2023 16:53:50 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 335Lro44045960;
        Wed, 5 Apr 2023 16:53:50 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keerthy <j-keerthy@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bryan Brattlof <bb@ti.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH v3 1/7] arm64: dts: ti: k3-am64-main: add VTM node
Date:   Wed, 5 Apr 2023 16:53:22 -0500
Message-ID: <20230405215328.3755561-2-bb@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405215328.3755561-1-bb@ti.com>
References: <20230405215328.3755561-1-bb@ti.com>
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

The am64x supports a single VTM module which is located in the main
domain with two associated temperature monitors located at different hot
spots on the die.

Tested-by: Christian Gmeiner <christian.gmeiner@gmail.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi    |  8 +++++
 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi | 33 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am64.dtsi         |  3 ++
 3 files changed, 44 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 5e8036f32d79d..dc8c1c6021630 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1392,4 +1392,12 @@ elm0: ecc@25010000 {
 		clock-names = "fck";
 		status = "disabled";
 	};
+
+	main_vtm0: temperature-sensor@b00000 {
+		compatible = "ti,j7200-vtm";
+		reg = <0x00 0xb00000 0x00 0x400>,
+		      <0x00 0xb01000 0x00 0x400>;
+		power-domains = <&k3_pds 95 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi
new file mode 100644
index 0000000000000..036db56ba7977
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
+		thermal-sensors = <&main_vtm0 0>;
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
+		thermal-sensors = <&main_vtm0 1>;
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
index 60fe95b483120..fe49133524d32 100644
--- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
@@ -70,6 +70,7 @@ cbass_main: bus@f4000 {
 			 <0x00 0x00420000 0x00 0x00420000 0x00 0x00001000>, /* ESM0 */
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
 			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
+			 <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x02330400>, /* First peripheral window */
 			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
 			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x00800000>, /* PCIE_CORE */
@@ -106,6 +107,8 @@ cbass_mcu: bus@4000000 {
 			ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>; /* Peripheral window */
 		};
 	};
+
+	#include "k3-am64-thermal.dtsi"
 };
 
 /* Now include the peripherals for each bus segments */
-- 
2.40.0

