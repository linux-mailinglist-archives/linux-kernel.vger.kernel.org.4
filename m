Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C616B5AB7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 11:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCKK70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 05:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCKK7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 05:59:16 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507CBA92D0;
        Sat, 11 Mar 2023 02:59:15 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32BAwwm6124392;
        Sat, 11 Mar 2023 04:58:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678532338;
        bh=tqErNGN8GCxnj7ouBJQFYk0KzOZEy3ERGkSm9RoMdfQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KoI8mNG5VezjAK17iHrUl5D7/Rtrx2b4sVSVPabq1BtdVctltEzpsIrNwQgenKYG4
         /Rmdlzx8nrUW7TwIaLyr2JfpdjMeRYO30nGGUkwxrvSF8RuB27CWDDCHw0ymoYf604
         kNdqnetHz8Z353+MR1wtt1tirJ8Hfzvt32cDtJlM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32BAwwEH102711
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 11 Mar 2023 04:58:58 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sat, 11
 Mar 2023 04:58:58 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sat, 11 Mar 2023 04:58:58 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32BAwwol028037;
        Sat, 11 Mar 2023 04:58:58 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Julien Panis <jpanis@baylibre.com>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am62: Add watchdog nodes
Date:   Sat, 11 Mar 2023 04:58:50 -0600
Message-ID: <20230311105850.21811-3-nm@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230311105850.21811-1-nm@ti.com>
References: <20230311105850.21811-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Panis <jpanis@baylibre.com>

Add nodes for watchdogs :
- 5 in main domain
- 1 in MCU domain
- 1 in wakeup domain

Signed-off-by: Julien Panis <jpanis@baylibre.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V3:
- Dropped the board level wdt reservation, do that with overlays based on
  modifiable firmware dependencies.

V3: https://lore.kernel.org/all/20221109093026.103790-2-jpanis@baylibre.com/

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi   | 45 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi    |  9 +++++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 11 ++++++
 3 files changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index ea683fd77d6a..90d5f145de4f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -758,6 +758,51 @@ main_mcan0: can@20701000 {
 		status = "disabled";
 	};
 
+	main_rti0: watchdog@e000000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x0e000000 0x00 0x100>;
+		clocks = <&k3_clks 125 0>;
+		power-domains = <&k3_pds 125 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 125 0>;
+		assigned-clock-parents = <&k3_clks 125 2>;
+	};
+
+	main_rti1: watchdog@e010000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x0e010000 0x00 0x100>;
+		clocks = <&k3_clks 126 0>;
+		power-domains = <&k3_pds 126 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 126 0>;
+		assigned-clock-parents = <&k3_clks 126 2>;
+	};
+
+	main_rti2: watchdog@e020000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x0e020000 0x00 0x100>;
+		clocks = <&k3_clks 127 0>;
+		power-domains = <&k3_pds 127 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 127 0>;
+		assigned-clock-parents = <&k3_clks 127 2>;
+	};
+
+	main_rti3: watchdog@e030000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x0e030000 0x00 0x100>;
+		clocks = <&k3_clks 128 0>;
+		power-domains = <&k3_pds 128 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 128 0>;
+		assigned-clock-parents = <&k3_clks 128 2>;
+	};
+
+	main_rti4: watchdog@e0f0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x0e0f0000 0x00 0x100>;
+		clocks = <&k3_clks 130 0>;
+		power-domains = <&k3_pds 130 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 130 0>;
+		assigned-clock-parents = <&k3_clks 130 2>;
+	};
+
 	epwm0: pwm@23000000 {
 		compatible = "ti,am64-epwm", "ti,am3352-ehrpwm";
 		#pwm-cells = <3>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
index a427231527c3..bec118921c4c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
@@ -130,4 +130,13 @@ mcu_gpio0: gpio@4201000 {
 		clocks = <&k3_clks 79 0>;
 		clock-names = "gpio";
 	};
+
+	mcu_rti0: watchdog@4880000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x04880000 0x00 0x100>;
+		clocks = <&k3_clks 131 0>;
+		power-domains = <&k3_pds 131 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 131 0>;
+		assigned-clock-parents = <&k3_clks 131 2>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index fec81546fbbd..7726ebae2539 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -50,4 +50,15 @@ wkup_rtc0: rtc@2b1f0000 {
 		power-domains = <&k3_pds 117 TI_SCI_PD_EXCLUSIVE>;
 		wakeup-source;
 	};
+
+	wkup_rti0: watchdog@2b000000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2b000000 0x00 0x100>;
+		clocks = <&k3_clks 132 0>;
+		power-domains = <&k3_pds 132 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 132 0>;
+		assigned-clock-parents = <&k3_clks 132 2>;
+		/* Used by DM firmware */
+		status = "reserved";
+	};
 };
-- 
2.37.2

