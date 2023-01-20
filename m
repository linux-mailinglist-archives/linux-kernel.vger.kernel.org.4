Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1804674806
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 01:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjATAbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 19:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjATAbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 19:31:20 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57247A3142;
        Thu, 19 Jan 2023 16:31:19 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30K0V3aP069173;
        Thu, 19 Jan 2023 18:31:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674174663;
        bh=u+uc2nYXPIgUszj4w49lgbEZtWJWci+3AIakOyLqess=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=d83kb17jziKbHf7WZBqOUCr3lUyC0zmFX9dPvnSDsjgie3+YaUFl8MGWOLQDpRtjr
         bhh51GZf2l7BUVol1zdjCj/0hbplhy9lPiykYaU1jby+EMfEaEaLVR0mdxA767XnNy
         xMtyEe97YKIX2a1+9vDDOH0intA6XF1np+lqet6g=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30K0V3mG089211
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Jan 2023 18:31:03 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 19
 Jan 2023 18:31:02 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 19 Jan 2023 18:31:02 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30K0V20C021528;
        Thu, 19 Jan 2023 18:31:02 -0600
From:   Bryan Brattlof <bb@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     ARM Linux Mailing List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keerthy <j-keerthy@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 6/6] arm64: dts: ti: k3-am62a-wakeup: add VTM node
Date:   Thu, 19 Jan 2023 18:30:51 -0600
Message-ID: <20230120003051.9100-7-bb@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120003051.9100-1-bb@ti.com>
References: <20230120003051.9100-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3073; i=bb@ti.com; h=from:subject; bh=+Kty86j+q7PXR7vWHvLKDTs+vLrH0F5uM0CEG61hrrE=; b=owNCWmg5MUFZJlNZhSzbRgAAZf///v7/7//9uf/6h//cv/t+TyT6+v7Nv38///qtq9Rc++cwARtg HagAGhoAAAND0hoAAAaAaAGQNABoDQ00BoAAAGTTRpiaMJieptGowTahxGgNAAyMg0ANMmmQaaAGjQ AAyNGmEaZBmoxDINNBpkBoaA0MmQBoDQAaMHQaMjaTEBoaANGQaDTRhNA0A0BkGQZA0aNDIAYhoBpo NAYgAaGQYmRoBpoAwe3rBt+uACo8t5FPn8/Y1zNGx4UvV9YEEJBdEl3AjTrlWcS+4Jat8nQAJTICSE sW8OSwTIUl0/NHAgMBQ1lFwIgLF2qVnXIsdDyidl9rpVpMYIvUw5o3QVU9Nr+/V3T/1an0Snczu2Cf xvT6ETV8Sp2twV4eBCqoA2tkNRl2Sq84iURoQZeAxEyxabMGsyJRg8lyqGuPO6+Tr+QzxusrEYhTk0 S4msIF38iwXDvHmSpkgL0j3D+gUIb6dKGIwtPBI7LB5B+MdQRH6mjv2xOUkOV0i6p3CXpD+yG/HTxl R/AUq7Z+yTFRsbc+UDr1Y1VI60glnRhg2gomUXFElC0dhRSYeW3vxCpJ3hlqDEuhBkG8Lv79R8fKWq jwIGUeycnlA97pkZhlp3WZ+zBfbDJIDVKi0giDtaTDNi0FhHRoQFchDUKAELd8wuoKD/i7kinChIQp Ztow
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

The am62ax supports a single Voltage and Thermal Management (VTM) device
located in the wakeup domain with three associated temperature monitors
located in various hot spots of the die.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-thermal.dtsi | 47 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi  |  8 ++++
 arch/arm64/boot/dts/ti/k3-am62a.dtsi         |  2 +
 3 files changed, 57 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-thermal.dtsi
new file mode 100644
index 0000000000000..85ce545633ea5
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62a-thermal.dtsi
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+thermal_zones: thermal-zones {
+	main0_thermal: main0-thermal {
+		polling-delay-passive = <250>;	/* milliSeconds */
+		polling-delay = <500>;		/* milliSeconds */
+		thermal-sensors = <&wkup_vtm0 0>;
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
+		thermal-sensors = <&wkup_vtm0 1>;
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
+	       polling-delay-passive = <250>;	/* milliSeconds */
+	       polling-delay = <500>;		/* milliSeconds */
+	       thermal-sensors = <&wkup_vtm0 2>;
+
+		trips {
+			main2_crit: main2-crit {
+				temperature = <125000>;	/* milliCelsius */
+				hysteresis = <2000>;	/* milliCelsius */
+				type = "critical";
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
index 81d984414fd4a..9bdafead7199a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
@@ -51,4 +51,12 @@ wkup_rtc0: rtc@2b1f0000 {
 		wakeup-source;
 		status = "disabled";
 	};
+
+	wkup_vtm0: temperature-sensor@b00000 {
+		compatible = "ti,j7200-vtm";
+		reg = <0x00 0xb00000 0x00 0x400>,
+		      <0x00 0xb01000 0x00 0x400>;
+		power-domains = <&k3_pds 95 TI_SCI_PD_EXCLUSIVE>;
+		#thermal-sensor-cells = <1>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62a.dtsi b/arch/arm64/boot/dts/ti/k3-am62a.dtsi
index 6eb87c3f9f3ce..84e8adeeebb61 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a.dtsi
@@ -114,6 +114,8 @@ cbass_wakeup: bus@b00000 {
 				 <0x00 0x78100000 0x00 0x78100000 0x00 0x00008000>; /* DM R5 BTCM*/
 		};
 	};
+
+	#include "k3-am62a-thermal.dtsi"
 };
 
 /* Now include the peripherals for each bus segments */
-- 
2.39.0

