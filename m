Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA890674606
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjASWay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjASW3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:29:34 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6337CC3816;
        Thu, 19 Jan 2023 14:13:41 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30JMDVVK103031;
        Thu, 19 Jan 2023 16:13:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674166411;
        bh=psud6/3Zex7Bnj45jRaOEP9aFmHjkTfzCmLnvxu6vqs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rQ8Fw6aEX2w/ybHwjAcNJMDLTfTvI/6FD/59qLfDZvc6dj4U/SpmgL2+l/mjv8VoW
         g+JVVYOzaBbSknK2zxy1TAuWYAfaJpEcgwTfNj+E2n1/gY5Jih+N2LmcpSwWiFnLsi
         SI61B0YpdZBzAp14p750Jc1iu4OEe+CEj+uZX2JM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30JMDVdw122571
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Jan 2023 16:13:31 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 19
 Jan 2023 16:13:30 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 19 Jan 2023 16:13:30 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30JMDUnw006937;
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
Subject: [PATCH 6/6] arm64: dts: ti: k3-am62a-wakeup: add VTM node
Date:   Thu, 19 Jan 2023 16:13:22 -0600
Message-ID: <20230119221322.12563-7-bb@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119221322.12563-1-bb@ti.com>
References: <20230119221322.12563-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3073; i=bb@ti.com; h=from:subject; bh=+8oOI2FkMbYpUXhfzeFebAQn++Ewvzjr9qxmkxY3bBs=; b=owNCWmg5MUFZJlNZU+tJIAAAYP////f5/zm9rMe5Nuxam07ffFt+/Xdm//vff7l8v/nq13+wARsw GJAA0GmjQDCNANGjIAaAaNMQ0NAGgDQaAGjQAAGg00aMmE000xMT1MaZIcgAaA0Bo00GRo0aNG1NDQ aA0ZAyDBAeiBkA0eoABoyaGJ6h6Q9Q9IGmQ0ZA0HJp6mgyaMhhNGgGIGjINGTTQNAZGmgAZMJkwTQM mCBoZNBkAGQAaMgGgyAAYHiHsguMcAkQ4mjmwP79rzIvTDQ8oWJBY6npBqjlIhh7o7nUFY8j1UF78e 8T6D6XNOB8zkr9NYpedxRVIyLcnQ3utv4AIIAlysKUVqKDq9j1fztMiNL6NU8FcnrYLaYhGQi1DGdL XwAODe7RuwgsRaSED+YUL1YLW+2rsBNizGVqeF4ZdTzpYnDJD02ojklIYRkmnPWu+3hhnmq5Vy9s6C vdzbSMC+yEqZGGnRrvxCDKIRihrtNEXi4k/tlfLyzo+vkdZiheqyoE2HpFPgUEu7U+pvLICNwErWYN EhSyChNjmDs9hKDjOlAbEfQ5GPXkINPinA6RuxCAScSYctTGOD2QOW0eDkDQWYqxxT163+S4/PUU07 ICeBYFdjI0SsiZKvjLw6GiyVGEIacu54VaSBmSYigLTNPnwgp3VgXyYfRf4u5IpwoSCn1pJAA=
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
index 0000000000000..02c2bae300c49
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
+		thermal-sensors = <&wkup_vtm0 0>;
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
+	       thermal-sensors = <&wkup_vtm0 0>;
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

