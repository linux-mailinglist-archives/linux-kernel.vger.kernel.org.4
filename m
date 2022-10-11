Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662825FBE52
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJKXSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJKXSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:18:25 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF4FA02D9;
        Tue, 11 Oct 2022 16:18:20 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29BNI7gw087602;
        Tue, 11 Oct 2022 18:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665530287;
        bh=ifPTetxL+42FtzkGJpKl3HOJsxdbDcsQt1OE8BdlIv0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HeJqJdMDrT60ESYHHmdB6ZS8clQ+XEsGIhcxvFa0rPW3bqhZCdnQ/GhytYJwgmjBg
         PzvunoibHkhnb8LrQudmcztx8zZPzQqmkwB2MjQIW/xsHttgL839UWbDngq6gRTyb4
         vQRub+d2MvxAuBOpHG2OIUxH0Sg6YOhmIBaYNZI8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29BNI7TM130219
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Oct 2022 18:18:07 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 11
 Oct 2022 18:18:06 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 11 Oct 2022 18:18:06 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29BNI6Ap088553;
        Tue, 11 Oct 2022 18:18:06 -0500
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
Subject: [PATCH 10/11] arm64: dts: ti: k3-j721s2-mcu-wakeup: add VTM node
Date:   Tue, 11 Oct 2022 18:17:26 -0500
Message-ID: <20221011231727.8090-11-bb@ti.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221011231727.8090-1-bb@ti.com>
References: <20221011231727.8090-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4419; h=from:subject; bh=olB1dowVR4Q+8T9smVkWKRdaLIkZJxl0ga3x4QT4VF0=; b=owNCWmg5MUFZJlNZALUuVgAAa////v9/1je+2q/+NqnfvFtTv/0v7m7e/uez/67bqxn8l34wARsy himgaB6jT1AAGgAAaBoGgANPUAAAADTIDQGgBo0002kPUAaGgZNHlPxUQaGhoGgeo0BiDJ6hoekyYh oGgDTIAGIYgNPSNPUyD0EGIaAaADRo0MmjR6RoHJo0GajQyaNNAZDJoxBoaANBiZDCANGmgAAyDJkD EyaBpkwmgBk0wTEaMkCYXMDuzgAEpnbQ2TmZcT3FRwVGHOeOjPhAL4ZJAqMp6g1OzK0SRaLxRLoGir Z0Uye6pGrPiwsqqN6mTtXr4iv7NWb360Pc4wD6wka9ejG22GcTokwRS3ig+SvGmBJKHeujbtmz8udC 9gCa0EBAX1WIyhAxTnEG4tC5Ey2PP/mJSbxXuQ0FYQy0kC0zFmPMIzNFOvLg6IhHvBNQq0vH7qqVau JUcqTmc+sG2nMeDK0XlUE+hBvyIZYenxa+ax2GC6IVLxMnsi/RTLIlAhV3pWrIgUPVAVrVnn4MCvUD NilnpsfFYRo2V2jLQQJT8EWe3Tmq2NnY/riwG73hMKIBT4JJ0cTuQiGyDIPOu7Wspd2/7rUeXcCYBS kPjrW0XtqNRDnKbcKYY8gTBNMyz7QANwRyItmcH++BDhGiqQT9XiL/xdyRThQkAC1LlYA=
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
2.38.0

