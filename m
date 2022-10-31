Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05656141CA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJaX2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJaX1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:27:32 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83FD12095;
        Mon, 31 Oct 2022 16:27:30 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRGWX108487;
        Mon, 31 Oct 2022 18:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667258836;
        bh=5ei+T2sIfAKZXLx4GUkSoCxdo3May+AmglUqcXsO3Q8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IxIYhJF5aHhtyf0S2qk+sE/UD+Ou3cRF3YV+MT3u72SQfE/CVo/A2CXPfU/jKB1Pm
         9qXU9VftMmy9jI6dTG5Cc3SSWglOuAWPO/wcXCnAmO2RiFTvJYUCwCuKxRWuwNHaWw
         n5TADnp59RAIFUPk/PMBaoc1WGAUEyXkjsb6uQKg=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VNRG3O023432
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 18:27:16 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 18:27:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 18:27:16 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRGrY037194;
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
Subject: [PATCH v3 11/11] arm64: dts: ti: k3-j7200-mcu-wakeup: add VTM node
Date:   Mon, 31 Oct 2022 18:27:02 -0500
Message-ID: <20221031232702.10339-12-bb@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031232702.10339-1-bb@ti.com>
References: <20221031232702.10339-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3069; h=from:subject; bh=/KShhWi5jQQedZMyH6niU354AAmxTCGEnVimVHPNn8c=; b=owNCWmg5MUFZJlNZDN/x1QAAYv///7/9Ui+/3zv/Uuf92M7f0LN/4e337H7P3m3ftZ3D1v+wARmY IeoAHpDygABo0AGgDJiBoGagDQNBkAAANBkABoBmpo9QNAPUDZJ5HqhkmhoMmg0GQNBtQ00BiaZDRo D1GgDIaGTQGmIxDRkHqZND1PSAA0ZHqDRpoDQ0AdNNpGjTTQBkaaZHqGTQ00yDIaaMgbUBkANNDIyA yGjIaaAMEDQaAGIYAgAAByRoUxFZAA0rHHjUmn5qTALR4sFsfUSF8xHyoa7On+8NBD6HuDBD47XqbB esQOqfo9AXupZ1V4NdSrbe/4EdAw3Z3nN3AS757lkBpIoNLKMcVmysXAL1hiFqEucunQOgzbn9KXlG imPFDysLwn130UqL4VyweQmPqgN6u9G5nAgBatoQrT+Jb/t+snCqkED8dlNBhqCWMztXb5tdvBBQgX 73Drq/jGfrcsDcU9Ww7BbdPXflH2nULFjzsWq29r2PanJ9BL4YAaX8/h+gsgln4MPnslQtdKZ7EWh6 RXqups4MDv6UKVzdbr5L6NqIaDdOJNpQSdRw7kudy1CsNNQeLVlUp1KrTrQi5S6PsilYRnuILBDh76 Fo33GwTPDR5sUpPYCRcNNck8DRFGbrTIU/L4zRiZnmpgGugRoAEDgQ5YM4H+LuSKcKEgGb/jqg
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

The j7200 supports a single Voltage and Thermal Management (VTM) device
located in the wakeup domain with three associated temperature monitors
located in various hot spots on the die.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |  8 ++++
 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi  | 47 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          |  3 ++
 3 files changed, 58 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index e5be78a58682d..651d17dd20663 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -395,4 +395,12 @@ rng: rng@40910000 {
 			status = "disabled"; /* Used by OP-TEE */
 		};
 	};
+
+	vtm0: temperature-sensor@42040000 {
+		compatible = "ti,j7200-vtm";
+		reg = <0x00 0x42040000 0x00 0x350>,
+		      <0x00 0x42050000 0x00 0x350>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
new file mode 100644
index 0000000000000..0bf52c93c3f9a
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+thermal_zones: thermal-zones {
+	mcu_thermal: mcu-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 0>;
+
+		trips {
+			wkup_crit: wkup-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	mpu_thermal: mpu-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 1>;
+
+		trips {
+			mpu_crit: mpu-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	main_thermal: main-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 2>;
+
+		trips {
+			c7x_crit: c7x-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j7200.dtsi b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
index b6da0454cc5bd..9368a6e3d4a62 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
@@ -168,6 +168,9 @@ cbass_mcu_wakeup: bus@28380000 {
 				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3 */
 		};
 	};
+
+	#include "k3-j7200-thermal.dtsi"
+
 };
 
 /* Now include the peripherals for each bus segments */
-- 
2.38.1

