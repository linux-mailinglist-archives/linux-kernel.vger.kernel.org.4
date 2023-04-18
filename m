Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5366E5667
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDRB13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDRB11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:27:27 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F79D4EE9;
        Mon, 17 Apr 2023 18:27:25 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33I1RIUt038979;
        Mon, 17 Apr 2023 20:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681781238;
        bh=bd1V+OA6abQ2J2wCLc1orzV2wqMWVk4jslQIZs2biu0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NTMjX+Ff1IXFdqd+domIz77Z802KzzK4llL+oL03XLZ5RDKcdgurbrohz+s6ITerr
         FiqHvtguNrjTvuljJ3JQMI0LomC57u2ewU9kqgJF59qwaByjYxiCJjCgOOdWxyfWYs
         auuc3eiD7jWKcZmZq+j2Fhu9/xunAIq0NkW4og8Q=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33I1RIxc107372
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Apr 2023 20:27:18 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 17
 Apr 2023 20:27:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 17 Apr 2023 20:27:18 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33I1RIwd041847;
        Mon, 17 Apr 2023 20:27:18 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-am62a: Add watchdog nodes
Date:   Mon, 17 Apr 2023 20:27:16 -0500
Message-ID: <20230418012717.1230882-3-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418012717.1230882-1-nm@ti.com>
References: <20230418012717.1230882-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for watchdogs:
- 5 in main domain
- 1 in MCU domain
- 1 in wakeup domain

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   | 45 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi    | 11 +++++
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 11 +++++
 3 files changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 59d1199e43c9..e43e64451bc1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -697,6 +697,51 @@ main_mcan0: can@20701000 {
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
+	main_rti4: watchdog@e040000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x0e040000 0x00 0x100>;
+		clocks = <&k3_clks 205 0>;
+		power-domains = <&k3_pds 205 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 205 0>;
+		assigned-clock-parents = <&k3_clks 205 2>;
+	};
+
 	epwm0: pwm@23000000 {
 		compatible = "ti,am64-epwm", "ti,am3352-ehrpwm";
 		#pwm-cells = <3>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
index 50c94a55fe85..04599762c2b7 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
@@ -132,4 +132,15 @@ mcu_gpio0: gpio@4201000 {
 		clock-names = "gpio";
 		status = "disabled";
 	};
+
+	mcu_rti0: watchdog@4880000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x04880000 0x00 0x100>;
+		clocks = <&k3_clks 131 0>;
+		power-domains = <&k3_pds 131 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 131 0>;
+		assigned-clock-parents = <&k3_clks 131 2>;
+		/* Tightly coupled to M4F */
+		status = "reserved";
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
index 81d984414fd4..d848eb24b552 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
@@ -51,4 +51,15 @@ wkup_rtc0: rtc@2b1f0000 {
 		wakeup-source;
 		status = "disabled";
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
2.40.0

