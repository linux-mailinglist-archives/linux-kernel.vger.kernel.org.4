Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AC6652C88
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 06:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiLUFwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 00:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLUFwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 00:52:08 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C661DA6F;
        Tue, 20 Dec 2022 21:52:06 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BL5pvaX088946;
        Tue, 20 Dec 2022 23:51:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671601918;
        bh=3S4ZeUleyG+PnGNO2verHlttc0+y095lVFPc0EWwtkw=;
        h=From:To:CC:Subject:Date;
        b=bm9rMRRtJ/3eFqO0KuWIurW22/fIrzbeO/ymAzxLdvHUG+Zy34u/nh6S75g/yCVDq
         qgagMHxS0OEJf7A6L4Tp7QO9h3wM/FiH/8UrUISR6Y2YhNWAUH2BXB4bsn0nXwt6h8
         U9ou12Wj085q+4MX2OcGnymuAJWrB3NSBCqRJhns=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BL5pvOC027818
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Dec 2022 23:51:57 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 20
 Dec 2022 23:51:57 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 20 Dec 2022 23:51:57 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BL5poGD003821;
        Tue, 20 Dec 2022 23:51:55 -0600
From:   Bhavya Kapoor <b-kapoor@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <nm@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-j721s2: Add support for ADC nodes
Date:   Wed, 21 Dec 2022 11:21:44 +0530
Message-ID: <20221221055144.7181-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
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

J721s2 has two instances of 8 channel ADCs in MCU domain. Add DT nodes
for 8 channel ADCs for J721s2 SoC.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---

Changelog v1 -> v2:
	- Updated Interrupt Values for tscadc

 .../dts/ti/k3-j721s2-common-proc-board.dts    | 14 +++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 42 ++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index a7aa6cf08acd..67593aa69327 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -309,3 +309,17 @@ &mcu_mcan1 {
 	pinctrl-0 = <&mcu_mcan1_pins_default>;
 	phys = <&transceiver2>;
 };
+
+&tscadc0 {
+	status = "okay";
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
+};
+
+&tscadc1 {
+	status = "okay";
+	adc {
+		ti,adc-channels = <0 1 2 3 4 5 6 7>;
+	};
+};
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 0af242aa9816..8673eb1309c3 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -306,4 +306,44 @@ cpts@3d000 {
 			ti,cpts-periodic-outputs = <2>;
 		};
 	};
-};
+
+	tscadc0: tscadc@40200000 {
+		compatible = "ti,am3359-tscadc";
+		reg = <0x0 0x40200000 0x0 0x1000>;
+		interrupts = <GIC_SPI 860 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 0 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 0 0>;
+		assigned-clocks = <&k3_clks 0 2>;
+		assigned-clock-rates = <60000000>;
+		clock-names = "adc_tsc_fck";
+		dmas = <&main_udmap 0x7400>,
+			<&main_udmap 0x7401>;
+		dma-names = "fifo0", "fifo1";
+		status = "disabled";
+
+		adc {
+			#io-channel-cells = <1>;
+			compatible = "ti,am3359-adc";
+		};
+	};
+
+	tscadc1: tscadc@40210000 {
+		compatible = "ti,am3359-tscadc";
+		reg = <0x0 0x40210000 0x0 0x1000>;
+		interrupts = <GIC_SPI 861 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 1 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 1 0>;
+		assigned-clocks = <&k3_clks 1 2>;
+		assigned-clock-rates = <60000000>;
+		clock-names = "adc_tsc_fck";
+		dmas = <&main_udmap 0x7402>,
+			<&main_udmap 0x7403>;
+		dma-names = "fifo0", "fifo1";
+		status = "disabled";
+
+		adc {
+			#io-channel-cells = <1>;
+			compatible = "ti,am3359-adc";
+		};
+	};
+ };
\ No newline at end of file
-- 
2.37.2

