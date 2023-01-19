Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1449367460C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjASWbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjASW3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:29:45 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F48C381A;
        Thu, 19 Jan 2023 14:13:42 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30JMDV06042940;
        Thu, 19 Jan 2023 16:13:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674166411;
        bh=EhVmb2u2O6mw4AA79EZXTNGXm1WaiokelpyqCkP0Q/0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wBnTXLVO84owiGov3GID3wBz6sHmt4knS3O/IBLYZjf+9WwHaH9IlzaiOod5RWyYh
         910rKK63EugTyONpuOUmpNHppcb3awJUpQLA1U4WMJdrRnyrQ8aa/CC7+25fLo3xCA
         9IJ54ijO3ew/LQnsOPC0s8RR0owjtC89evzSZ4Y0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30JMDVSU122576
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Jan 2023 16:13:31 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 19
 Jan 2023 16:13:30 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 19 Jan 2023 16:13:30 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30JMDUqU046558;
        Thu, 19 Jan 2023 16:13:30 -0600
From:   Bryan Brattlof <bb@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 4/6] arm64: dts: ti: k3-j721s2-mcu-wakeup: add VTM node
Date:   Thu, 19 Jan 2023 16:13:20 -0600
Message-ID: <20230119221322.12563-5-bb@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119221322.12563-1-bb@ti.com>
References: <20230119221322.12563-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4456; i=bb@ti.com; h=from:subject; bh=bi4FblxH6lsHOjpjZdiQo9patDWW3roBBQlfzTClUAM=; b=owNCWmg5MUFZJlNZao4iMwAAZ3///7/55v997f+m1ty22srf73d7eq2n6sfLbG8d/7dL7V8wARsT EMTJkYmRoNNMgA0aDRpowhoABkANDJo0aZBiGgyGjINAaDQANNPUyDCPUz1DpoGhpo9QNAA0AGTQBo ANAG1NAHoIBoD1AAD0jah6Q9NEeoPUGTagDQaNqeoKlG9SaG0jNRoAPUAaMgA0GgA0AZDJo0AAGgAG gBpoAANAB4o9TamBAIbp5cVsGcwul2QHhpOIDbjJNhTU6ov2/oAXfeDfdMxSj8GdFFSqhoUAA65e6F TrW6GTOOKOuL4MmWBZN17JAkbQhP4M1mN2mFIPKzv2lvUQADhR8Kgf44O6NB1Ah+Vnt9wpowRRB4TZ XCVAhlAE7lqQiGIefYMFrRem0jCyg62ybZzmp3yxxUtISxJDckx+X53800+q/Dyp3n9OOstqtSzAYH SsFONhItH2a+vUbGKDCa8fxYeb1YJSUdob9m7Y+q4k4Yc6u+qPP7TrEyUXkuTbllEif1IeKUGgDcLG eKmBzh+zvfRE3BsphfK+LSmMsgDuzImZZOVIWpoxEKIQ0cNoQiRELL5OUJ6BurP58eRCO3C6Aq7MMW wcaKaB9MHgCg6gYAWeOicAB8XXJs57yXEdgqda8zhLkBAxcaPi4Yu5IpwoSDVHERmA
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
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

The j721s2 supports a single Voltage and Thermal Management (VTM) device
located in the wakeup domain with seven associated temperature monitors
located in various hot spots on the die.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |   8 ++
 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi | 103 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi         |   2 +
 3 files changed, 113 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 0af242aa98162..b31a0a812f83f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -306,4 +306,12 @@ cpts@3d000 {
 			ti,cpts-periodic-outputs = <2>;
 		};
 	};
+
+	wkup_vtm0: temperature-sensor@42040000 {
+		compatible = "ti,j7200-vtm";
+		reg = <0x0 0x42040000 0x0 0x350>,
+		      <0x0 0x42050000 0x0 0x350>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-thermal.dtsi
new file mode 100644
index 0000000000000..945f3fa44aefa
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
+		thermal-sensors = <&wkup_vtm0 0>;
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
+		thermal-sensors = <&wkup_vtm0 1>;
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
+		thermal-sensors = <&wkup_vtm0 2>;
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
+		thermal-sensors = <&wkup_vtm0 3>;
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
+		thermal-sensors = <&wkup_vtm0 4>;
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
+		thermal-sensors = <&wkup_vtm0 5>;
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
+		thermal-sensors = <&wkup_vtm0 6>;
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
index 7b930a85a29d6..0c8234a4d7978 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
@@ -161,6 +161,8 @@ cbass_mcu_wakeup: bus@28380000 {
 		};
 
 	};
+
+	#include "k3-j721s2-thermal.dtsi"
 };
 
 /* Now include peripherals from each bus segment */
-- 
2.39.0

