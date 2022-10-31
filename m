Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAAA6141C4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJaX1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJaX13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:27:29 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864371115E;
        Mon, 31 Oct 2022 16:27:26 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRGbg106694;
        Mon, 31 Oct 2022 18:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667258836;
        bh=Ppy3zj//WI1ACIOqsOM3ldBjuSRvYHp+YSUCh+3iEyY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=q9XxqXKzOPWJbmgUtos/VPnDb2/Duu/A1MWxIu5vxlqcZCkSSIkop0ViswAN8qfAG
         WnIq52NTEuoeCoZHVs7U4D1FlncpnlPCbS4Rb0CQtlN0EGuDStvyWiXMeoJgJQyWrU
         QxpH8hpyxS5zWXRnK+Q36HvyR+N1StM1K4NNhJho=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VNRGeJ007682
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 18:27:16 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 18:27:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 18:27:16 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRGq5124795;
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
Subject: [PATCH v3 10/11] arm64: dts: ti: k3-j721s2-mcu-wakeup: add VTM node
Date:   Mon, 31 Oct 2022 18:27:01 -0500
Message-ID: <20221031232702.10339-11-bb@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031232702.10339-1-bb@ti.com>
References: <20221031232702.10339-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4419; h=from:subject; bh=yUbz1YnFlzwwEX5NAPRC/e00ihhrXaBsJBs9hFJUH8E=; b=owNCWmg5MUFZJlNZ3/T6mgAAbH////9/j7/33On/L+fr/H+r34/7y925r+L1Xe1b05L6wl+wARsx pA9DUaBoAAD1GgGgAAaBoMgNANA2o0APU0NNAAaAA9QaGjQepp6j0nqZHpMZQ5MjTTI0NAwjQGgBpo YgaBo0aYgAAYjJoPQQyGmmg9QYmhoeoPUNNA9IZADQDvVGT1ABiaBkaDQBpoaDTQ0yGg0BoAyDQyNB oxGJkAyBoBo00NAyA0Gh6g9NBw5rB2xzDf1GCEQhSKFYQaI6OX1YJJfGoFoM0y48mSGXuW5AvRlmPG JuX7oFVphS23T55AGijN6PwF5M+CTpEDZnFIN91hhu+OQv8pFyIeijSiVhUDNsWZx0wWocEDEBSOd2 ZU3G4SDfrQE807GMekLwDVY/0JOdlMEiyWAjl+2FbWtsyXv6xZDDcEbrqc6q192y5QGLMMDQI0R9tv GqCyOAxD/S0ScXEINVfwi4Psnu2EDZkG1B9r2pFiYL9PLUJgumrLy7nbZrGfoMVi1xeI0PsU90yZpD o78cZKlPyJRNGKZxRN7JuCtGHALFJpzZOerKfwjSmMXztMSlRDEFAw/4JRgIGoYdaOdEPFj9vysfQq jahASdwgANEEDyuwM5maVgCHa+oX+IL3mCTF5dJxUJXdAGKRQVg2sL9SAEqMz/F3JFOFCQ3/T6mg==
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

The j721s2 supports a single Voltage and Thermal Management (VTM) device
located in the wakeup domain with seven associated temperature monitors
located in various hot spots on the die.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |   8 ++
 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi | 103 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi         |   3 +
 3 files changed, 114 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 4d1bfabd1313a..8287fd32c42f3 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -299,4 +299,12 @@ cpts@3d000 {
 			ti,cpts-periodic-outputs = <2>;
 		};
 	};
+
+	vtm0: temperature-sensor@42040000 {
+		compatible = "ti,j7200-vtm";
+		reg = <0x0 0x42040000 0x0 0x350>,
+		      <0x0 0x42050000 0x0 0x350>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi
new file mode 100644
index 0000000000000..c51009536756e
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+thermal_zones: thermal-zones {
+	wkup0_thermal: wkup0-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 0>;
+
+		trips {
+			wkup0_crit: wkup0-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	wkup1_thermal: wkup1-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 1>;
+
+		trips {
+			wkup1_crit: wkup1-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	main0_thermal: main0-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 2>;
+
+		trips {
+			main0_crit: main0-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	main1_thermal: main1-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 3>;
+
+		trips {
+			main1_crit: main1-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	main2_thermal: main2-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 4>;
+
+		trips {
+			main2_crit: main2-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	main3_thermal: main3-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 5>;
+
+		trips {
+			main3_crit: main3-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	main4_thermal: main4-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 6>;
+
+		trips {
+			main4_crit: main4-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
index 7b930a85a29d6..33ea52e28b24f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
@@ -161,6 +161,9 @@ cbass_mcu_wakeup: bus@28380000 {
 		};
 
 	};
+
+	#include "k3-j721s2-thermal.dtsi"
+
 };
 
 /* Now include peripherals from each bus segment */
-- 
2.38.1

