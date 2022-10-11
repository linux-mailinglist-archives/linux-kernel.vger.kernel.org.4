Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A905FBE55
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiJKXTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJKXS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:18:59 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818B0A3F46;
        Tue, 11 Oct 2022 16:18:30 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29BNI68G086193;
        Tue, 11 Oct 2022 18:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665530286;
        bh=1VQb9sSQ2N0jAJ/+8SjEqwFBbLtyASYrM88L0xTh3os=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NCXoX/7jcTxbFd0nz9aScLBn52zqTSswMNfygYQZ42Q09aW8sDH4TOyEN8M4CR43w
         R6I0qoHvF5Y3BsXCmt1X5kitaxCZZfFBUDXpJUz6cP0ecSsptNUNERshxyuG6J1ftJ
         5NdL05/FyXMGAHW4yF+XFRmISqzuMrCkGmOK5dvk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29BNI6NJ130209
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Oct 2022 18:18:06 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 11
 Oct 2022 18:18:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 11 Oct 2022 18:18:05 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29BNI5UZ059153;
        Tue, 11 Oct 2022 18:18:05 -0500
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
Subject: [PATCH 09/11] arm64: dts: ti: k3-j721e-mcu-wakeup: add VTM node
Date:   Tue, 11 Oct 2022 18:17:25 -0500
Message-ID: <20221011231727.8090-10-bb@ti.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221011231727.8090-1-bb@ti.com>
References: <20221011231727.8090-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3842; h=from:subject; bh=JEEFlpPx89b1YLPv5hCqDO7AXnV4wMWyq9ffze9gykk=; b=owNCWmg5MUFZJlNZPDkluwAAZ3////99R+eu+E2emfp//X9f3zrn278822Pvefv+r/3t93ewARsr Yg0aZDQaDRoDQaNNDIAZDRoNNGQ0YmTTRoZAAADIA00aDIGmmTQBoyZM1BvUgBADRoANAPUAAA0Hog aDIyAaNBoNqAAaDagDBHqNMj1ANAPUD1GQaAyMj0TIYoZppNPUxBoGgPUaNAAAep6gAANBpoA0AGgB ppoBkAaDQNBoABoAaPUPFDBhOcj5ywEDtQj4jdUQqwUKQW3vjJ9dCrYnrZQld0AB7mBJwm+pGRLx/p kyBKFhl7EGSKRBB8tQeQA6HRBHWQ5oLjR8MB1FxrR7rsy/A/UhVbdkk51qxUHj2bxBCo9WKJNwiEzL mfYnHMAo/btbdy0M/Z5eAgPdWfabLfa1kbEsrMM/jGL1kFoiHcpnuvCZgZghh1JNYj4w7NQktBOJid NkwHYu52p54Vi+HNgGTRNJQLT76wuafa3g2gK9WuzjTADDIwPD+FNjvRzE707idIymwwnc0DOTaZvJ 9C1sL2Fci2BCOMdfiCPwR0mW7TRAKAJ/fgJnEvX9x5li0PposIEM4O8LYy39woEaB5+Y7P2gUf4uLQ fxx794YhSDVlIvt8VhDiEGrEoUj9KKSSwpKWdLTZcTVA3yoAuZZ9JXeMnLD/xdyRThQkDw5Jbs
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

The j721e supports a single Voltage and Thermal Management (VTM) module
located in the wakeup domain with five associated temperature monitors
located in various hot spots on the die.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  9 +++
 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi  | 75 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |  3 +
 3 files changed, 87 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index df08724bbf1c5..9a09f66c51c01 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -418,4 +418,13 @@ mcu_mcan1: can@40568000 {
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
 	};
+
+	vtm0: temperature-sensor@42040000 {
+		compatible = "ti,j721e-vtm";
+		reg = <0x00 0x42040000 0x00 0x350>,
+		      <0x00 0x42050000 0x00 0x350>,
+		      <0x00 0x43000300 0x00 0x10>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
new file mode 100644
index 0000000000000..79641927a9092
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+thermal_zones: thermal-zones {
+	wkup_thermal: wkup-thermal {
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
+	c7x_thermal: c7x-thermal {
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
+
+	gpu_thermal: gpu-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 3>;
+
+		trips {
+			gpu_crit: gpu-crit {
+				temperature = <125000>; /* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	r5f_thermal: r5f-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&vtm0 4>;
+
+		trips {
+			r5f_crit: r5f-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index 0e23886c9fd1d..cfab10e2455c4 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
@@ -181,6 +181,9 @@ cbass_mcu_wakeup: bus@28380000 {
 				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3*/
 		};
 	};
+
+	#include "k3-j721e-thermal.dtsi"
+
 };
 
 /* Now include the peripherals for each bus segments */
-- 
2.38.0

