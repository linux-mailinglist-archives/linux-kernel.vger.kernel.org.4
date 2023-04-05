Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43F86D89D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjDEVyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjDEVyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:54:07 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DCAFC;
        Wed,  5 Apr 2023 14:54:04 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 335LrpHU114249;
        Wed, 5 Apr 2023 16:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680731631;
        bh=xN760rbk7X7t42fFuQeV7C+DgQOsr7aMbwzhpDSCWQc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=q89ROqbl5a5/tc+nnhA21EIgluubg/OttnYn1MtzgZYEjY8fHwjRKf+pILjKMyMD/
         n0txJOtbzoiglyyAhqjD9/Mpsfib/O/THjgwJACPq49kkvsq0OInR2bJCP8Go3obun
         JZOWIO9TONX2VQGE8mdQZtx0jHaqxbNqfQ2HvYs8=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 335LrpuP031346
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Apr 2023 16:53:51 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 5
 Apr 2023 16:53:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 5 Apr 2023 16:53:51 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 335LrppM012705;
        Wed, 5 Apr 2023 16:53:51 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keerthy <j-keerthy@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH v3 5/7] arm64: dts: ti: j721e: Add VTM node
Date:   Wed, 5 Apr 2023 16:53:26 -0500
Message-ID: <20230405215328.3755561-6-bb@ti.com>
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

From: Keerthy <j-keerthy@ti.com>

VTM stands for Voltage Thermal Management. Add the thermal zones.
Five sensors mapping ton 5 thermal zones. WKUP, MPU, C7x, GPU & R5F
respectively.

Signed-off-by: Keerthy <j-keerthy@ti.com>
[bb@ti.com: rebased on v6.3-rc1]
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  9 +++
 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi  | 75 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |  2 +
 3 files changed, 86 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 24e8125db8c44..50688e55e6a5a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -458,4 +458,13 @@ mcu_spi2: spi@40320000 {
 		clocks = <&k3_clks 276 0>;
 		status = "disabled";
 	};
+
+	wkup_vtm0: temperature-sensor@42040000 {
+		compatible = "ti,j721e-vtm";
+		reg = <0x00 0x42040000 0x00 0x350>,
+			<0x00 0x42050000 0x00 0x350>,
+			<0x00 0x43000300 0x00 0x10>;
+		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
new file mode 100644
index 0000000000000..c2523279001bf
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+thermal_zones: thermal-zones {
+	wkup_thermal: wkup-thermal {
+		polling-delay-passive = <250>; /* milliseconds */
+		polling-delay = <500>; /* milliseconds */
+		thermal-sensors = <&wkup_vtm0 0>;
+
+		trips {
+			wkup_crit: wkup-crit {
+				temperature = <125000>; /* milliCelsius */
+				hysteresis = <2000>; /* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	mpu_thermal: mpu-thermal {
+		polling-delay-passive = <250>; /* milliseconds */
+		polling-delay = <500>; /* milliseconds */
+		thermal-sensors = <&wkup_vtm0 1>;
+
+		trips {
+			mpu_crit: mpu-crit {
+				temperature = <125000>; /* milliCelsius */
+				hysteresis = <2000>; /* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	c7x_thermal: c7x-thermal {
+		polling-delay-passive = <250>; /* milliseconds */
+		polling-delay = <500>; /* milliseconds */
+		thermal-sensors = <&wkup_vtm0 2>;
+
+		trips {
+			c7x_crit: c7x-crit {
+				temperature = <125000>; /* milliCelsius */
+				hysteresis = <2000>; /* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	gpu_thermal: gpu-thermal {
+		polling-delay-passive = <250>; /* milliseconds */
+		polling-delay = <500>; /* milliseconds */
+		thermal-sensors = <&wkup_vtm0 3>;
+
+		trips {
+			gpu_crit: gpu-crit {
+				temperature = <125000>; /* milliCelsius */
+				hysteresis = <2000>; /* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+
+	r5f_thermal: r5f-thermal {
+		polling-delay-passive = <250>; /* milliseconds */
+		polling-delay = <500>; /* milliseconds */
+		thermal-sensors = <&wkup_vtm0 4>;
+
+		trips {
+			r5f_crit: r5f-crit {
+				temperature = <125000>; /* milliCelsius */
+				hysteresis = <2000>; /* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index b912143b6a110..154eff06e7b75 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
@@ -184,6 +184,8 @@ cbass_mcu_wakeup: bus@28380000 {
 				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3*/
 		};
 	};
+
+	#include "k3-j721e-thermal.dtsi"
 };
 
 /* Now include the peripherals for each bus segments */
-- 
2.40.0

