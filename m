Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5C260D487
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiJYTQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiJYTPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:15:35 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6797F11A;
        Tue, 25 Oct 2022 12:15:34 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29PJFKOK114089;
        Tue, 25 Oct 2022 14:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666725320;
        bh=Le+bXLRPi2PorGOqYWdZ7TXZI7dPM2vRnsQn7M/5zyo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jiTVp1Et2ENCHcp1WpQgK8PNUPLqTQS6URzLK4rce0jU/l5EpeHJyTSDAnM6bYd4j
         SEzUspbYpMZjtWzqiyYIdIlTA5YHBSj65ph3rC4Tv0wmaU8TwYFfbGl8Qpyq8Kiwij
         OLDewvvrnbnfaaABNabJJjM48zzC19yQVFp3eYUQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29PJFKh9027909
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Oct 2022 14:15:20 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 25
 Oct 2022 14:15:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 25 Oct 2022 14:15:19 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29PJFJGB018066;
        Tue, 25 Oct 2022 14:15:19 -0500
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
Subject: [PATCH v2 07/11] arm64: dts: ti: k3-am64-main: add VTM node
Date:   Tue, 25 Oct 2022 14:15:11 -0500
Message-ID: <20221025191515.9151-8-bb@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025191515.9151-1-bb@ti.com>
References: <20221025191515.9151-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3215; h=from:subject; bh=xlJl/GZ0bAid8uJVN8dSqjl+Si5t64KdmpX6Ljuu5Vs=; b=owNCWmg5MUFZJlNZOUJDugAAYv///v/5jvtvvqXe377xfuhP4b+23q7uH+tT/O3/7zH//v8wARpq hyaA0BoyGgBoA0NNNNGg0AaNNGgGhoGhoaNBk00AAA0HqGRo9IGmnppMjRkZPU8ohoGTTTBGTQyBpk BoaBgTQZGTIDQAZBk0NDIGQBoBpkBkGQxGQxNHqNGmgByZNGjI0yGCNAaAGmJiZGQaAaAAADJpkYmA TJhAGQ9QaNMQaAAGgAGQqUM3EWOSJD5AEMLNCvCOK0raYDgIouZGsRQ8MC7HwLUhM6R3yeMAS2CZk/ d9Y80hcTrWH60GRQ0RYJCJ4golRJQ5WkxQrUQ/ohsZKbamGCI3dpxx1GrDdBNDyz2tvhWIXCcUGOzZ MLcgA2UARczNLnVXgFiLdMs4Rw2KVdrl/cq5C5A6nQtiRnqssMDRQdHctPe1in3Ba5nBLPzB6qgt8g a6uUpUkJr4haH47t3utt+RcUbb8Y4kGkUnSkmUgW/0GtKs6kAFLgr3N8PpmwLZk1RuzX6USGPJphoA gPNKc7KXC8qR1XaSOHaMyYvkUqQHZoQjgPlgEKuEeZRI/LpPD9ewASrpuvub2tZ8CSjrCtc7JMrFe6 DSUiD2rA25IOBRizq4GnDItOMIcrgD4vLsd4ZMiKmye0EUYYyPPasfcjDa5Jj/i7kinChIHKEh3QA=
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The am64x supports a single VTM module which is located in the main
domain with two associated temperature monitors located at different hot
spots on the die.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi    |  8 +++++
 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi | 33 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am64.dtsi         |  4 +++
 3 files changed, 45 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index d6aa23681bbe5..a31a139127e35 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1356,4 +1356,12 @@ elm0: ecc@25010000 {
 		clocks = <&k3_clks 54 0>;
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
diff --git a/arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-am64-thermal.dtsi
new file mode 100644
index 0000000000000..1819a6948b19d
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
diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
index c858725133af4..a0170605d7b4e 100644
--- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
@@ -69,6 +69,7 @@ cbass_main: bus@f4000 {
 			 <0x00 0x00420000 0x00 0x00420000 0x00 0x00001000>, /* ESM0 */
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
 			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
+			 <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x02330400>, /* First peripheral window */
 			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
 			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x00800000>, /* PCIE_CORE */
@@ -105,6 +106,9 @@ cbass_mcu: bus@4000000 {
 			ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>; /* Peripheral window */
 		};
 	};
+
+	#include "k3-am64-thermal.dtsi"
+
 };
 
 /* Now include the peripherals for each bus segments */
-- 
2.38.1

