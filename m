Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1B0674603
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjASWav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjASW3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:29:34 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA66C3805;
        Thu, 19 Jan 2023 14:13:41 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30JMDUgc071620;
        Thu, 19 Jan 2023 16:13:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674166410;
        bh=cEXQJWdqSirqdsfWjVaeijGRWaufQgDbMEkTdpTW4r8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bpXkLR8sf2cyrPRKYJVsIBbUKvnKR63AoxeXi3jaUCXNO2UVMp/wArGe0akm6T1mu
         Vu3NQ60eZkd97feuxFdATQUi98zB+4YEvE5xNaFVFjTLndgG8Cn3u9yuPs6nYPwuxt
         WfvWuWw4g8+0uN2PTUPkENxCGRVtJVHN5DzcMouM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30JMDUIv012463
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Jan 2023 16:13:30 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 19
 Jan 2023 16:13:30 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 19 Jan 2023 16:13:30 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30JMDUtw002656;
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
Subject: [PATCH 2/6] arm64: dts: ti: k3-am62-wakeup: add VTM node
Date:   Thu, 19 Jan 2023 16:13:18 -0600
Message-ID: <20230119221322.12563-3-bb@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119221322.12563-1-bb@ti.com>
References: <20230119221322.12563-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3326; i=bb@ti.com; h=from:subject; bh=W31s4HWtI6oPxVN7LZbcq2NBLgzbe0T/4XYkAdrsJro=; b=owNCWmg5MUFZJlNZ8sDBIwAAZ////39fviu96RH2e9/9v7xf77zvfpbk/kcd3W///vpdw9wwAQkB iQ02oYjQAAyAA0ADQDQAAaA0aAeoGg00DR6Q0aaaANNHqaNPSM0nlNDIw1Dk0AaaAaMENANDJo0epj UbSGgaNDTQDIaA9QNDJoDR6jTIZGTR6mgaBoNNGIDTIgwmIDJk0DE0DJoZNDQaYRo0AxDJkGEyDTEa DIaDEDQyMgAMmmmTExDQAfDZfHgLRYZCDRvT6cNweamndZRJhBsxoM0diYICLGBFshE9dV2Mk5QEAs r5SAwQ9Cj0DokoJRIhmOduSgebj6AF6h33bB6iVIueC5799K06hh/CBF2S82WCzd61jiguEr3C5N9T aMZkjAeaoEhl1eFPiTMvAsYXOeW59o2dKlZLaBcd4dgMxUZBqcJoD2rc4j8riGn9cSsj3BNR1Kpf+z kOqxtolEAIpVjeRNufaPByT5hm7a53tNNF7IOzGWOCzefCWoGiH4AdfigTgon9g+JbU3ogrn/ArDZM AmqfFminWyr0/ArBAxcMFgHroJfP6FYvuKZEW9ZK7gdJEYByqalqZR3/bPslyOZIs0k7lwDdnhxyPg FdMit3iEMUQ54IuVs8b5kW7BS5g1HCNnZU+6pXZhyVclId+oLmnl4dBsiipf/F3JFOFCQ8sDBIwA==
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

The am62x supports a single Voltage and Thermal Management (VTM) module
located in the wakeup domain with two associated temperature monitors
located in hot spots of the die.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi | 33 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi  |  8 +++++
 arch/arm64/boot/dts/ti/k3-am62.dtsi         |  6 +++-
 3 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
new file mode 100644
index 0000000000000..a358757e26f07
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
+		thermal-sensors = <&wkup_vtm0 0>;
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
+		thermal-sensors = <&wkup_vtm0 1>;
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
index 38dced6b4fef9..91ec9887ac6d1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -40,4 +40,12 @@ wkup_i2c0: i2c@2b200000 {
 		clock-names = "fck";
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
diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
index 37fcbe7a3c336..74cf1b4d7a6ad 100644
--- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
@@ -80,6 +80,7 @@ cbass_main: bus@f0000 {
 			 <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>,
 
 			 /* Wakeup Domain Range */
+			 <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
 			 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>,
 			 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>;
 
@@ -94,10 +95,13 @@ cbass_wakeup: bus@2b000000 {
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
 };
 
 /* Now include the peripherals for each bus segments */
-- 
2.39.0

