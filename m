Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF6F5FBE4C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJKXSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJKXSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:18:23 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD975F22F;
        Tue, 11 Oct 2022 16:18:20 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29BNI57D087596;
        Tue, 11 Oct 2022 18:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665530285;
        bh=jUNAK1LH+Kz9Qe/YJaSDQ69ikOIfmhp6b86sLuEeeYo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TZKHMIKR1veBP6XMoABLoPIXMjjlRnm2z3N+r1KazZGVUz9KqVcaJp6H5SsUC28qD
         e/J3KRIK7iHNV/dYBfg2QuZgwakLhaQJBGuJzBKKvMV9jCQnUiEMG/baTlMujMegw4
         vamLCJV8isWoRKAvrBzoR/z/iYz/84AeMVlTIIsQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29BNI5aB130202
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Oct 2022 18:18:05 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 11
 Oct 2022 18:18:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 11 Oct 2022 18:18:04 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29BNI4iY019294;
        Tue, 11 Oct 2022 18:18:04 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Linux Thermal <linux-pm@vger.kernel.org>,
        Linux Device Tree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 08/11] arm64: dts: ti: k3-am62-wakeup: add VTM node
Date:   Tue, 11 Oct 2022 18:17:24 -0500
Message-ID: <20221011231727.8090-9-bb@ti.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221011231727.8090-1-bb@ti.com>
References: <20221011231727.8090-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3321; h=from:subject; bh=3SwwZw3B+jRGmn68A/SGYmeFVf6idBvVtZYlVu4q7IU=; b=owNCWmg5MUFZJlNZebrKHwAAZP///7//3237yf/75J1pf/um3X3n62+7fvfffz9evZVa//UwARsx o5D1DQHqaAADRoA0aAA0DQGmgAaA0AGgGgABkNA0aaPSA0ND1MgepptQzKbREAaaNBkGQBkaANNDQA yBoNAABkAyeiYgMRpoxMg9QbUNMmgANGJpoAaAyMO1Gag000YgGgaNMRiaANDIZNADIA0yaAABo0DI yBk000DI0ANAGgAMgB5QUKtxdIC83fkCJeHs0RiQZjvtcgWPGiE1jFthB/Mc8O4r6JoS+E3bePoCfl 45WrYtnv36SSG4BjLYLtpAXESypn5mBx6gPR4EflICyWhpY3loiOzc3Tw2fQKySaWQT147CtO6IwNH ESGcAalYUTNqV1yH+rTppkTEenOKzG/WIaQx0qq8uFUJyRYSPxVTQBwi1G738+o7jZQP3UFTYl3Jow UakM0rZEittPpg0B9YlSOlVW+mKg5VrFjgg3EEEIaShMBnA45rOY9+GUhcoNEKheEhStEo4UdETCMD riC26qDSB+eniZT0WYev2rOmDJceDWIs+B12oomZOqf6pFy84BwALxZ48CRmeXHz/A6EW+JmmVG3Lg Ta5vjOlslaHoH5zxIH1Lzn8GENZUwRL7CfoVBHY6fOwA50I9yc9oAGzJM06HQyQDv+LuSKcKEg83WU Pg==
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The am62x supports a single Voltage and Thermal Management (VTM) module
located in the wakeup domain with two associated temperature monitors
located in hot spots of the die.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi | 33 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi  |  8 +++++
 arch/arm64/boot/dts/ti/k3-am62.dtsi         |  7 ++++-
 3 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
new file mode 100644
index 0000000000000..1819a6948b19d
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
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
diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index 4090134676cf6..3954a73a33f35 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -38,4 +38,12 @@ wkup_i2c0: i2c@2b200000 {
 		clocks = <&k3_clks 107 4>;
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
diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
index 37fcbe7a3c336..1795f3ee534e0 100644
--- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
@@ -80,6 +80,7 @@ cbass_main: bus@f0000 {
 			 <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>,
 
 			 /* Wakeup Domain Range */
+			 <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
 			 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>,
 			 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>;
 
@@ -94,10 +95,14 @@ cbass_wakeup: bus@2b000000 {
 			compatible = "simple-bus";
 			#address-cells = <2>;
 			#size-cells = <2>;
-			ranges = <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>, /* Peripheral Window */
+			ranges = <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
+				 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>, /* Peripheral Window */
 				 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>;
 		};
 	};
+
+	#include "k3-am62-thermal.dtsi"
+
 };
 
 /* Now include the peripherals for each bus segments */
-- 
2.38.0

