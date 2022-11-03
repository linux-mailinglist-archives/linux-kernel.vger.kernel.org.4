Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D62618695
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiKCRtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiKCRsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:48:25 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1091E707;
        Thu,  3 Nov 2022 10:47:57 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A3HlnS1005482;
        Thu, 3 Nov 2022 12:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667497669;
        bh=bfif87wg+UZ5LRcuTBAAJkNhHmkMh8GtayVffgUF4js=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=r44Fg1pfTcfc5qGoFZU3gPsEOYWfsErlpx8cE4vzExTqEFdmhqmxkLEeflsGuT9Sr
         feQxtiqMOUJ/nPkchZi0l6SFM2hL/brWxUF2N3mqdaL/aKP4SRJaw/XNTmDXRNlQI8
         kTiuOZ7++PxPnwI5K5wE3eEjWoewUGcDF6uN7wpQ=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A3Hln4W031331
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Nov 2022 12:47:49 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 3 Nov
 2022 12:47:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 3 Nov 2022 12:47:49 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A3Hlmq1090755;
        Thu, 3 Nov 2022 12:47:49 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <r-ravikumar@ti.com>, <jkridner@gmail.com>
Subject: [PATCH v7 1/2] arm64: dts: ti: k3-j721e-main: Add dts nodes for EHRPWMs
Date:   Thu, 3 Nov 2022 23:17:42 +0530
Message-ID: <20221103174743.16827-2-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221103174743.16827-1-r-ravikumar@ti.com>
References: <20221103174743.16827-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijay Pothukuchi <vijayp@ti.com>

Add dts nodes for 6 EHRPWM instances on SoC

Signed-off-by: Vijay Pothukuchi <vijayp@ti.com>
Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 68 ++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 5c4a0e28cde5..bc3146e24816 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -66,7 +66,73 @@ usb_serdes_mux: mux-controller@4000 {
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x4000 0x8000000>, /* USB0 to SERDES0/3 mux */
 					<0x4010 0x8000000>; /* USB1 to SERDES1/2 mux */
-	    };
+		};
+
+		ehrpwm_tbclk: clock-controller@4140 {
+			compatible = "ti,am654-ehrpwm-tbclk", "syscon";
+			reg = <0x4140 0x18>;
+			#clock-cells = <1>;
+		};
+	};
+
+	main_ehrpwm0: pwm@3000000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3000000 0x00 0x100>;
+		power-domains = <&k3_pds 83 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 83 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm1: pwm@3010000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3010000 0x00 0x100>;
+		power-domains = <&k3_pds 84 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 84 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm2: pwm@3020000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3020000 0x00 0x100>;
+		power-domains = <&k3_pds 85 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 85 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm3: pwm@3030000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3030000 0x00 0x100>;
+		power-domains = <&k3_pds 86 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 86 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm4: pwm@3040000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3040000 0x00 0x100>;
+		power-domains = <&k3_pds 87 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 87 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm5: pwm@3050000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3050000 0x00 0x100>;
+		power-domains = <&k3_pds 88 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 88 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	gic500: interrupt-controller@1800000 {
-- 
2.38.0

